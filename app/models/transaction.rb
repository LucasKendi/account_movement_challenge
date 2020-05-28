class Transaction < ApplicationRecord
  validates :account_number, presence: true, numericality: true
  validates :amount, presence: true, numericality: true
  validate :account_presence

  private

  def account_presence
    return if Account.exists?(number: account_number)

    errors.add(:account_number, 'does not exists')
  end
end
