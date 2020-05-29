require 'rails_helper'

describe Account, type: :model do
  describe 'validations' do
    context 'when number is valid' do
      it 'has an unique numerical value', :aggregate_failures do
        account = create(:account, number: 123)

        expect(account).to be_valid
        expect(Account.last).to eq(account)
        expect(account.number).to eq(123)
      end
    end

    context 'when number is not valid' do
      it 'does not have a value' do
        account = build(:account, number: nil)

        expect(account).not_to be_valid
      end

      it 'is not unique', :aggregate_failures do
        unique_acc = create(:account, number: 123)

        repeated_acc = build(:account, number: 123)

        expect(unique_acc).to be_valid
        expect(repeated_acc).not_to be_valid
      end

      it 'does not have a numerical value' do
        account = build(:account, number: 'two')

        expect(account).not_to be_valid
      end
    end

    context 'when balance is valid' do
      it 'has an numerical value', :aggregate_failures do
        account = create(:account, balance: 4000)

        expect(account).to be_valid
        expect(Account.last).to eq(account)
        expect(account.balance).to eq(4000)
      end
    end

    context 'when balance is not valid' do
      it 'does not have a value' do
        account = build(:account, balance: nil)

        expect(account).not_to be_valid
      end

      it 'does not have a numerical value' do
        account = build(:account, balance: 'four')

        expect(account).not_to be_valid
      end
    end
  end

  describe '#summary' do
    context 'when account has positive balance' do
      it 'shows formated currency' do
        account = create(:account, number: 123, balance: 5000)

        expect(account.summary).to eq(
          'Conta 123 com saldo de R$50,00'
        )
      end
    end

    context 'when account has negative balance' do
      it 'shows formated currency' do
        account = create(:account, number: 123, balance: -5025)

        expect(account.summary).to eq(
          'Conta 123 com saldo de -R$50,25'
        )
      end
    end
  end
end
