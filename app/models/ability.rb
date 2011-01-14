class Ability
  include CanCan::Ability
 
  def initialize(user)
    user ||= User.new # guest user
 
    if user.role? :admin
      can :manage, :all
    else
      can :manage, User, :id => user.id
      can :read, Timesheet, :user_id => user.id
      can :create, Timesheet
      can :update, @timesheet, :user_id => user.id
      can :destroy, @timesheet, :user_id => user.id
    end
  end
end