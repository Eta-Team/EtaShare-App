# frozen_string_literal: true

require 'sequel'

Sequel.migration do
  change do
    create_table(:links) do
      primary_key :id

      String      :title, unique: true, null: false
      String      :description_secure, unique: true, null: false
      Integer     :is_clicked, null: false
      Integer     :valid_period_secure

      DateTime    :created_at
      DateTime    :updated_at
    end
  end
end
