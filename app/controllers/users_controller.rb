class UsersController < ApplicationController

def new
	@user = User.new
end

def create
	puts params[:user][:profile_image]
	@user = User.new user_params
	@user.save
end

def user_params
  params.require(:user).permit(:profile_image)
end

end
