# frozen_string_literal: true

class ChangeActiveToProducts < ActiveRecord::Migration[5.2]
  def change
    change_column :products, :active, :boolean, default: true
  end
end
