# frozen_string_literal: true

class Model
  include ActiveModel::Model

  def self.attributes = instance_methods.grep(/[a-z_]+=/).map { _1.to_s.delete_suffix('=').to_sym } - [:attributes]

  def attributes = self.class.attributes.map(&:to_s).map { _1.delete_prefix('@') }.map(&:to_sym)

  def to_h
    attributes.reduce({}) { |hash, attribute| hash.merge({ attribute => instance_variable_get("@#{attribute}") }) }
  end
end
