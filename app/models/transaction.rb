class Transaction < ApplicationRecord
  belongs_to :account, foreign_key: 'account_id'
  belongs_to :receiver, class_name: 'Account', foreign_key: 'receiver_account_id'

  enum :transaction_type, { cash_withdrawl: 0, cash_deposit: 1 }
end
