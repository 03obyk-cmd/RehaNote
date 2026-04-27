class ApplicationController < ActionController::Base
  include Authentication

  before_action :set_communities

  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  private

  def set_communities
    @communities = Community.all
  end

  def after_authentication_url
    mypage_path
  end
  
  def after_logout_url
    about_path
  end
end
