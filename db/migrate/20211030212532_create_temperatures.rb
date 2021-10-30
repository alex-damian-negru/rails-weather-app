# frozen_string_literal: true

class CreateTemperatures < ActiveRecord::Migration[6.1]
  def up
    create_enum :temperature_definitions, %w[cold warm hot]

    create_table :temperatures do |t|
      t.enum :type, as: 'temperature_definitions'
      t.integer :min
      t.integer :max

      t.timestamps
    end
  end

  def down
    drop_table :temperatures

    drop_enum :temperature_definitions
  end
end
