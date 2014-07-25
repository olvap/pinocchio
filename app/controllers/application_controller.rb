class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception

  helper_method :current_user, :policy

  before_filter :authenticate_user

  def authorize(record)
    render_unauthorized unless policy(record).public_send(params[:action] + '?')
  end

  def policy(record)
    "#{record.class}Policy".constantize.new(current_user, record)
  end

  def render_unauthorized
    render("#{Rails.root}/public/422", formats: [:html], status: 422, layout: false)
  end

  private

  def authenticate_user
    if current_user.nil?
      redirect_to login_path
    end
  end

  def current_user
    if cookies[:auth_token].present?
      @current_user ||= User.where(auth_token: cookies[:auth_token]).first
    end
  end
end