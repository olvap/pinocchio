class UsersController < ApplicationController

  before_action :authorize_resource, except: [:show, :index]
  prepend_before_action :set_user, except: [:index]

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
      render :edit    
    end    
  end

  def edit
  end

  def update
    @user.update_attributes(user_params)
    render :edit
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
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end

  def authorize_resource      
    authorize(@user)
  end    
  
  
end
