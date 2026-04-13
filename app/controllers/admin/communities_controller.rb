class Admin::CommunitiesController < Admin::ApplicationController
  def index
    @communities = Community.all
  end

  def destroy
    @communities = Community.find(params[:id])
    @community.destroy
    redirect_to admin_communities_path, notice: 'コミュニティを削除しました。'
  end
end
