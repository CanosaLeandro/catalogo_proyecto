# frozen_string_literal: true

class ApplicationDecorator < Draper::Decorator
  def self.collection_decorator_class
    PaginationDecorator
  end
end
