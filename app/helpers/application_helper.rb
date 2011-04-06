module ApplicationHelper

#----------------------------------------------------------------------------
  def tabs(tabs = Daysheet::Tabs.main)
    if tabs
      @current_tab ||= tabs.first[:text] # Select first tab by default.
      tabs.each { |tab| tab[:active] = (@current_tab == tab[:text] || @current_tab == tab[:url][:controller]) }
    else
      raise Daysheet::MissingSettings, "Tab settings are missing, please run <b>rake daysheet:setup</b> command."
    end
  end

  def tabless_layout?
    %w(sessions passwords).include?(controller.controller_name) ||
    ((controller.controller_name == "invitations") && (%w(edit).include?(controller.action_name))) || ((controller.controller_name == "registrations") && (%w(new).include?(controller.action_name)))
  end

#----------------------------------------------------------------------------
  def show_flash(options = { :sticky => false })
    [:error, :warning, :info, :notice, :alert].each do |type|
      if flash[type]
        html = content_tag(:p, h(flash[type]), :id => "flash")
        return html << content_tag(:script, "daysheet.flash('#{type}', #{options[:sticky]})", :type => "text/javascript")
      end
    end
    content_tag(:p, nil, :id => "flash", :style => "display:none;")
  end

#----------------------------------------------------------------------------
  def avatar_for(model, args = {})
    args[:size]  ||= "75x75"
    args[:class] ||= "gravatar"
    if model.avatar
      image_tag(model.avatar.image.url(Avatar.styles[args[:size]]), args)
    elsif model.email
      image_tag(model.gravatar_url(:default => default_avatar_url), args)
    else
      image_tag("avatar.png", args)
    end
  end

#----------------------------------------------------------------------------
  def gravatar_for(model, args = {})
    args[:size]  ||= "30x30"
    args[:class] ||= "gravatar"
    image_tag(model.gravatar_url(:default => default_avatar_url), args)
  end

#----------------------------------------------------------------------------
  def default_avatar_url
    "#{request.protocol + request.host_with_port}/images/avatar.png"
  end

#----------------------------------------------------------------------------
  def link_to_cancel(url)
    link_to t(:cancel), url
  end

#----------------------------------------------------------------------------
  def styles_for(*models)
    render :partial => "shared/inline_styles", :locals => { :models => models }
  end

#----------------------------------------------------------------------------
  def hidden;    { :style => "display:none;"       }; end
  def invisible; { :style => "visibility:hidden;"  }; end
  def visible;   { :style => "visibility:visible;" }; end

#----------------------------------------------------------------------------
  def highlightable(id = nil, color = {})
    color = { :on => "seashell", :off => "white" }.merge(color)
    show = (id ? "$('##{id}').css('visibility','visible')" : "")
    hide = (id ? "$('##{id}').css('visibility','hidden')" : "")
    { :onmouseover => "this.style.background='#{color[:on]}'; #{show}",
      :onmouseout  => "this.style.background='#{color[:off]}'; #{hide}"
    }
  end

#----------------------------------------------------------------------------
  def return_to_link(location, url)
    link_to raw("<span class='ui-icon ui-icon-arrowreturnthick-1-e' style='display:inline-block;'></span>#{t(:return_to)} " + location), url
  end

#----------------------------------------------------------------------------
  def link_to_create(object, url, options = {})
    link_to raw("<span class='ui-icon ui-icon-arrowreturnthick-1-e' style='display:inline-block;'></span>#{options[:text]}"), url# if can? :create, object
  end

#----------------------------------------------------------------------------
  def link_to_update(object, url, options = {})
    link_to raw("<span class='ui-icon ui-icon-arrowreturnthick-1-e' style='display:inline-block;'></span>#{options[:text]}"), url if can? :update, object
  end

#----------------------------------------------------------------------------
  def link_to_edit(object, url, options = {})
    link_to options[:text], url if can? :update, object
  end

#----------------------------------------------------------------------------
  def link_to_invite(object, url, options = {})
    link_to raw("<span class='ui-icon ui-icon-arrowreturnthick-1-e' style='display:inline-block;'></span>#{options[:text]}"), url if can? :create, object
  end

#----------------------------------------------------------------------------
  def link_to_options(object, url, options = {})
    link_to raw("<span class='ui-icon ui-icon-arrowreturnthick-1-e' style='display:inline-block;'></span>#{options[:text]}"), url# if can? :read, object
  end

#----------------------------------------------------------------------------
  def link_to_email(email, length = nil)
    name = (length ? truncate(email, :length => length) : email)
    if Setting.email_dropbox && Setting.email_dropbox[:address].present?
      mailto = "#{email}?bcc=#{Setting.email_dropbox[:address]}"
    else
      mailto = email
    end
    link_to(h(name), "mailto:#{mailto}", :title => email)
  end

#----------------------------------------------------------------------------
end