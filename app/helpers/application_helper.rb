module ApplicationHelper
  def user_avatar(user)
    if user.avatar_url.present?
      user.avatar_url
    else
      asset_path 'profile-default.png'
    end
  end

  def pluralize_russian(number, krokodil, krokodila, krokodilov)

    ostatok = number % 10
    ostatok100 = number % 100

    if ostatok100 >= 11 && ostatok100 <= 14
      return "#{number} #{krokodilov}"
    elsif ostatok == 1
      return "#{number} #{krokodil}"
    elsif ostatok >= 2 && ostatok <= 4
      return "#{number} #{krokodila}"
    elsif ostatok > 4 || ostatok == 0
      return "#{number} #{krokodilov}"
    end
  end
end
