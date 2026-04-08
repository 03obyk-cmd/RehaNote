class CommunitiesController < ApplicationController
  before_action :correct_user, only: [:edit, :update, :destroy]
  
  def new
    @community = Community.new
  end

  def create
    @community = Community.new(community_params)
    @community.user = Current.user
    if @community.save
      CommunityUser.create!(user: Current.user, community: @community, status: :approved)
      redirect_to community_path(@community)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def index
    @communities = Community.all
  end

  def show
    @community = Community.find(params[:id])
    @community_users = @community.community_users
    @post = Post.new
  end

  def edit
    @community = Community.find(params[:id])
  end

  def update
    @community = Community.find(params[:id])
    if @community.update(community_params)
      redirect_to community_path(@community)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @community = Community.find(params[:id])
    @community.destroy
    redirect_to communities_path,  notice: "削除しました。"
  end

  def members
    @community = Community.find(params[:id])
    @community_users = @community.community_users.includes(:user)
  end

  private

  def correct_user
    @community = Community.find(params[:id])
    redirect_to communities_path unless @community.user == Current.user
  end

  def community_params
    params.require(:community).permit(:name, :body)
  end
end
