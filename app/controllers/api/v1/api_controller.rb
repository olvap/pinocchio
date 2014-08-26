class Api::V1::ApiController < ActionController::Base

  protect_from_forgery

  skip_before_action :verify_authenticity_token, if: :json_request?

  before_action :authenticate

  helper_method :current_user

  protected

  def json_request?
    request.format.json?
  end

  def authenticate
    authenticate_token || render_unauthorized
  end

  def authenticate_token
    authenticate_with_http_token do |token, options|
      @current_user ||= User.find_by(api_auth_token: token)
    end
  end

  def render_unauthorized
    self.headers['WWW-Authenticate'] = 'Token realm="Application"'
    render json: 'Bad credentials', status: 401
  end

  def current_user
    @current_user
  end
end