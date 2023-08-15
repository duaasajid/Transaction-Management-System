class AddSenderAndReceiverToTransactions < ActiveRecord::Migration[7.0]
  def change
    add_column :transactions, :receiver_account_id, :integer
  end
end
