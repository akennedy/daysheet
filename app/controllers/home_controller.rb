class HomeController < ApplicationController
  before_filter :authenticate_user!
  before_filter :set_current_tab, :only => ['index']

  #---------------------------------------------------------------------------- 
  def index
  end
  
  #---------------------------------------------------------------------------- 
end