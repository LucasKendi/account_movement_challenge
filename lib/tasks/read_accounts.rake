require 'csv'

namespace :accounts do
  task :read do |_task, arg|
    accounts_file_path = "#{Dir.pwd}/#{arg}"
    CSV.foreach(accounts_file_path) do |account|
      acc_number, acc_balance = account
      begin
        Account.create!(number: acc_number, balance: acc_balance)
      rescue ActiveRecord::RecordInvalid => e
        puts "Erro na criação da conta de número #{acc_number} e saldo #{acc_balance}"
        puts e
      end
    end
  end
end
