class ProfilesController < ApplicationController
  before_filter :authorize!
  before_filter :load_profile
  
  def show
    respond_with(@profile)
  end
  
  def edit
    respond_with(@profile)
  end
  
  def update
    @profile.update_attributes(params[:profile])
    respond_with(@profile)
  end
  
  private
    def load_profile
      @profile = Profile.find(params[:id])
    end
end
