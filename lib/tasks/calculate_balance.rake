namespace :balance do
  task :calculate, %i[account_file transactions_file] => :environment do |_task, args|
    Rake::Task['accounts:read'].execute(args[:account_file])
    Rake::Task['transactions:read'].execute(args[:transactions_file])
    Rake::Task['balance:summary'].execute
  end

  task summary: :environment do
    accounts = Account.all
    accounts.each do |acc|
      puts acc.summary
    end
  end
end
