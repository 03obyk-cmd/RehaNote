class PostsController < ApplicationController
  before_action :correct_user, only: [:edit, :update, :destroy]

  def new
    @community = Community.find(params[:community_id])
    @post = Post.new
  end

  def create
    community = Community.find(params[:community_id])
    post = community.posts.new(post_params)
    post.user = Current.user
    if post.save
      redirect_to community_path(community), notice: "投稿が完了しました。"
    else
      @community = community
      @post = post
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
    @community = Community.find(params[:community_id])
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    @community = @post.community
    if @post.update(post_params)
      redirect_to community_post_path(@post.community), notice: "更新しました。"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    Post.find(params[:id]).destroy
    redirect_to community_path(params[:community_id]), notice: "投稿を削除しました。"
  end

  private

  def correct_user
    @post = Post.find(params[:id])
    redirect_to community_path(@post.community) unless @post.user == Current.user
  end

  def post_params
    params.require(:post).permit(:title, :start_position, :exercise_description, :record_example)
  end
end
