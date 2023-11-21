class UsersController < ApplicationController
  before_action :set_current_user, only: [:show, :edit, :update, :destroy]

  def user_params
    params.require(:user).permit(:name, :email, :address,:password,:password_confirmation)
  end

  def show
    id = params[:id]
    if !current_user?(id)
      flash[:warning]="Can only show profile of logged-in user"
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    if @user.save
      flash[:notice] = "Sign up successful! Welcome to THE!"
      redirect_to users_path
    else
      errors = @user.errors.full_messages
      puts "Validation failed with errors: #{errors.join(', ')}"
      render 'new'
    end
  end

  def edit
    # render 'edit'
  end

  def update
    # update product
  end

  def destroy
    # destroy user
  end

end