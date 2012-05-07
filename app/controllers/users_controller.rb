class UsersController < ApplicationController
  before_filter :load_user, :only => [:show, :edit, :update, :destroy]
  
  def index
    respond_with(@users = User.all)
  end
  
  def show
    respond_with(@user)
  end
  
  def new
    respond_with(@user = User.new)
  end
  
  def create
    @user = User.new(params[:user])
    @user.save
    respond_with(@user)
  end
  
  def edit
    respond_with(@user)
  end
  
  def update
    @user.update_attributes(params[:user])
    respond_with(@user)
  end
  
  def destroy
    @user.destroy
    respond_with(@user)
  end
  
  private
    def load_user
      @user = User.find(params[:id])
    end
end
