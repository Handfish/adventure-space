class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      # Handle success
      log_in @user
      flash[:success] = "Welcome to Adventure Space!"
      redirect_to user_url(@user) 
    else
      render 'new'
    end

  end

  def show
    @user = User.find(params[:id])
  end

  private

    def user_params
      params.require(:user).permit(:name,
                                   :email,
                                   :password,
                                   :password_confirmation)
    end

end
