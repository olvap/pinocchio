require 'rails_helper'

describe PasswordResetsController do 

  let!(:user) { create(:user) }

  describe "POST #create" do

    it "with valid user redirect to root path" do
      user_attributes = {user_email: user.email}
      post :create, user_attributes
      expect(response).to redirect_to(root_path)
      
    end

    it "with invalid attributes renders login path" do
      user_attributes = {user_email: 'otheremail@gmail.com'}
      post :create, user_attributes
      expect(response).to redirect_to(login_path)
    end
  end

  describe "PUT #update" do
    
    context "with valid user" do

      let!(:user_attributes) { { password: '78910', password_confirmation: '78910'} }
      
      it "resets password with valid token" do
        user.send_password_reset
        put :update, id: user.password_reset_token, user: user_attributes
        expect(response).to redirect_to(root_url)
      end

      it "redirects to login path with expired token" do
        user.send_password_reset
        user.password_reset_sent_at = 3.hours.ago
        user.save!
        put :update, id: user.password_reset_token, user: user_attributes
        expect(response).to redirect_to(login_path)
      end

      it "redirects to edit path with invalid attributes" do
        user.send_password_reset
        put :update, id: user.password_reset_token, user: {password: '78910', password_confirmation: '123456'}
        expect(response).to render_template(:edit)
      end

    end

    context "with invalid user" do
      it "redirect to the root path" do
        put :update, id: '123455', user: { password: '78910', password_confirmation: '78910'}
        expect(response).to redirect_to(login_path)
      end
    end
  end
end