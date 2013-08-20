class CreateTickers < ActiveRecord::Migration
  def change
    create_table :tickers do |t|
      t.date :date
      t.float :open
      t.float :high
      t.float :low
      t.float :close
      t.integer :volume
      t.float :adj_close

      t.timestamps
    end
  end
end
