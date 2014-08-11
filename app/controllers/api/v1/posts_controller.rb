class Api::V1::PostsController < Api::V1::ApiController
  skip_before_filter :authenticate, only: [:show, :index]

	def index
		render json: { posts: Post.all }
	end

	def show
		post = Post.find params[:id]
		render json: post
	end

  def create
    post = Post.new(post_params || {})
    post.user = current_user
    if post.save
      render json: post, status: 201
    else
      render json: post.errors.to_s, status: 500
    end
  end

  def destroy
    post = Post.find(params[:id])
    if current_user == post.user
      post.destroy
      head 204
    else
      head 403
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :body) if params[:post].present?
  end
end
