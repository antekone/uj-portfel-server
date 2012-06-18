class AccountsController < ApplicationController
  before_filter :authorize!
  before_filter :load_account, :only => [:show, :edit, :update, :destroy]
  
  def index
    respond_with(@accounts = current_user.accounts.all)
  end
  
  def show
    respond_with(@account)
  end
  
  def new
    respond_with(@account = current_user.accounts.new)
  end
  
  def create
    @account = current_user.accounts.new(params[:account])
    @account.save
    respond_with(@account)
  end
  
  def edit
    respond_with(@account)
  end
  
  def update
    @account.update_attributes(params[:account])
    respond_with(@account)
  end
  
  def destroy
    @account.destroy
    respond_with(@account)
  end
  
  private
    def load_account
      @account = current_user.accounts.find(params[:id])
    end
end
