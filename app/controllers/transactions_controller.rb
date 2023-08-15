class TransactionsController < ApplicationController
  before_action :set_account , only: [:show, :index, :new, :create, :balance_calculation]

  def index
    @sent_transactions = @account.transactions
    @received_transactions = Transaction.where(receiver_account_id: @account.id)
    @transactions = @sent_transactions + @received_transactions
  end

  def new 
    @transaction = @account.transactions.build
  end

  def create
    receiver_account = Account.find_by(account_number: params[:transaction][:receiver_account_id])
    if receiver_account.present?
      @transaction = @account.transactions.build(
        receiver: receiver_account,
        transaction_type: 'cash_withdrawl',
        transaction_amount: params[:transaction][:transaction_amount],
        date: Date.today,
        note: params[:transaction][:note]
      )
  
      if balance_calculation(@account, @transaction.transaction_amount, @transaction.transaction_type) && @transaction.save
        balance_calculation(receiver_account, @transaction.transaction_amount, 'cash_deposit')
        flash[:success] = "Transaction created successfully"
        redirect_to account_path(id: @account.user.id)
      else
        flash[:error] = balance_calculation(@account, @transaction.transaction_amount, @transaction.transaction_type) == false ? "Incorrect Amount" : @transaction.errors.full_messages
      end
    else
      flash[:error] = "Receiver account not found"
      redirect_to new_transaction_path(account_id: @account.id)
    end
  rescue => e
    puts e.message
  end
   
  def show
    render json: {transaction: @transaction}
  end

  private
  
  def set_account
    @account = Account.find(params[:account_id])
  rescue => e
    e.message
  end

  def balance_calculation(account, transaction_amount, transaction_type)
    balance = (transaction_type == 'cash_withdrawl') ? account.balance - transaction_amount : account.balance + transaction_amount
    if (balance >= 0 )
      account.update_columns(balance: balance)
      return true
    else
      return false
    end
  end

  def transaction_params
    params.require(:transaction).permit(:note, :transaction_type, :transaction_amount, :date, :receiver_account_id)
  end
end
