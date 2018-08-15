class Validate
  def self.login(email, password)
    user = User.find_by(email: email)
    user && password == user.password
  end

  def self.register(email, password, reenter_password, firstname, lastname, birthday)
    error_list = []

    if firstname.length == 0
      error_list.push('You must enter a first name.')
    end

    if lastname.length == 0
      error_list.push('You must enter a last name.')
    end

    unless /.+@.+\.\w+/.match(email)
      error_list.push('You must enter a valid email address. (e.g. example@example.com)')
    end

    if password.length < 6 || password.length > 32
      error_list.push('Your password must be between 6 and 32 characters.')
    end

    if password != reenter_password
      error_list.push('Your passwords do not match.')
    end

    birthdayArr = birthday.split('-')
    if birthdayArr.length != 3
      error_list.push('Birthday must be in MM-DD-YYYY format.')
    else
      unless birthdayArr[0].to_i.between?(1, 12) &&
             birthdayArr[1].to_i.between?(1, 31) &&
             birthdayArr[2].to_i.between?(1900, Time.new.year)
        error_list.push("Either the month (1-12), day (1-31), or year (1900-#{Time.new.year} is not valid.")
      end
    end

    error_list.length > 0 ? error_list : true
  end

  def self.post(title)
    if title.length == 0
      return 'You must have a title.'
    end

    true
  end
end