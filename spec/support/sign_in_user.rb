require 'capybara'
require 'capybara/dsl'

module LoginMacros
  include Capybara::DSL

  def sign_in_user(user)
    visit login_path
    fill_in "email", with: user.email
    fill_in "password", with: user.password
    click_on "New"
  end
end