namespace :balance do
  task :calculate, %i[account_file transactions_file] => :environment do |_task, args|
    Rake::Task['accounts:read'].execute(args[:account_file])
    Rake::Task['transactions:read'].execute(args[:transactions_file])
  end
end
