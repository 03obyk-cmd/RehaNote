class Admin::UsersController < Admin::ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @favorite_posts = @user.favorite_posts
  end

  def destroy
    User.find(params[:id]).destroy
    redirect_to admin_users_path, notice: 'ユーザーを削除しました'
  end
end
