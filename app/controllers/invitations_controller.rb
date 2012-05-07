class InvitationsController < ApplicationController
  before_filter :load_invitation, :only => [:show, :edit, :update, :destroy]
  
  def index
    respond_with(@invitations = Invitation.all)
  end
  
  def show
    respond_with(@invitation)
  end
  
  def new
    respond_with(@invitation = Invitation.new)
  end
  
  def create
    @invitation = Invitation.new(params[:invitation])
    @invitation.save
    respond_with(@invitation)
  end
  
  def edit
    respond_with(@invitation)
  end
  
  def update
    @invitation.update_attributes(params[:invitation])
    respond_with(@invitation)
  end
  
  def destroy
    @invitation.destroy
    respond_with(@invitation)
  end
  
  private
    def load_invitation
      @invitation = Invitation.find(params[:id])
    end
end

