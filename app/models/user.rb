require 'openssl'

class User < ActiveRecord::Base
  # параметры работы модуля шифрования паролей
  ITERATIONS = 20000
  DIGEST = OpenSSL::Digest::SHA256.new

  has_many :questions

  validates :email,
            presence: true,
            uniqueness: true,
            format: {
                with: /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/,
                message: "must be correct!"
            }

  validates :username,
            presence: true,
            uniqueness: true,
            length: {
                maximum: 40,
                too_long: "%{count} characters is the maximum allowed"
            },
            format: {
                with: /\A[a-zA-Z0-9_]+\z/,
                message: "only with Latin letters, Numbers and _ is allowed!"
            }

  attr_accessor :password

  validates_presence_of :password, on: :create
  validates_confirmation_of :password

  before_validation :username_downcase
  before_save :encrypt_password

  def username_downcase
    self.username = self.username.downcase
  end

  # шифруем пароль, если он задан
  def encrypt_password
    if self.password.present?

      # создаем "соль" - рандомная строка
      self.password_salt = User.hash_to_string(OpenSSL::Random.random_bytes(16))

      # создаем хэш пароля — длинная уникальная строка, из которой невозможно восстановить
      # исходный пароль
      self.password_hash = User.hash_to_string(
          OpenSSL::PKCS5.pbkdf2_hmac(self.password, self.password_salt, ITERATIONS, DIGEST.length, DIGEST)
      )
    end
    # оба поля окажутся записанными в базу
  end

  # служебный метод, преобразующий бинарную строку в 16-ричный формат, для удобства хранения
  def self.hash_to_string(password_hash)
    password_hash.unpack('H*')[0]
  end

  def self.authenticate(email, password)
    user = find_by(email: email) # сперва находим кандидата по email

    # сравнивается password_hash, а оригинальный пароль нигде не сохраняется
    if user.present? && user.password_hash == User.hash_to_string(OpenSSL::PKCS5.pbkdf2_hmac(password, user.password_salt, ITERATIONS, DIGEST.length, DIGEST))
      user
    else
      nil
    end
  end
end
