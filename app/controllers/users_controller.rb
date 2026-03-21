class UsersController < ApplicationController
  allow_unauthenticated_access only: [:new, :create] 
 
  def new
    @user = User.new
  end
 
  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to mypage_path, notice: "ユーザー登録が完了しました。"
    else
      # エラー時はフォームを再表示
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @user = Current.user
  end

  def edit
    @user = Current.user
  end

  def update
    @user = Current.user
    if @user.update(user_params)
      redirect_to mypage_path(@user), notice: "更新しました。"
    else
      render :edit
    end
  end

  def destroy
    Current.user.destroy
    reset_session
    redirect_to root_path, notice: "退会しました。"
  end

  private

  def user_params
    params.require(:user).permit(:name, :email_address, :password, :password_confirmation)
  end
end
