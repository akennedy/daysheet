module Admin::ApplicationHelper

  def admin_tabs(tabs = Daysheet::Tabs.admin)
    if tabs
      @current_tab ||= tabs.first[:text] # Select first tab by default.
      tabs.each { |tab| tab[:active] = (@current_tab == tab[:text] || @current_tab == tab[:url][:controller]) }
    else
      raise Daysheet::MissingSettings, "Tab settings are missing, please run <b>rake daysheet:setup</b> command."
    end
  end

  #----------------------------------------------------------------------------
  def tabless_layout?
    %w(sessions passwords).include?(controller.controller_name) ||
    ((controller.controller_name == "invitations") && (%w(edit).include?(controller.action_name))) || ((controller.controller_name == "registrations") && (%w(new).include?(controller.action_name)))
  end
  
  #----------------------------------------------------------------------------

end
