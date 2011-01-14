module Admin::UsersHelper

  #----------------------------------------------------------------------------
  def link_to_suspend(user)
    link_to(t(:suspend) + "!", suspend_admin_user_path(user), :"data-remote" => true, :method => 'put')
  end

  #----------------------------------------------------------------------------
  def link_to_reactivate(user)
    link_to(t(:reactivate) + "!", reactivate_admin_user_path(user), :"data-remote" => true, :method => 'put')
  end
  
  #----------------------------------------------------------------------------
  
end