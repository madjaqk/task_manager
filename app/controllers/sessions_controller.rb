class SessionsController < ApplicationController
  def register
  	if current_user
  		redirect_to "/task_manager/user/#{session[:user_id]}" 
  		return
  	end
  	@user = User.new
  	render "register"
  end

  def new
  	user = User.find_by email: params[:email]
  	if user
  		if user.authenticate(params[:password])
  			session[:user_id] = user.id
  			redirect_to "/task_manager/user/#{user.id}"
  			return
  		else
  			flash[:errors] = ["Incorrect password"]
  		end
  	else
  		flash[:errors] = ["E-mail address not found"]
  	end
	redirect_to "/"
  end

  def logout
  	session[:user_id] = nil
  	redirect_to "/"
  end
end
