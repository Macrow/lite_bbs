# encoding: utf-8
module LiteBbs
  module ApplicationHelper
    def title(title)
      content_for :title do
        if LiteBbs.show_site_path
          "#{LiteBbs.site_name} - " + title
        else
          title
        end
      end
    end
    
    def display_flash
      result = ''
      if LiteBbs.display_flash_message
        flash.each do |key, msg|
          result << content_tag(:div, (link_to('×', '#', class: 'close', 'data-dismiss' => 'alert') + content_tag(:strong, t("flash.#{key}")) + ' : ' + msg), class: "alert alert-#{key}")
        end
      end
      result.html_safe
    end
    
    def display_icon(icon)
      content_tag(:i, '', class: "icon-#{icon}")
    end
    
    def display_label(text, css = '')
      content_tag(:span, text, class: "label #{css}")
    end
    
    def display_modified(record)
      "#{display_icon('pencil')} #{record.updated_at.to_s(:db)}".html_safe unless record.created_at == record.updated_at
    end
    
    def display_user_image(user, size = '48x48')
      image_tag(litebbs_user_image(user), size: size)
    end
    
    def display_topic_thread_icon(topic)
      if topic.stick_at
        display_icon('fire')
      elsif !topic.can_reply
        display_icon('lock')
      else
        display_icon('comment')
      end
    end
    
    def display_user_info(user)
      result = ''
      result << display_user_image(user)
      result << '<br>'
      result << litebbs_user_name(user)
      result.html_safe
    end
    
    def display_edit_and_delete_btn(edit_path, delete_path, *args)
      options = args.extract_options!
      link_to(t('lite_bbs.actions.edit'), edit_path, class: "btn btn-info #{options[:btn_class]}") + link_to(t('lite_bbs.actions.delete'), delete_path, class: "btn btn-danger #{options[:btn_class]}", confirm: t('lite_bbs.actions.confirm'))
    end
    
    def display_last_reply_info_from_topic(topic)
      if topic.last_reply
        content_tag(:div, "#{litebbs_user_name(topic.last_reply.user)}<br>#{link_to(time_ago_in_words(topic.last_reply.created_at), last_reply_path(topic, topic.replies.size))}".html_safe, class: 'last_reply')
      end
    end
    
    def display_badge(count, *args)
      options = args.extract_options!
      options[:min] ||= 15
      options[:max] ||= 30
      badge_class = '' if count == 0
      badge_class = 'badge-info' if count > 0 && count <= options[:min]
      badge_class = 'badge-warning' if count > options[:min] && count <= options[:max]
      badge_class = 'badge-important' if count > options[:max]
      content_tag(:span, count, class: "badge #{badge_class}")
    end
    
    def display_breadcrumb
      path = display_icon('home')
      if LiteBbs.show_site_path
        path << content_tag(:li, link_to(LiteBbs.site_name, main_app.root_path))
        path << divider
        path << content_tag(:li, link_to(LiteBbs.bbs_name, root_path))
      else
        path << content_tag(:li, link_to(LiteBbs.bbs_name, root_path))
      end
      if action_name == 'show'
        if controller_name == 'sections'
          path << divider
          path << @section.name
        end
        if controller_name == 'forums'
          path << divider
          path << link_to(@forum.section.name, @forum.section)
          path << divider
          path << @forum.name
        end
        if controller_name == 'topics'
          path << divider
          path << link_to(@topic.section.name, @topic.section)
          path << divider
          path << link_to(@topic.forum.name, @topic.forum)
        end
      end
      path << content_tag(:span, display_icon('search') + link_to(t('lite_bbs.actions.search'), "javascript:$('.search_form').toggle();"), class: 'search')
      result = content_tag(:ul, class: 'breadcrumb') do
        content_tag(:li) do
          path
        end
      end
      search_form = (is_mobile_request? ? display_mobile_search_form : display_search_form)
      result << content_tag(:div, search_form + advanced_search_link, class:'search_form')
      result.html_safe
    end

    def display_search_form
      result = search_form_for @q, url: search_path, html: {class: 'form-search'} do |f|
        content_tag(:div, class: 'input-append') do
          concat f.text_field :title_cont, class: 'search-query', placeholder: t('lite_bbs.actions.search_tip')
          concat f.submit t('lite_bbs.actions.search'), class: 'btn btn-primary'
        end
      end
      result.html_safe
    end
        
    def display_mobile_search_form
      result = search_form_for @q, url: search_path, html: {class: 'form-search'} do |f|
        concat f.text_field :title_cont, class: 'search-query', placeholder: t('lite_bbs.actions.search_tip')
      end
      result.html_safe      
    end
    
    def advanced_search_link
      link_to(t('lite_bbs.actions.advanced_search'), advanced_search_path)
    end
            
    def divider
      content_tag(:span, '/', class: 'divider')
    end
    
    def last_reply_path(topic, replies_count)
      offset = replies_count % LiteBbs.replies_per_page > 0 ? 1 : 0
      topic_path(topic) + "?page=#{(replies_count / LiteBbs.replies_per_page.to_i).to_i + offset}#reply_#{topic.last_reply.id}"
    end
  end
end
