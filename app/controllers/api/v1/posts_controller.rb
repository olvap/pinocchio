class Api::V1::PostsController < Api::V1::ApiController
  skip_before_filter :authenticate, only: [:show, :index]

	def index
		render json: { posts: Post.all }
	end

	def show
		post = Post.find params[:id]
		render json: post
	end
end
