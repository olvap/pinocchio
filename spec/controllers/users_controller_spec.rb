require 'rails_helper'

describe UsersController do 

  let!(:current_user) { create(:user) }

  describe "POST #create" do

    context "with valid attributes" do
      let!(:user_attributes) { { first_name: 'Sofia', last_name: 'Braun', email: 'sofi.braun@gmail.com', password: '123456', password_confirmation: '123456' } }

      it "redirect to the root path" do
        post :create, user: user_attributes
        expect(response).to redirect_to(root_path)
      end

      it "creates the user" do
        expect {
          post :create, user: user_attributes  
        }.to change(User, :count).by(1)
      end

      it "authenticates the user" do
        post :create, user: user_attributes
        user = User.last
        expect(response.cookies['auth_token']).to eq(user.auth_token)
      end
    end

    context "with invalid attributes" do

      let!(:user_attributes) { { first_name: 'Sofia' } }

      it "renders the new template" do
        post :create, user: user_attributes
        expect(response).to render_template(:new)
      end
    end
  end

  describe "PUT #update" do

    before(:each) do
      allow_any_instance_of(ApplicationController).to receive(:current_user) { current_user }
    end

    context "with valid attributes" do
      let!(:user_attributes) { { first_name: 'Sofia', last_name: 'Braun', email: 'sofi.braun@gmail.com' } }

      it "redirect to the show page" do
        put :update, id: current_user.id, user: user_attributes
        expect(response).to redirect_to(user_path(current_user))
      end
    end

    context "with invalid attributes" do

      let!(:user_attributes) { { first_name: '' } }

      it "renders the edit template" do
        put :update, id: current_user.id, user: user_attributes
        expect(response).to render_template(:edit)
      end
    end

    context "when not the current user" do

      let!(:user_attributes) { { first_name: 'Sofia', last_name: 'Braun' } }
      let!(:another_user) { create(:user) }

      before(:each) do
        allow_any_instance_of(ApplicationController).to receive(:current_user) { another_user }
      end

      it "renders the unauthorized page" do
        expect_any_instance_of(ApplicationController).to receive(:render_unauthorized)
        put :update, id: current_user.id, user: user_attributes
      end
    end
  end

  describe "DELETE #destroy" do

    context "when current user" do

      before(:each) do
        allow_any_instance_of(ApplicationController).to receive(:current_user) { current_user }
      end

      it "deletes a user" do
        expect {
          delete :destroy, id: current_user.id
        }.to change(User, :count).by(-1)
      end
    end

    context "when is not current user" do

      before(:each) do
        allow_any_instance_of(ApplicationController).to receive(:current_user) { build(:user) }
      end

      it "does not delete the user" do
        expect {
          delete :destroy, id: current_user.id
        }.to_not change(User, :count)
      end
    end
  end
end