class UserSessionsController < ApplicationController
  skip_before_action :require_login, only: [:index, :create]

  def new
    @user = User.new
  end

  def create
    @user = login(user_params[:email], user_params[:password])

    if @user 
      redirect_back_or_to(:users, notice: 'Login successful')
    else
      flash.now[:alert] = 'Login failed'
      render action: 'new'
    end
  end

  def destroy
    logout
    redirect_to(:users, notice: 'You\'ve been logged out')
  end

  private
  def user_params
    params.require(:user).permit(:email, :password)
  end
end
