# frozen_string_literal: true

module Filterable
  extend ActiveSupport::Concern

  module ClassMethods
    def filter(params)
      items = self.where(nil)
      params.each do |key, value|
        items = items.public_send key, value if value.present?
      end

      items
    end
  end
end