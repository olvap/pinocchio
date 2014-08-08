require 'rails_helper'

describe Api::V1::PostsController do

	describe "GET #index" do
		let!(:post) { create(:post) }
		let!(:other_post) { create(:post) }

		it "renders the json index" do
			get :index, format: :json
			expect(response).to have_http_status(:success)
			expect(response.header['Content-Type']).to include Mime::JSON
			expect(json).to have_key('posts')
			expect(json['posts'].size).to eq(2)
		end
	end

	describe "GET #show" do
		let!(:post) { create(:post) }

		it "renders the json post" do
			get :show, id: post, format: :json
			expect(response).to have_http_status(:success)
			expect(response.header['Content-Type']).to include Mime::JSON
			expect(json).to eq(active_record_to_json post)
		end
	end
end
