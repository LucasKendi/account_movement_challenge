class CreateTransactions < ActiveRecord::Migration[6.0]
  def change
    create_table :transactions do |t|
      t.integer :account_number
      t.integer :amount

      t.timestamps
    end
  end
end
