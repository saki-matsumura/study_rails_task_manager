class ChangeColumnDefaultToTasks < ActiveRecord::Migration[6.1]
  def change
    change_column_default :tasks, :deadline, from: nil, to: -> { "NOW() + cast( '7 days' as INTERVAL )" }
  end
end
