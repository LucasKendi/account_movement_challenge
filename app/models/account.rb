class Account < ApplicationRecord
  validates :number, presence: true, uniqueness: true, numericality: true
  validates :balance, presence: true, numericality: true

  include ActiveSupport::NumberHelper

  def summary
    "Conta #{number} com saldo de #{format_balance}"
  end

  private

  def format_balance
    number_to_currency(
      balance.to_f / 100,
      unit: 'R$',
      separator: ',',
      delimiter: '',
      precision: 2
    )
  end
end
