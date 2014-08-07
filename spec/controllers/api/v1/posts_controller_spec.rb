require 'rails_helper'

describe Api::V1::PostsController do

	describe "GET #index" do
		let!(:post) { create(:post) }
		let!(:other_post) { create(:post) }

		it "renders the json index" do
			get :index, format: :json
			expect(response.status).to eq(200)
			expect(response.header['Content-Type']).to include Mime::JSON
			expect(json).to have_key('posts')
			expect(json['posts'].size).to eq(2)
		end
	end
end
