class Admin::ApplicationController < ApplicationController
  layout "admin/application"
  before_filter :authenticate_user!
  before_filter :require_admin_user
  
  private
  #----------------------------------------------------------------------------
  def require_admin_user
    unless current_user.role? :admin
      flash[:error] = t(:msg_require_admin)
      redirect_to root_path
      false
    end
  end

end
