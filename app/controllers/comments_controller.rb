class CommentsController < ApplicationController

  def create
    @comment = Current.user.comments.new(comment_params)
    if @comment.save
      flash[:notice] = "投稿しました"
    else
      flash[:alert] = "投稿に失敗しました"
    end
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @comment = Comment.find_by_id(params[:id])
    @comment.destroy if @comment
    flash[:success] = "削除しました"
    redirect_back(fallback_location: root_path)
  end

  private

  def comment_params
    params.require(:comment).permit(:text).merge(post_id: params[:post_id])
  end
end
