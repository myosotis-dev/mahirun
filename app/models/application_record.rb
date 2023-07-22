class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  def valid_as_boolean?(key, value)
    unless !!value==value
      errors.add(key, "must be boolean.")
    end
  end
end
