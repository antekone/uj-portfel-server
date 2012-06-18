class InvitationsController < ApplicationController
  before_filter :authorize!
  before_filter :load_invitation, :only => [:show, :edit, :update, :destroy]
  
  def index
    @invitations = current_user.invitations
    respond_with(@invitations)
  end
  
  def show
    respond_with(@invitation)
  end
  
  def new
    respond_with(@invitation = current_user.sent_invitations.new)
  end
  
  def create
    @invitation = current_user.sent_invitations.new(params[:invitation])
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
      @invitation = current_user.sent_invitations.find(params[:id])
    end
end

