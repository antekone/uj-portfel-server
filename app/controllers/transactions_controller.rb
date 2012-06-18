class TransactionsController < ApplicationController
  before_filter :authorize!
  before_filter :load_transaction, :only => [:show, :edit, :update, :destroy]
  
  def index
    respond_with(@transactions = current_user.transactions.all)
  end
  
  def show
    respond_with(@transaction)
  end
  
  def new
    respond_with(@transaction = current_user.transactions.new)
  end
  
  def create
    @transaction = current_user.transactions.new(params[:transaction])
    @transaction.save
    respond_with(@transaction)
  end
  
  def edit
    respond_with(@transaction)
  end
  
  def update
    @transaction.update_attributes(params[:transaction])
    respond_with(@transaction)
  end
  
  def destroy
    @transaction.destroy
    respond_with(@transaction)
  end
  
  private
    def load_transaction
      @transaction = current_user.transactions.find(params[:id])
    end
end
