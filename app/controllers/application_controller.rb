class ApplicationController < ActionController::Base
  protect_from_forgery
  
  #---------------------------------------------------------------------------- 
  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = exception.message
    redirect_to root_url
  end
  
  #---------------------------------------------------------------------------- 
  def set_current_tab(tab = controller_name)
    @current_tab = tab
  end
  
  #---------------------------------------------------------------------------- 

end
