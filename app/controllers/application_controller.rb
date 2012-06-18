class ApplicationController < ActionController::Base
  #protect_from_forgery
  respond_to :html, :json
  
  helper_method :current_user
  
  def current_user
    @current_user ||= if params[:token]
      Session.active.find_by_token(params[:token]).try(:user)
    elsif session[:user_id]
      User.find(session[:user_id])
    end
  end
  
  def authorize!
    unless current_user
      respond_to do |format|
        format.html { redirect_to(login_path, alert: "Login to have access." ) }
        format.json { render json: { result: "0"}, status: 401 }
      end
    end
  end
end
