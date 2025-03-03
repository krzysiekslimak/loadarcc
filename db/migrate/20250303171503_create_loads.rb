class CreateLoads < ActiveRecord::Migration[7.1]
  def change
    create_table :loads do |t|
      t.string :load_type

      t.timestamps
    end
  end
end
