module ApplicationHelper
  def user_avatar(user)
    if user.avatar_url.present?
      user.avatar_url
    else
      asset_path 'profile-default.png'
    end
  end

  # Font Awesome Helper
  def fa_icon(icon_class)
    content_tag 'span', '', class: "fa fa-#{icon_class}"
  end

  def pluralize_russian(number, krokodil, krokodila, krokodilov)

    ostatok = number % 10
    ostatok100 = number % 100

    if ostatok100 >= 11 && ostatok100 <= 14
      return "#{krokodilov}"
    elsif ostatok == 1
      return " #{krokodil}"
    elsif ostatok >= 2 && ostatok <= 4
      return "#{krokodila}"
    elsif ostatok > 4 || ostatok == 0
      return "#{krokodilov}"
    end
  end
end
