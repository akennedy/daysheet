class Admin::UsersController < Admin::ApplicationController
  before_filter "set_current_tab('admin/users')", :only => [ :index, :show ]

  #----------------------------------------------------------------------------  
  def index
    @users = get_users(:page => params[:page], :query => params[:query])

    respond_to do |format|
      format.html # index.html.haml
      format.js   # index.js.rjs
      format.xml  { render :xml => @users }
    end
  end

  #----------------------------------------------------------------------------   
  def search
    @users = get_users(:query => params[:query], :page => 1)

    respond_to do |format|
      format.js   { render :action => :index }
      format.xml  { render :xml => @users.to_xml }
    end
  end
  
  #---------------------------------------------------------------------------- 
  def suspend
    @user = User.find(params[:id])
    @user.update_attribute(:suspended_at, Time.now) if @user != @current_user

    respond_to do |format|
      format.js   # suspend.js.rjs
      format.xml  { render :xml => @user }
    end

  rescue ActiveRecord::RecordNotFound
    respond_to_not_found(:js, :xml)
  end
  
  #---------------------------------------------------------------------------- 
  def reactivate
    @user = User.find(params[:id])
    @user.update_attribute(:suspended_at, nil)

    respond_to do |format|
      format.js   # reactivate.js.rjs
      format.xml  { render :xml => @user }
    end

  rescue ActiveRecord::RecordNotFound
    respond_to_not_found(:js, :xml)
  end
  
  #---------------------------------------------------------------------------- 

  private
  #---------------------------------------------------------------------------- 
  def get_users(options = { :page => nil, :query => nil })
    current_page = options[:page] if options[:page]
    current_query = options[:query] if options[:query]

    if current_query.blank?
      User.paginate(:page => current_page)
    else
      User.search(current_query).paginate(:page => current_page)
    end
  end
end
