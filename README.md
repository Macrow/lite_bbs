# LiteBBS

LiteBBS can easliy integrate into your exiting or new rails application, it's a mountable engine.
LiteBBS is a simple, clean forum app engine, it's optimized for phone view.

<img src="https://github.com/Macrow/lite_bbs/raw/master/screenshots/LiteBBS.png" alt="LiteBBS">

## Installation and usage

### Add this to your Gemfile

```ruby
  gem 'lite_bbs', :git => 'git://github.com/Macrow/lite_bbs.git'
```

### Run "bundle" command.

```bash
  bundle
```

### Run LiteBBS's install command.

```bash
  rails g lite_bbs:install
```

### Migrate you database:

```bash
  rake db:migrate
```

By default, LiteBBS will be mounted at '/bbs' in your rails application.

## Requirement

### "User/Account/Person" Model & "admin?, name, email, image" User's methods

LiteBBS require a user/account/person model, in the model class, LiteBBS need some methods(admin?, name, email, image), you can change the names in configuration.

eg:

```ruby
  class User < ActiveRecord::Base
    # ....................
    # .... some codes ....
    # ....................
    
    def admin?
      is_admin # is_admin is a boolean column of users table
    end
    
    def email
      user_email # user_email is a string column of users table
    end
  
    def name
      user_name # user_name is a string column of users table
    end
  
    def image
      image || 'user.gif' # image is a string column of users table
      # "http://www.domain.com/images/#{name}.gif" # you can use image url instead
    end
  end
```

Devise user model:
```ruby
  class User < ActiveRecord::Base
    devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :trackable, :validatable

    # Setup accessible (or protected) attributes for your model
    attr_accessible :email, :password, :password_confirmation, :remember_me
  
    def admin?
      email == 'admin@domain.com'
    end
  
    def name
      email.gsub(/@.*/, '').capitalize
    end
    
    def image
      "http://www.domain.com/images/#{name}.gif" # you can use image url instead
    end
  end
```

### "current_user" Helper method

you must provide 'current_user' helper methods for retrive current user object, you can change the names in configuration.
If you're using Devise, it provides the 'current_user' method.
```ruby
  current_user # return current user object
```

## Configuration

```ruby
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
```

## Helper methods:

LiteBBS provides some helper methods:

```ruby
section_name, forum_name, topic_title
```

You can use these methods in you own template.

## Demo datas:

You can load demo datas for testing, but it will erase all the old datas !

```bash
  rake lite_bbs:demo:load
```

## Administration

You can access '/bbs/admin' for LiteBBS's administration if the user's admin? method return 'true'.

<img src="https://github.com/Macrow/lite_bbs/raw/master/screenshots/LiteBBS-Administration.png" alt="LiteBBS">

## License

This project rocks and uses MIT-LICENSE.


# LiteBBS中文文档

LiteBBS能够轻松地集成到你现有或者新建的Rails程序中，它是一个Mountable Engine。
LiteBBS是一个简洁，轻快的论坛程序，而且专为手机浏览优化。

## 安装和使用

### 将下列代码加入到你的Gemfile中

```ruby
  gem 'lite_bbs', :git => 'git://github.com/Macrow/lite_bbs.git'
```

### 运行"bundle"命令

```bash
  bundle
```

### 运行LiteBBS的安装命令

```bash
  rails g lite_bbs:install
```

### 更新你的数据库

```bash
  rake db:migrate
```

默认情况下，LiteBBS会挂载到'/bbs'目录下

## 使用需求

### "User/Account/Person" 用户模型，"admin?, name, email, image" 用户方法

LiteBBS需要一个用户模型，该模型的类名不受限制，该类中需要实现一些方法（admin?, name, email, image），当然，你可以在配置文件中对这些方法名称进行修改。

例子:

```ruby
  class User < ActiveRecord::Base
    # ....................
    # ....     代码     ....
    # ....................
    
    def admin?
      is_admin # is_admin在users数据表中是一个boolean字段
    end
    
    def email
      user_email # user_email在users数据表中是一个string字段
    end
  
    def name
      user_name # user_name在users数据表中是一个string字段
    end
  
    def image
      image || 'user.gif' # image在users数据表中是一个string字段
      # "http://www.domain.com/images/#{name}.gif" # 你还可以直接使用url地址
    end
  end
```

Devise示例:
```ruby
  class User < ActiveRecord::Base
    devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :trackable, :validatable

    # Setup accessible (or protected) attributes for your model
    attr_accessible :email, :password, :password_confirmation, :remember_me
  
    def admin?
      email == 'admin@domain.com'
    end
  
    def name
      email.gsub(/@.*/, '').capitalize
    end
    
    def image
      "http://www.domain.com/images/#{name}.gif" # 你还可以直接使用url地址
    end
  end
```

### "current_user" Helper方法

你必须提供一个'current_user'的helper方法，该方法用于获取当前用户，当然，你可以在配置中修改方法名称。
如果你使用的是Devise，它已经提供了一个'current_user'方法。
```ruby
  current_user # 返回当前用户
```

## 配置

```ruby
  LiteBbs.config do |bbs|
    bbs.site_name = 'Lite'
    bbs.show_site_path = false
    bbs.bbs_name = 'LiteBBS'
    bbs.topics_per_page = 10
    bbs.replies_per_page = 10
    bbs.layout_name = 'lite_layout'
    bbs.display_flash_message = true
  
    # 用户模型配置
    bbs.user_class = 'User'
    # bbs.user_class = 'Account'
    # bbs.user_class = 'Person'
    # bbs.user_class = 'YourClass'

    # current_user 配置
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
```

## Helper方法:

LiteBBS提供了一些helper方法:

```ruby
section_name, forum_name, topic_title
```

你可以在自己的模板中调用这些方法。

## 示例数据:

你可以加载示例数据，不过请注意，这会抹掉以前的所有数据！

```bash
  rake lite_bbs:demo:load
```

## 后台管理

你可以通过'/bbs/admin'访问后台管理，条件是用户的admin?方法返回的是true

## 许可

MIT-LICENSE.