module TasksHelper
  def choose_new_or_edit
    if action_name == "create"
      task_path(@task)
    elsif action_name == "edit"
      task_path
    end
  end
end
