class CreateBids < ActiveRecord::Migration[7.1]
  def change
    create_table :bids do |t|
      t.decimal :amount
      t.references :carrier, null: false, foreign_key: true
      t.references :load, null: false, foreign_key: true
      t.references :route, null: false, foreign_key: true
      t.string :status

      t.timestamps
    end
  end
end
