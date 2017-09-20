class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update]
  before_action :correct_user, only: [:edit, :update]

  def show
  @user = User.find(params[:id])
  end 

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      # Handle a successful save
      log_in @user
      flash[:success] = "Welcome to Raleigh's sample app!"

      redirect_to @user
      # note: the line above is equivalent to redirect_to user_url(@user)

    else
      render 'new'
    end
  end

  def edit
    @user = User.find( params[:id] )
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params) # returns true only on succesful update!
      # Handle a successful update.
      flash[:success] = "Profile has been successfully updated!"
      redirect_to (@user)
    else
      render 'edit'
    end
  end

  private
    # Always indent private methods
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

  def logged_in_user
  unless logged_in?
    store_location
    flash[:danger] = "Please log in before continuing."
    redirect_to login_url
  end
  end

  def correct_user
    @user = User.find(params[:id])
    #redirect_to(root_url) unless @user == current_user
    redirect_to(root_url) unless current_user?(@user)
  end

end
