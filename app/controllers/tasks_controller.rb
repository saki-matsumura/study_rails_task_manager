class TasksController < ApplicationController
    before_action :set_task, only: [:show, :edit, :update, :destroy]
  def index
    @tasks = Task.all.default
    if params[:deadline]
      @tasks = Task.all.deadline
    end

    if params[:search]
      if params[:title_like].present? && params[:status].present?
        @tasks = Task.where(status: params[:status]).where('title LIKE ?', "%#{params[:title_like]}%")
      elsif params[:title_like].present?
        @tasks = Task.where('title LIKE ?', "%#{params[:title_like]}%") 
      elsif params[:status].present?
        @tasks = Task.where(status: params[:status])
      end
    end
  end

  def new
    if params[:back]
      @task = Task.new(task_params)
    else
      @task = Task.new
    end
  end

  def show
  end

  def create
    @task = Task.new(task_params)
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
    params.require(:task).permit(:title, :summary, :deadline, :status)
  end

  def set_task
    @task = Task.find(params[:id])
  end

end