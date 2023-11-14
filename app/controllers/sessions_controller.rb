class SessionsController < ApplicationController
  skip_before_action :login_required, only: [:new, :create]
  def new  
    return redirect_to tasks_path if logged_in?
  end
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      # ログイン成功
      session[:user_id] = user.id
      redirect_to user_path(user.id)
    else
      # ログイン失敗
      flash.now[:danger] = 'ログインに失敗しました'
      render :new
    end
  end

  def destroy
    session.delete(:user_id)
    flash[:notice] = 'ログアウトしました'
    redirect_to new_session_path
  end
end
