module LiteBbs
  module Admin
    module ApplicationHelper
      def display_bar(max, count)
        content_tag(:div, content_tag(:div, '', class: 'bar', style: "width: #{(100*count/(max+1)).to_i + 1}%"), class: 'progress').html_safe
      end
      
      def content_template_begin
        "#{display_flash}
        #{title "#{LiteBbs::bbs_name} - #{t('lite_bbs.common.administraion')}"}
        <div id='lite_bbs'><table class='table admin'>
        <tbody><tr><td>
        <div class='span3'>#{render('lite_bbs/admin/shared/sidebar')}</div>
        <div class='span1'></div>
        <div class='span12'>".html_safe
      end
      
      def content_template_end            
        "</div></td></tr></tbody></table></div>".html_safe
      end
    end
  end
end
