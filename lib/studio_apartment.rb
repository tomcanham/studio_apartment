require 'active_support/concern'

module StudioApartment
  module Model
    extend ActiveSupport::Concern

    module ClassMethods
      def current_tenant
        Thread.current[:tenant]
      end

      def acts_as_tenant(association_name)
        self.class_eval do
          default_scope do 
            if current_tenant.present?
              self.where(association_name => current_tenant)
            else
              self.none
            end
          end
        end
      end
    end
  end

  module Controller
    extend ActiveSupport::Concern

    def current_tenant
      Thread.current[:tenant]
    end

    def current_tenant=(new_tenant)
      Thread.current[:tenant] = new_tenant
    end

    module ClassMethods
      def set_tenant_with(symbol)
        self.class_exec(symbol) do |symbol|
          prepend_around_action do |controller, action|
            begin
              self.current_tenant = self.send(symbol)
              action.call     
            ensure  
              self.current_tenant = nil
            end
          end
        end
      end
    end
  end
end

class ActiveRecord::Base
  include StudioApartment::Model
end

class ActionController::Base
  include StudioApartment::Controller
end