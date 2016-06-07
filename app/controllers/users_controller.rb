class UsersController < ApplicationController
  def create
  	@user = User.new(user_params)
  	@user.save
  	session[:user_id] = @user.id
  	redirect_to "/task_manager/user/#{@user.id}"
  end

  def show
  	@user = User.find(params[:id])
  	if @user != current_user
  		redirect_to "/"
  		return
  	end
  	@tasks = Task.where(user: @user)
  	@new_task = Task.new
  end

  private
  def user_params
  	params.require(:user).permit(:name, :email, :password)
  end
end
