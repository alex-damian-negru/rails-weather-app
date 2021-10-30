# frozen_string_literal: true

class Temperature < ApplicationRecord
  self.inheritance_column = '_disabled'

  enum type: { cold: :cold, warm: :warm, hot: :hot }
end
