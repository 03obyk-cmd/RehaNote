class CommunityUsersController < ApplicationController
def index
  community_users = CommunityUser.all
end

def create
  community = Community.find(params[:community_id])
  community_user = CommunityUser.new(user: Current.user, community: community, status: :pending)
  community_user.save
  redirect_to community_path(community)
end

def update
  community_user = CommunityUser.find(params[:id])
  community_user.update(status: params[:status])
  redirect_to community_members_path(community_user.community)
end

def destroy
  community = Community.find(params[:community_id])
  community_user = CommunityUser.find_by(user: Current.user, community: community)
  community_user.destroy
  redirect_to community_path(community)
end

end
