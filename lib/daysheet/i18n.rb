module Daysheet
  module I18n

    #----------------------------------------------------------------------------
    def t(*args)
      if args.size == 1
        super(args.first, :default => args.first.to_s)
      elsif args.second.is_a?(Hash)
        super(*args)
      elsif args.second.is_a?(Fixnum)
        super(args.first, :count => args.second)
      else
        super(args.first, :value => args.second)
      end
    end
    
    #----------------------------------------------------------------------------
    def locales
      @@locales ||= Dir.entries(RAILS_ROOT + "/config/locales").grep(/_daysheet\.yml$/) { |f| f.sub("_daysheet.yml", "") }
    end
    
    #----------------------------------------------------------------------------
    def languages
      @@languages ||= locales.inject({}) do |hash, locale|
        hash[locale] = t(:language, :locale => locale)
        hash
      end
    end
  end
end
