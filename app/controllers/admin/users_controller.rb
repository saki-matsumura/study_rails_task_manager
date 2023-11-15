class Admin::UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :exclude_general
  
  def index
    @users = User.all.page(params[:page])
  end
  
  def new
    if params[:back]
      @user = User.new(user_params)
    else
      @user = User.new
    end
  end

  def create
    @user = User.new(user_params)
    if params[:back]
      render :new
    else
      if @users.save
        redirect_to admin_user_path(@users), notice: "新規ユーザーを登録しました"
      else
        render :new
      end
    end
  end

  def show
    @tasks = Task.my_task(@user.id)
    if params[:deadline]
      @tasks = Task.my_task(@user.id).deadline
    end
    if params[:priority]
      @tasks = Task.my_task(@user.id).priority
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to admin_user_path, notice: "ユーザー情報を編集しました！"
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to admin_users_path
    if User.where(roll: 'admin').count == 1
      flash[:notice] = "管理者がいなくなるため、削除できませんでした"
    else
      flash[:notice] = "ユーザーを削除しました" 
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation, :roll,
                                 tasks_attributes: [:_destroy])
  end

  def set_user
    @user = User.find(params[:id])
  end

  def exclude_general
    redirect_to tasks_path, notice: "管理者以外はアクセスできません" unless current_user.roll == 'admin'
  end
  
end
