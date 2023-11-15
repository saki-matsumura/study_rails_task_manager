module LoginSupport
  def login(user)
    fill_in 'session[email]', with: user.email
    fill_in 'session[password]', with: user.password
    click_button 'Log in'
    # binding.irb
  end
end