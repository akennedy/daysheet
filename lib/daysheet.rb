require "daysheet/callback"
require "daysheet/exceptions"
require "daysheet/i18n"
require "daysheet/sortable"
require "daysheet/tabs"

      ActionView::Base.send(:include, Daysheet::I18n)
ActionController::Base.send(:include, Daysheet::I18n)

      ActionView::Base.send(:include, Daysheet::Callback::Helper)
ActionController::Base.send(:include, Daysheet::Callback::Helper)

    ActiveRecord::Base.send(:include, Daysheet::Sortable)