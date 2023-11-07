class AddStatusToTask < ActiveRecord::Migration[6.1]
  def change
    add_column :tasks, :status, :integer, null: false, limit: 1, default: 0
  end
end
