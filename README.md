# studio_apartment
Lightweight multitenanting library

Alternative to the apartment gem, which is heavy and makes a lot of assumptions.

To install: 

Add 

```ruby
gem 'studio_apartment'
```

to your Gemfile.

You will need to mark up your models with "acts_as_tenant" on a relationship:

```ruby
class User < ActiveRecord::Base
  belongs_to :account
  
  acts_as_tenant :account
end
```

Finally, you'll need to set the current tenant in your controller to enable tenanting:

```ruby
class ApplicationController < ActionController::Base

  ...

  helper_method :current_account
  set_tenant_with :get_account

  private

  def get_account
    # obviously, this is a contrived example; don't do this!
    Account.find(params[:account]) if params[:account].present?
  end

  def  current_account
    current_tenant
  end
end
```