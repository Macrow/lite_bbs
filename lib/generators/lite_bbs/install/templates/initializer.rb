# encoding: utf-8

LiteBbs.config do |bbs|
  bbs.site_name = 'Lite'
  bbs.show_site_path = false
  bbs.bbs_name = 'LiteBBS'
  bbs.topics_per_page = 10
  bbs.replies_per_page = 10
  bbs.layout_name = 'lite_layout'
  bbs.display_flash_message = true
  
  # user/account/person model config
  bbs.user_class = 'User'
  # bbs.user_class = 'Account'
  # bbs.user_class = 'Person'
  # bbs.user_class = 'YourClass'

  # helper methods, used by LiteBBS, please using String for method names.
  bbs.litebbs_helper_methods[:current_user] = 'current_user' 
  
  
  # -----------------------------------------------------------------
  # These methods must povide by your own 'user' class.
  # methods about user, used by LiteBBS, please using String for method names.
  # -----------------------------------------------------------------
    
  bbs.litebbs_user_helper_methods[:admin?] = 'admin?'
  # bbs.litebbs_user_helper_methods[:admin?] = 'is_admin'
  # bbs.litebbs_user_helper_methods[:admin?] = 'my_own_is_admin_method_name'
  
  bbs.litebbs_user_helper_methods[:name] = 'name'
  # bbs.litebbs_user_helper_methods[:name] = 'user_name'
  # bbs.litebbs_user_helper_methods[:name] = 'my_own_name_method_name'
  
  bbs.litebbs_user_helper_methods[:email] = 'email'
  # bbs.litebbs_user_helper_methods[:email] = 'user_mail'
  # bbs.litebbs_user_helper_methods[:email] = 'my_own_email_method_name'
  
  bbs.litebbs_user_helper_methods[:image] = 'image'
  # bbs.litebbs_user_helper_methods[:image] = 'user_image'
  # bbs.litebbs_user_helper_methods[:image] = 'my_own_image_method_name'
end
