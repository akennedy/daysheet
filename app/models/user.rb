class User < ActiveRecord::Base

  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable

  #----------------------------------------------------------------------------
  attr_accessible :username, :email, :alt_email, :first_name, :mi, :last_name, :title, :company, :phone, :mobile, :password, :password_confirmation, :remember_me

  #----------------------------------------------------------------------------  
  validates :email, :presence => true, :uniqueness => true, :format => { :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i, :message => "must be a valid email address"}
  validates :username, :presence => true, :on => :create
  validates :username, :uniqueness => true, :format => { :without => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i, :message => "can't be an email"}
  validates :password, :presence => true, :confirmation => true, :on => :create

  #----------------------------------------------------------------------------
  has_and_belongs_to_many :roles
  has_one     :avatar, :as => :entity, :dependent => :destroy
  has_many    :avatars
  has_many    :preferences, :dependent => :destroy

  #----------------------------------------------------------------------------    
  multi_column_search :username, :first_name, :last_name, :email

  #----------------------------------------------------------------------------  
  include Gravtastic
  gravtastic

  #----------------------------------------------------------------------------  
  def role?(role)
    return !!self.roles.find_by_name(role.to_s.camelize)
  end
  
  #----------------------------------------------------------------------------
  def full_name
    first_name.blank? || last_name.blank? ? email : "#{first_name} " + (mi ? "#{mi} " : '') + "#{last_name}"
  end
  
  #----------------------------------------------------------------------------
  def suspended?
    self.suspended_at != nil
  end

  #----------------------------------------------------------------------------
  def self.find_for_authentication(conditions={})
    if conditions[:username] =~ /^([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})$/i # email regex
      conditions[:email] = conditions[:username]
      conditions.delete("username")
    end
    super
  end
  
  #----------------------------------------------------------------------------
  def preference
    Preference.new(:user => self)
  end
  alias :pref :preference

  #----------------------------------------------------------------------------
  
end
