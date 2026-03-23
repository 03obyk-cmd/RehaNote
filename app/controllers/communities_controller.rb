class CommunitiesController < ApplicationController
  def new
    @community = Community.new
  end

  def create
    @community = Community.new(community_params)
    @community.user_id = Current.user.id
    @community.save
    redirect_to '/'
  end

  def index
  end

  def show
  end

  def edit
  end

  private

  def community_params
    params.require(:community).permit(:name, :body)
  end
end
