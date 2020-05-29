require 'csv'

FINE = 300

namespace :transactions do
  task :read do |_task, arg|
    puts "Transações iniciadas em #{Time.now.strftime('%X')}"
    transactions_file_path = "#{Dir.pwd}/#{arg}"
    CSV.foreach(transactions_file_path) do |transaction|
      transac_account, transac_amount = transaction
      begin
        account = Account.find_by!(number: transac_account)
        account.balance += transac_amount.to_i
        account.balance -= FINE if account.balance.negative? && transac_amount.to_i.negative?
        Transaction.create!(account_number: transac_account, amount: transac_amount) if account.save!
      rescue ActiveRecord::RecordInvalid, ActiveRecord::RecordNotFound => e
        puts "Erro na transação para a conta #{transac_account} com a quantia #{transac_amount}"
        puts e
      end
    end
    puts "Transações realizadas em #{Time.now.strftime('%X')}"
  end
end
