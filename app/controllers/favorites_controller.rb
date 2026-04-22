class FavoritesController < ApplicationController

  def create
    post = Post.find(params[:post_id])
    Current.user.favorites.create(post: post)
    redirect_to post_path(post)
  end

  def destroy
    post = Post.find(params[:post_id])
    Current.user.favorites.find_by(post: post)&.destroy
    redirect_to post_path(post)
  end

end
