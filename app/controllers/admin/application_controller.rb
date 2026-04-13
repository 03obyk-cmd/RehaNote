class Admin::ApplicationController < ActionController::Base
  layout 'admin'
  include Admin::Authentication

  private

  def after_authentication_url
    admin_dashboards_path # 管理者用ダッシュボードのパス
  end

  def after_logout_url
    new_admin_session_path
  end
end
