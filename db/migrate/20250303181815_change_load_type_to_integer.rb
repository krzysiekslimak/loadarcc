class ChangeLoadTypeToInteger < ActiveRecord::Migration[7.1]
  def change
    change_column :loads, :load_type, :integer
  end
end
