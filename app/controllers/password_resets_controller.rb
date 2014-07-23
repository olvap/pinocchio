class PasswordResetsController < ApplicationController

  def create
    user = User.find_by_email(params[:user_email])
    user.send_password_reset 
    redirect_to root_path, :notice => "Email sent with password reset instructions."
  end

  def edit
    @user = User.find_by_password_reset_token!(params[:id])
  end

  def update
    @user = User.find_by_password_reset_token!(params[:id])
    if @user.password_reset_sent_at < 2.hours.ago
      redirect_to login_path, :alert => "Password reset has expired."
    elsif @user.update_attributes(user_params)
      redirect_to root_url, :notice => "Password has been reset!"
    else
      render :edit
    end
  end

  def user_params
    params.require(:user).permit(:password, :id, :password_confirmation)
  end

end