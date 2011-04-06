class Timesheet < ActiveRecord::Base
  belongs_to  :user
  has_many :timesheet_items, :dependent => :destroy
  has_many :timesheet_recipients, :dependent => :destroy
  has_many :timesheet_copies, :dependent => :destroy

  accepts_nested_attributes_for :timesheet_items, :allow_destroy => true
  accepts_nested_attributes_for :timesheet_recipients, :allow_destroy => true
  accepts_nested_attributes_for :timesheet_copies, :allow_destroy => true

  #----------------------------------------------------------------------------
  validates :start_date, :presence => true

  #----------------------------------------------------------------------------
  sortable :by => [ "start_date DESC", "stop_date DESC" ], :default => "created_at DESC"

  #----------------------------------------------------------------------------
  scope :my, lambda { |options| {
    :conditions => ["user_id=?", options[:user]],
    :order => options[:order] || "id DESC",
    :limit => options[:limit] # nil selects all records
  } }

  # Default values provided through class methods.
  #----------------------------------------------------------------------------
  def self.per_page ; 20                ; end
  def self.sort_by  ; "start_date DESC" ; end
  def self.recipient; Setting.timesheet_recipient_email ; end

  #----------------------------------------------------------------------------
  def date_range
    "#{start_date.strftime('%m/%d/%Y')} - #{stop_date.strftime('%m/%d/%Y')}"
  end
end
