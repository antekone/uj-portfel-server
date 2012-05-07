class TransactionsController < ApplicationController
  before_filter :load_transaction, :only => [:show, :edit, :update, :destroy]
  
  def index
    respond_with(@transactions = Transaction.all)
  end
  
  def show
    respond_with(@transaction)
  end
  
  def new
    respond_with(@transaction = Transaction.new)
  end
  
  def create
    @transaction = Transaction.new(params[:transaction])
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
      @transaction = Transaction.find(params[:id])
    end
end
