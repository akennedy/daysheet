module Daysheet
  class Tabs
    cattr_accessor :main
    cattr_accessor :admin

    # Class methods.
    #----------------------------------------------------------------------------
    def self.main
      @@main || reload!(:main)
    end

    def self.admin
      @@admin || reload!(:admin)
    end

    # Make it possible to reload tabs (:main, :admin, or both).
    #----------------------------------------------------------------------------
    def self.reload!(main_or_admin = nil)
      case main_or_admin
        when :main  then @@main  = Setting[:tabs]
        when :admin then @@admin = Setting[:admin_tabs]
        when nil    then @@main  = Setting[:tabs]; @@admin = Setting[:admin_tabs]
      end
    end

  end
end