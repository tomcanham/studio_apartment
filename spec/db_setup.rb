require 'active_record'
require 'studio_apartment'

module StudiosTest
  class UserWithMixin < ActiveRecord::Base
    belongs_to :account
    
    acts_as_tenant :account
  end

  class UserWithoutMixin < ActiveRecord::Base
    belongs_to :account
  end

  class Account < ActiveRecord::Base
  end

  ActiveRecord::Base.establish_connection(
    :adapter => "sqlite3",
    :database => ":memory:")

  ActiveRecord::Base.connection.create_table(:user_with_mixins) do |t|
    t.integer :account_id
  end

  ActiveRecord::Base.connection.create_table(:user_without_mixins) do |t|
    t.integer :account_id
  end

  ActiveRecord::Base.connection.create_table(:accounts) do |t|
  end
end