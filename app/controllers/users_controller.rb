class UsersController < ApplicationController
  allow_unauthenticated_access only: [:new, :create]
  before_action :correct_user, only: [:edit, :update, :destroy]

  def new
    @user = User.new
  end
 
  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to mypage_path, notice: "ユーザー登録が完了しました。"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @user = User.find(params[:id])
    @communities = @user.communities
    @favorite_posts = @user.favorite_posts
  end

  def mypage
    @user = Current.user
    @favorite_posts = @user.favorite_posts
    render :show
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to mypage_path(@user), notice: "更新しました。"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    reset_session
    redirect_to root_path, notice: "退会しました。"
  end

  private

  def user_params
    params.require(:user).permit(:name, :email_address, :password, :password_confirmation, :profile_image)
  end

  def correct_user
    @user = User.find_by_id(params[:id])
    redirect_to mypage_path if Current.user != @user
  end
end
