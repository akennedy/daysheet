module UsersHelper

#----------------------------------------------------------------------------  
  def edit_user_link(user)
    link_to raw("<span class='ui-icon ui-icon-arrowreturnthick-1-e' style='float:left;'></span>#{t(:edit_profile)}"), edit_user_path(user) if can? :update, user
  end
  
end