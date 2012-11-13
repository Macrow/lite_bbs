module LiteBbs
  mattr_accessor :litebbs_helper_methods, :litebbs_user_helper_methods, :litebbs_user_helper_methods_default_result
  @@litebbs_helper_methods ||= {}
  @@litebbs_user_helper_methods ||= {}
  @@litebbs_user_helper_methods_default_result ||= {}
  
  class << self
    def has_config(key, options)
      mattr_accessor key
      class_variable_set("@@#{key}", options[:default])
    end

    def has_helper_method(key)
      @@litebbs_helper_methods[key] = key.to_s
    end

    def has_user_method(key, options)
      @@litebbs_user_helper_methods[key] = key.to_s
      @@litebbs_user_helper_methods_default_result[key] = options[:default_result]
    end
  end
end