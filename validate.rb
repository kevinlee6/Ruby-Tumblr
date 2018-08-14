class Validate
  def self.login(email, password)
    user = User.find_by(email: email)
    user && password == user.password
  end

  def self.register(email, password, reenter_password, birthday)
    if password.length < 6 || password.length > 32
      return 'Your password must be between 6 and 32 characters.'
    end

    if password != reenter_password
      return 'Your passwords do not match.'
    end

    unless /.+@.+\.\w+/.match(email)
      return 'You must enter a valid email address. (e.g. example@example.com)'
    end

    unless /\d{2}-\d{2}-\d{4}/.match(birthday)
      return 'Your birthday must be in MM-DD-YYYY format.'
    end

    true
  end
end