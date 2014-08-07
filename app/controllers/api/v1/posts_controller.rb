class Api::V1::PostsController < ApplicationController
	respond_to :json
	skip_before_filter :authenticate_user

	def index
		render json: { posts: Post.all }
	end
end
