class Admin::UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :exclude_general
  
  def index
    @managed_users = User.all
  end
  
  def new
    if params[:back]
      @managed_user = User.new(user_params)
    else
      @managed_user = User.new
    end
  end

  def create
    @managed_user = User.new(user_params)
    if params[:back]
      render :new
    else
      if @managed_user.save
        redirect_to admin_user_path(@managed_user), notice: "新規ユーザーを登録しました"
      else
        render :new
      end
    end
  end
  
  def edit
  end

  def update
    if @managed_user.update(user_params)
      redirect_to admin_user_path(@managed_user), notice: "ユーザー情報を編集しました"
    else
      render :edit
    end
  end

  def show
  end

  def destroy
    @managed_user.destroy
    redirect_to admin_users_path, notice: "ユーザーを削除しました"
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation, :roll,
                                 tasks_attributes: [
                                  :id, :title, :summary,
                                  :deadline, :status, :priority,
                                  :_destroy
                                ])
  end

  def set_user
    @managed_user = User.find(params[:id])
  end

  def exclude_general
    redirect_to tasks_path, notice: "管理者以外はアクセスできません" unless current_user.roll == 'admin'
  end
  
end
