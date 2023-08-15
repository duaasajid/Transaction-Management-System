class AccountsController < ApplicationController
  before_action :set_account, only: [:show, :edit]

  def index
  end

  def new
    @account = Account.new(account_params)
    if @account.save
      puts("yayyyyy")
    else
      puts("nooooo")
    end
  rescue => e
    e.message
  end
  
  def show
  end

  def edit
    @account.update!(account_params)
    render json: @account
    rescue => e
      render json: {message: "unable to update account due to faulty parameters"}
  end

  private
  def set_account
    @account = User.find(params[:id]).account
  rescue => e
    e.message
  end

  def account_params
    params.permit(:name, :account_type, :balance, :user_id)
  end

end
