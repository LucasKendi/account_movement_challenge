require 'csv'

FINE = 300

namespace :accounts do
  task :create, [:accounts_file] => :environment do |_task, args|
    accounts_file_path = "#{Dir.pwd}/#{args[:accounts_file]}"
    CSV.foreach(accounts_file_path) do |account|
      acc_number, acc_balance = account
      Account.create!(number: acc_number, balance: acc_balance)
    end
  end

  task :transactions, [:transactions_file] => :environment do |_task, args|
    transactions_file_path = "#{Dir.pwd}/#{args[:transactions_file]}"
    CSV.foreach(transactions_file_path) do |transaction|
      transac_account, transac_amount = transaction

      account = Account.find_by(number: transac_account)
      account.balance += transac_amount.to_i
      account.balance -= FINE if account.balance.negative? && transac_amount.to_i.negative?

      Transaction.create!(account_number: transac_account, amount: transac_amount) if account.save!
    end
  end
end
