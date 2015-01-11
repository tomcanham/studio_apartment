require 'active_support/concern'
require 'studio_apartment/version'

module StudioApartment
  def self.current_tenant
    Thread.current[:tenant]
  end

  def self.current_tenant=(new_tenant)
    Thread.current[:tenant] = new_tenant
  end

  module Model
    extend ActiveSupport::Concern

    module ClassMethods
      def acts_as_tenant(association_name)
        self.class_eval do
          default_scope do 
            if StudioApartment.current_tenant.present?
              self.where(association_name => StudioApartment.current_tenant)
            else
              self.all
            end
          end
        end
      end
    end
  end

  module Controller
    extend ActiveSupport::Concern

    module ClassMethods
      def set_tenant_with(tenant_setter)
        self.class_exec(tenant_setter) do |tenant_setter|
          prepend_around_action do |controller, action|
            begin
              StudioApartment.current_tenant = controller.send(tenant_setter)
              action.call     
            ensure  
              StudioApartment.current_tenant = nil
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