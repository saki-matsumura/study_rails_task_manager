class UsersController < ApplicationController
  skip_before_action :login_required, only: [:new, :create]
  before_action :set_user, only: [:show, :edit, :update]
  before_action :back_to_index, only: [:show, :edit, :update]

  def new
    return redirect_to tasks_path if logged_in?
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      if logged_in? && current_user.admin?
        redirect_to admin_user_path(@user.id)
      else
        session[:user_id] = @user.id   # ユーザー作成時にログイン
        redirect_to user_path(@user.id)
      end
    else
      render :new
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
      redirect_to user_pathuser_path, notice: "ユーザー情報を編集しました！"
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end
  
  def set_user
    @user = User.find(params[:id])
  end

  def back_to_index
    redirect_to tasks_path unless current_user == @user || current_user.admin?
  end
end
