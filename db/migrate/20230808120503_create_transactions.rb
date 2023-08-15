class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.string :note
      t.string :transaction_type
      t.decimal :transaction_amount
      t.string :account_id
      t.references :account, foreign_key: true
      t.datetime :date

      t.timestamps
    end
  end
end
