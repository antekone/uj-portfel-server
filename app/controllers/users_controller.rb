class UsersController < ApplicationController
  before_filter :authorize!, except: [:index, :new, :create]
  before_filter :load_user, :only => [:show]
  
  def index
    @users = current_user ? User.all : []
    respond_with(@users)
  end
  
  def show
    respond_with(@user = User.find(params[:id]))
  end
  
  def new
    respond_with(@user = User.new)
  end
  
  def create
    @user = User.new(params[:user])
    respond_to do |format|
      if @user.save
        @user.create_session
        format.html do
          session[:user_id] = @user.id
          redirect_to(user_path(@user))
        end
        format.json { render json: @user.as_json(methods: [:token]), status: 201 }
      else
        format.html { render :new }
        format.json { render json: {errors: @user.errors}, status: 422 }
      end
    end
  end
  
  def edit
    respond_with(current_user)
  end
  
  def update
    current_user.update_attributes(params[:user])
    respond_with(current_user)
  end
  
  def destroy
    current_user.destroy
    session[:user_id] = nil
    respond_with(current_user)
  end
end
