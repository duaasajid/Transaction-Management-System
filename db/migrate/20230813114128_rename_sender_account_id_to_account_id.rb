class RenameSenderAccountIdToAccountId < ActiveRecord::Migration[7.0]
  def change
    rename_column :transactions, :sender_account_id, :account_id
  end
end
