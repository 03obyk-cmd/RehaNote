class CommunityUsersController < ApplicationController

def create
  community = Community.find(params[:community_id])
  community_user = CommunityUser.find_or_initialize_by(user: Current.user, community: community )
  community_user.status = :pending
  if community_user.save
    redirect_to community_path(community), notice: "申請しました"
  else
    redirect_to community_path(community), alert: "申請に失敗しました"
  end
end

def update
  community_user = CommunityUser.find(params[:id])
  if params[:status] == "approved"
    community_user.approved!
  elsif params[:status] == "rejected"
    community_user.rejected!
  end
  redirect_to members_community_path(community_user.community)
end

def destroy
  community = Community.find(params[:community_id])
  community_user = CommunityUser.find_by(user: Current.user, community: community)
  community_user&.destroy
  redirect_to community_path(community)
end

end
