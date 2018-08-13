class Validate
  def self.login(username, password)
    user = User.find_by(username: username)
    user && password == user.password
  end

  def self.register(email, password, reenter_password)
    if password.length < 6 || password.length > 32
      return 'Your password must be between 6 and 32 characters.'
    end

    if password != reenter_password
      return 'Your passwords do not match.'
    end

    unless /.+@.+\.\w+/.match(email)
      return 'You must enter a valid email address. (e.g. example@example.com)'
    end

    true
  end
end