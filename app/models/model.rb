# frozen_string_literal: true

class Model
  include ActiveModel::Model

  def attributes = instance_variables.map(&:to_s).map { _1.delete_prefix('@') }.map(&:to_sym)

  def to_h
    attributes.reduce({}) { |hash, attribute| hash.merge({ attribute => instance_variable_get("@#{attribute}") }) }
  end
end
