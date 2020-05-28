require 'csv'

namespace :accounts do
  task :create, [:accounts_file] => :environment do |_task, args|
    accounts_file_path = "#{Dir.pwd}/#{args[:accounts_file]}"
    data = CSV.read(accounts_file_path)

    data.each do |account|
      Account.create!(number: account[0], balance: account[1])
    end
  end
end
