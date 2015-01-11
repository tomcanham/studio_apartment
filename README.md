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