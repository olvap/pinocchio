class Api::V1::PostsController < Api::V1::ApiController
  skip_before_filter :authenticate, only: [:show, :index]
  before_action :find_post, only: [:show, :update, :destroy]
  before_action :validate_ownership, only: [:update, :destroy]

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def index
    posts = Post.search_for(params[:query])
    posts = posts.page(params[:page]).per(15)
    render json: { posts: posts }
  end

  def show
    render json: @post
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
    @post.destroy
    head 204
  end

  def update
    render json: @post, status: 204
  end

  private

  def record_not_found
    render nothing: true, status: 404
  end

  def post_params
    params.require(:post).permit(:title, :body) if params[:post].present?
  end

  def find_post
    @post = Post.find(params[:id]) if params[:id].present?
  end

  def validate_ownership
    head 403 unless current_user == @post.user
  end
end
