class SessionsController < ApplicationController
  before_filter :authorize!, :only => [:index]
  
  def index
    respond_with(@sessions = Session.all)
  end
  
  def new
    respond_to do |format|
      format.html { render :new }
      format.json { render json: { result: "0"}, status: 401 }
    end
  end

  def create
    email, password = params[:user] ? [params[:user][:email], params[:user][:password]] : [params[:email], params[:password]]
    user = User.find_by_email(email.try(:downcase))
    respond_to do |format|
      if user && user.authenticate(password)
        user.session.try(:destroy)
        user.create_session
        format.html do
          session[:user_id] = user.id
          flash[:notice] = "Successfully logged in..."
          redirect_to(user_path(user))
        end
        format.json { render json: { result: "1", token: user.session.token }, status: 200 }
      else
        format.html do
          flash.now.alert = "Incorrect e-mail or password..."
          render :new
        end
        format.json { render json: { result: "0"}, status: 401 }
      end
    end
  end

  def destroy
    if current_user
      current_user.session.destroy
      session[:user_id] = nil
      respond_to do |format|
        format.html { redirect_to((root_url), notice: "Successfully logged out...") }
        format.json { render json: { result: "1" }, status: 200 }
      end
    end
  end
end