module Daysheet
  module Sortable

    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods

      # Model class method to define sort options, for example:
      #   sortable :by => "first_name ASC"
      #   sortable :by => [ "first_name ASC", "last_name ASC" ]
      #   sortable :by => [ "first_name ASC", "last_name ASC" ], :default => "last_name ASC"
      #--------------------------------------------------------------------------
      def sortable(options = {})
        cattr_accessor :sort_by,            # Default sort order with prepended table name.
                       :sort_by_fields,     # Array of fields to sort by without ASC/DESC.
                       :sort_by_clauses     # A copy of sortable :by => ... stored as array.

        self.sort_by_clauses = [options[:by]].flatten
        self.sort_by_fields = self.sort_by_clauses.map(&:split).map(&:first)
        self.sort_by = self.name.tableize + "." + (options[:default] || options[:by].first)
      end

      # Return hash that maps sort options to the actual :order strings, for example:
      #   "first_name" => "leads.first_name ASC",
      #   "last_name"  => "leads.last_name ASC"
      #--------------------------------------------------------------------------
      def sort_by_map
        self.sort_by_fields.zip(self.sort_by_clauses).inject({}) do |hash, (field, clause)|
          hash[field] = self.name.tableize + "." + clause
          hash
        end
      end

    end # ClassMethods

  end
end