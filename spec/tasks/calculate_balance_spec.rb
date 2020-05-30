require 'rails_helper'
require 'csv'

describe 'rake balance:calculate', type: :task do
  it 'creates the accounts and apply transactions correctly', :aggregate_failures do
    csv_string = %w[123 500].to_csv
    csv_string << %w[234 1000].to_csv
    temp_contas = Tempfile.new('temp_contas.csv', Rails.root)
    temp_contas.write(csv_string)
    temp_contas.rewind
    temp_contas_name = File.basename(temp_contas.path)

    csv_string = %w[123 -1500].to_csv
    csv_string << %w[123 -1000].to_csv
    csv_string << %w[234 1000].to_csv
    csv_string << %w[234 -3000].to_csv
    temp_transacoes = Tempfile.new('temp_transacoes.csv', Rails.root)
    temp_transacoes.write(csv_string)
    temp_transacoes.rewind
    temp_transacoes_name = File.basename(temp_transacoes.path)

    task_arg = { account_file: temp_contas_name, transactions_file: temp_transacoes_name }

    task.execute(task_arg)

    expect(Account.count).to eq(2)
    expect(Account.first).to have_attributes(number: 123, balance: -2600)
    expect(Account.last).to have_attributes(number: 234, balance: -1300)
  end
end
