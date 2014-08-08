class Api::V1::PostsController < ApplicationController
	respond_to :json
	skip_before_filter :authenticate_user

	def index
		render json: { posts: Post.all }
	end

	def show
		post = Post.find params[:id]
		render json: post
	end
end
