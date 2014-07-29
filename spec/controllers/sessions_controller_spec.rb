require 'rails_helper'

describe SessionsController do 

  let!(:user) { create(:user) }

  describe "POST #create" do

    context "with valid user" do
      let!(:user_attributes) { { email: user.email, password: '123456'} }

      it "redirect to the root path" do
        post :create, user_attributes
        expect(response).to redirect_to(root_path)
      end

      it "set cookies" do
        post :create, user_attributes
        expect(response.cookies['auth_token']).to eq(user.auth_token)
      end
    end

    context "with invalid attributes" do

      let!(:user_attributes) { { email: user.email } }

      it "renders the new template" do
        post :create, user: user_attributes
        expect(response).to render_template(:new)
      end
    end
  end

  describe "DELETE #destroy" do

    before(:each) do
      allow_any_instance_of(ApplicationController).to receive(:current_user) { user }
    end

    it "redirect to the root path" do
      delete :destroy, user: user
      expect(response).to redirect_to(root_path)
    end

    it "removes auth_token cookie" do
      delete :destroy, user: user
      expect(response.cookies['auth_token']).to be_nil
    end
  end
end