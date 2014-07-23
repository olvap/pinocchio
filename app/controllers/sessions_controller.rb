class SessionsController < ApplicationController

  skip_before_filter :authenticate_user!, only: [:new, :create]

  def new
  end

  def create
    user = User.where(email: params[:email]).first
    if user && user.authenticate(params[:password])
      if params[:remember_me]
        cookies.permanent[:auth_token] = user.auth_token
      else
        cookies[:auth_token] = user.auth_token
      end      
      redirect_to root_path
    else
      render :new
    end
  end

  def destroy
    cookies.delete(:auth_token)
    redirect_to root_path
  end
end