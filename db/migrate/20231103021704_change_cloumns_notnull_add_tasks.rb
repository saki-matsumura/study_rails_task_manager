class ChangeCloumnsNotnullAddTasks < ActiveRecord::Migration[6.1]
  def change
    change_column_null :tasks, :title, false
    change_column_null :tasks, :summary, false
    change_column_null :tasks, :deadline, false
  end
end
