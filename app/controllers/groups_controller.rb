class GroupsController < ApplicationController
  before_action :set_current_user

  def group_params
    params.require(:group).permit(:id, :name, :description, :user_id, :join_token)
  end

  def show
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    @group.owner = @current_user.id
    if @group.save
      flash[:notice] = "New group created!"
      redirect_to about_path
    else
      errors = @user.errors.full_messages
      flash[:notice] = "Validation failed with errors: #{errors.join(', ')}"
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