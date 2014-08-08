class UsersController < ApplicationController

  before_action :authorize_resource, only: [:edit, :update, :destroy]
  prepend_before_action :set_user, except: [:index]
  skip_before_filter :authenticate_user, except: [:edit, :update, :destroy]

  def new
  end

  def show
  end

  def create
    if @user.save
      @user.authenticate(params[:password])
      cookies[:auth_token] = @user.auth_token
      redirect_to root_path
    else
      render :new    
    end    
  end

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      redirect_to @user, notice: 'User was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    if @user.destroy
      redirect_to root_path
    else
      render :edit
    end
  end

private

  def set_user
    @user ||= (
       if params[:id]
         User.find(params[:id])
       else
         User.new(user_params || {})
       end
    )
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :api_auth_token, :password, :password_confirmation) if params[:user].present?
  end

  def authorize_resource      
    authorize(@user)
  end    
  
  
end
