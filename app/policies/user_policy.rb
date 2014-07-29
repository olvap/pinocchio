class UserPolicy
  attr_reader :current_user, :user

  def initialize(current_user, user)
    @current_user = current_user
    @user = user    
  end

  def edit?
    same_user?
  end

  def update?
    same_user?
  end

  def destroy?
    same_user?
  end

private

  def same_user?
    current_user == user
  end  
  
end