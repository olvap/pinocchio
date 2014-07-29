require 'rails_helper'

describe PostsController do 

  let!(:current_user) { create(:user) }

  before(:each) do
    allow_any_instance_of(ApplicationController).to receive(:current_user) { current_user }
  end

   describe "GET #index" do

    let!(:post) { create(:post) }
    let!(:other_post) { create(:post) }

    it "renders the index template" do
      get :index
      expect(response).to render_template(:index)
      expect(assigns(:posts)).to eq([post, other_post])
    end
    
  end

  describe "POST #create" do

    context "with valid attributes" do
      let!(:post_attributes) { { title: 'The Pillars of the Earth', body: 'Jack is a master builder in love with Aliena.' } }

      it "redirect to the show page" do
        post :create, post: post_attributes
        expect(response).to redirect_to(post_path(Post.last))
      end

      it "creates the post" do
        expect {
          post :create, post: post_attributes  
        }.to change(Post, :count).by(1)
      end
    end

    context "with invalid attributes" do

      let!(:post_attributes) { { title: 'The Pillars of the Earth' } }

      it "renders the new template" do
        post :create, post: post_attributes
        expect(response).to render_template(:new)
      end
    end
  end

  describe "PUT #update" do

    let!(:post) { create(:post, user: current_user) }

    context "with valid attributes" do
      let!(:post_attributes) { { title: 'The Pillars of the Earth', body: 'Jack is a master builder in love with Aliena.' } }

      it "redirect to the show page" do
        put :update, id: post.id, post: post_attributes
        expect(response).to redirect_to(post_path(post))
      end
    end

    context "with invalid attributes" do

      let!(:post_attributes) { { title: '' } }

      it "renders the edit template" do
        put :update, id: post.id, post: post_attributes
        expect(response).to render_template(:edit)
      end
    end

    context "when not the owner of the post" do

      let!(:post_attributes) { { title: 'The Pillars of the Earth', body: 'Jack is a master builder in love with Aliena.' } }
      let!(:another_user) { create(:user) }

      before(:each) do
        allow_any_instance_of(ApplicationController).to receive(:current_user) { another_user }
      end

      it "renders the unauthorized page" do
        expect_any_instance_of(ApplicationController).to receive(:render_unauthorized)
        put :update, id: post.id, post: post_attributes
      end
    end
  end

  describe "DELETE #destroy" do

    let!(:post) { create(:post, user: current_user) }

    context "when the owner of the post" do

      before(:each) do
        allow_any_instance_of(ApplicationController).to receive(:current_user) { current_user }
      end

      it "deletes a post" do
        expect {
          delete :destroy, id: post.id
        }.to change(Post, :count).by(-1)
      end
    end

    context "when not the owner of the post" do

      before(:each) do
        allow_any_instance_of(ApplicationController).to receive(:current_user) { create(:user) }
      end

      it "does not delete the post" do
        expect {
          delete :destroy, id: post.id
        }.to_not change(Post, :count)
      end
    end
  end
end