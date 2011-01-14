class UsersController < ApplicationController
  before_filter :authenticate_user!

  #----------------------------------------------------------------------------   
  respond_to :html, :json, :xml
  
  #----------------------------------------------------------------------------   
  def show
    @user = params[:id] ? User.find(params[:id]) : current_user
    authorize! :read, @user
    respond_with @user
  end

  #---------------------------------------------------------------------------- 
  def edit
    @user = User.find(params[:id])
    authorize! :update, @user
    respond_with @user
  end

  #---------------------------------------------------------------------------- 
  def update
    @user = User.find(params[:id])
    authorize! :update, @user
    
    if @user.update_attributes(params[:user])
      flash[:notice] = t(:msg_successfully_updated, :value => "user")
      respond_with @user, :location => user_path(@user)
    else
      flash[:error] = t(:msg_failed_to_update, :value => "user")
      render :action => :edit
    end
  end

  #---------------------------------------------------------------------------- 
end