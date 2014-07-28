require 'rails_helper'

describe "Users" do

  let!(:user) { create(:user) }  

  context "when user is not logged in" do
    
    it "creates a new user" do
      visit root_path
      click_link "Sign Up"
      expect {
        fill_in 'user_first_name', with: 'Sofia' 
        fill_in 'user_last_name', with: 'Braun'
        fill_in 'user_email', with: 'sofi.braun@gmail.com'
        fill_in 'user_password', with: '123456'
        fill_in 'user_password_confirmation', with: '123456'
        click_button "Save"
      }.to change(User, :count).by(1)       
    end

    it "shows a user" do
      visit user_path(user)
      expect(find(:css, "#first_name").text).to eq(user.first_name)
      expect(find(:css, "#last_name").text).to eq(user.last_name)
      expect(find(:css, "#email").text).to eq(user.email)
    end
  end

  context "when user logged in" do
    
    before(:each) do
      sign_in_user(user)
    end

    it "edits a user" do 
      expect {
        visit edit_user_path(user)
        fill_in :user_first_name, with: 'Maria'
        click_button "Save"
        user.reload
      }.to change(user, :first_name).to('Maria')
    end
  end
end