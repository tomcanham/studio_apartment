require 'active_support/concern'
require 'studio_apartment/version'
require 'request_store'

module StudioApartment
  def self.current_tenant
    RequestStore.store[:tenant]
  end

  def self.current_tenant=(new_tenant)
    RequestStore.store[:tenant] = new_tenant
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
end

class ActiveRecord::Base
  include StudioApartment::Model
end