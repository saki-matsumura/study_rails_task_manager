class AddPriorityToTask < ActiveRecord::Migration[6.1]
  def change
    add_column :tasks, :priority, :integer, null: false, limit: 1, default: 1
  end
end
