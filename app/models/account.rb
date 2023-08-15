class Account < ApplicationRecord
  belongs_to :user
  has_many :transactions, dependent: :destroy
  before_validation :account_number_generation, :set_account_user_name

  validates :account_number, presence: true, uniqueness: true
  validates :balance, numericality: { greater_than_or_equal_to: 0 }
  enum :account_type, { current_account: 0, saving_account: 1 }

  private

  def account_number_generation
    self.account_number = rand(10**14).to_s
  end

  def set_account_user_name
    self.name = self.user.username
  end
end
