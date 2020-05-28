class Account < ApplicationRecord
  validates :number, presence: true, uniqueness: true, numericality: true
  validates :balance, presence: true, numericality: true
end
