require 'rails_helper'

describe Transaction, type: :model do
  describe 'validations' do
    context 'when account_number is valid' do
      it 'has a numerical value', :aggregate_failures do
        account = create(:account)
        transaction = create(:transaction, account_number: account.number)

        expect(transaction).to be_valid
        expect(Transaction.last).to eq(transaction)
      end
    end

    context 'when account_number is not valid' do
      it 'does not have a value' do
        transaction = build(:transaction, account_number: nil)

        expect(transaction).not_to be_valid
      end

      it 'does not have a numerical value' do
        transaction = build(:transaction, account_number: 'two')

        expect(transaction).not_to be_valid
      end

      it 'does not belong to an existing account' do
        transaction = build(:transaction, account_number: 123)

        expect(transaction).not_to be_valid
      end
    end

    context 'when amount is valid' do
      it 'has an numerical value', :aggregate_failures do
        account = create(:account)
        transaction = create(:transaction, account_number: account.number, amount: 4000)

        expect(transaction).to be_valid
        expect(Transaction.last).to eq(transaction)
        expect(transaction.amount).to eq(4000)
      end
    end

    context 'when amount is not valid' do
      it 'does not have a value' do
        account = build(:account)
        transaction = build(:transaction, amount: nil, account_number: account.number)

        expect(transaction).not_to be_valid
      end

      it 'does not have a numerical value' do
        account = build(:account)
        transaction = build(:transaction, amount: 'one milion', account_number: account.number)

        expect(transaction).not_to be_valid
      end
    end
  end
end
