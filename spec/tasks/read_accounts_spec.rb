require 'rails_helper'
require 'csv'

describe 'rake accounts:read', type: :task do
  context 'when reading csv' do
    it 'creates the accounts correctly', :aggregate_failures do
      csv_string = %w[123 500].to_csv
      csv_string << %w[234 1000].to_csv
      file = Tempfile.new('temp_contas.csv', Rails.root)
      file.write(csv_string)
      file.rewind
      file_name = File.basename(file.path)
      task.execute(file_name)

      expect(Account.count).to eq(2)
      expect(Account.first.number).to eq(123)
      expect(Account.first.balance).to eq(500)
      expect(Account.last.number).to eq(234)
      expect(Account.last.balance).to eq(1000)
    end

    it 'outputs an error when the csv is wrong' do
      csv_string = %w[123 erro].to_csv
      file = Tempfile.new('temp_contas.csv', Rails.root)
      file.write(csv_string)
      file.rewind
      file_name = File.basename(file.path)

      expect { task.execute(file_name) }.to output(
        /Erro na criação da conta de número 123 e saldo erro/
      ).to_stdout
    end
  end
end
