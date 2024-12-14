class CreateCurrencyConversions < ActiveRecord::Migration[8.0]
  def change
    create_table :currency_conversions do |t|
      t.decimal :amount
      t.string :from
      t.string :to
      t.decimal :conversion_amount

      t.timestamps
    end
  end
end
