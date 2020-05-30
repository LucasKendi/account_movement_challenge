require 'rails_helper'
require 'csv'

describe 'rake transactions:read', type: :task do
  context 'when reading csv' do
    it 'execute transactions correctly', :aggregate_failures do
      account = create(:account, number: 123, balance: 0)
      csv_string = %w[123 -500].to_csv
      file = Tempfile.new('temp_transacoes.csv', Rails.root)
      file.write(csv_string)
      file.rewind
      file_name = File.basename(file.path)
      task.execute(file_name)

      account.reload

      expect(account.balance).to eq(-800)
    end

    it 'outputs an error when the csv is wrong' do
      csv_string = %w[123 erro].to_csv
      file = Tempfile.new('temp_transacoes.csv', Rails.root)
      file.write(csv_string)
      file.rewind
      file_name = File.basename(file.path)

      expect { task.execute(file_name) }.to output(
        /Erro na transação para a conta 123 com a quantia erro/
      ).to_stdout
    end
  end
end
