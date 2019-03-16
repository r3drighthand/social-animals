class UsersController < ApplicationController
  skip_before_action :require_login, only: [:index, :new, :create]

  # def index; end

  def create
    @user = User.new(user_params[:email], user_params[:password])
    if @user.save
      redirect_to(:users, notice: "User was successfully created")
    else
      render 'new'
    end
  end

  private
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
