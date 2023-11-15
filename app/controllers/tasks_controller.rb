class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :back_to_index, only: [:edit, :update, :destroy]
  
  def index
    @tasks = Task.all.default
    
    # ソート
    @tasks = Task.all.deadline if params[:deadline]
    @tasks = Task.all.priority if params[:priority]

    # フィルター
    if params[:search]
      @tasks = Task.all.default
      @tasks = @tasks.title_like(params[:title_like]) if params[:title_like].present?
      @tasks = @tasks.status(params[:status]) if params[:status].present?
    end
    
    @tasks = @tasks.page(params[:page])
  end

  def new
    if params[:back]
      @task = current_user.tasks.build(task_params)
    else
      @task = current_user.tasks.build
    end
  end

  def show
  end

  def create
    @task = current_user.tasks.build(task_params)
    if params[:back]
      render :new
    else
      if @task.save
        redirect_to task_path(@task), notice: "タスクを作成しました"
      else
        render :new
      end
    end
  end

  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to task_path(@task), notice: "タスクを編集しました"
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, notice: "タスクを削除しました"
  end

  private

  def task_params
    params.require(:task).permit(:title, :summary, :deadline, :status, :priority)
  end

  def set_task
    @task = Task.find(params[:id])
  end

  def back_to_index
    # 自分以外のユーザーが編集・削除しようとするとタスク一覧画面に遷移
    redirect_to tasks_path if current_user != @user
  end

end