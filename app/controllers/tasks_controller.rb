class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  
  def index
    @tasks = Task.all.default
    if params[:deadline]
      @tasks = Task.all.deadline
    end
    if params[:priority]
      @tasks = Task.all.priority
    end

    if params[:search]
      if params[:title_like].present? && params[:status].present?
        @tasks = Task.title_like(params[:title_like]).status(params[:status])
      elsif params[:title_like].present?
        @tasks = Task.title_like(params[:title_like])
      elsif params[:status].present?
        @tasks = Task.status(params[:status])
      end
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

end