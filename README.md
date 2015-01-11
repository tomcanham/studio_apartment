# studio_apartment
Lightweight multitenanting library

Alternative to the apartment gem, which is heavy and makes a lot of assumptions.

The primary goal of this is a lightweight way to "set it and forget it" for multitenanted applications. We should be able to use a single schema (and not rely upon Postgres magic) with proper relations. But we shouldn't have to put Model.scoped_by(tenant) on every single model use in the controllers.

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

Now, when your controller actions access a tenated model, the default scope will be set to the "correctly tenanted" subset (per account, in the above example). Model.all will give Model.all.where(account_id: current_account_id). And if no tenant is set, you'll get Model.none.

Finally, to skip tenanting, just use Model.unscoped.