class TasksController < ApplicationController
  def create
  	if !current_user
  		flash[:errors] = ["Must be logged in to create task"]
  		redirect_to "/"
  		return
  	end
  	puts params
  	@user = current_user
  	@description = params[:task][:description]
  	Task.create(user: @user, description: @description, completed: false)
  	puts Task.all
  	redirect_to "/task_manager/user/#{@user.id}"
  end

  def update
  end

  def tasks_by_user
  	@user = current_user
  	@tasks = Task.where(user: @user)
  	render :json => @tasks
  end


end
