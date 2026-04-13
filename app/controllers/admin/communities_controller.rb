class Admin::CommunitiesController < Admin::ApplicationController
  def index
    @communities = Community.all
  end

  def destroy
    Community.find(params[:id]).destroy
    redirect_to admin_communities_path, notice: 'コミュニティを削除しました。'
  end
end
