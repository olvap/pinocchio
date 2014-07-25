require 'rails_helper'

describe ApplicationController do

  controller do
    before_filter :authorize_resource, only: [:index]

    def index
      render nothing: true
    end

    def new
      render nothing: true
    end

    def authorize_resource
      authorize(nil)
    end
  end

  describe "#render_unauthorized" do

    let!(:current_user) { build_stubbed(:user) }

    before(:each) do
      allow_any_instance_of(ApplicationController).to receive(:current_user) { current_user }
      allow_any_instance_of(ApplicationController).to receive(:policy) { double(index?: false) }
    end

    it "renders the unauthorized page" do
      get :index
      expect(response).to render_template(file: "#{Rails.root}/public/422.html")
      expect(response.status).to eq(422)
    end
  end

  describe "#authenticate_user" do

    let!(:current_user) { build_stubbed(:user) }

    context "when user is logged in" do

      before(:each) do
        allow_any_instance_of(ApplicationController).to receive(:current_user) { current_user }
      end

      it "return 200 status" do      
        get :new      
        expect(response.status).to eq(200)
      end  

    end

    context "when user is not logged in" do
      it "renders login page" do      
        get :new      
        expect(response).to redirect_to(login_path)
      end  
    end
  end
end