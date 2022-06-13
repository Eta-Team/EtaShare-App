# frozen_string_literal: true

require_relative 'form_base'

module EtaShare
  module Form
    # Each new link info
    class NewLink < Dry::Validation::Contract
      config.messages.load_paths << Object::File.join(__dir__, 'errors/new_link.yml')

      params do
        required(:title).filled(max_size?: 100, format?: FILENAME_REGEX)
        required(:description).maybe(max_size?: 255, format?: FILENAME_REGEX)
        required(:valid_period).filled
        required(:one_time).filled
      end

      rule(:valid_period) do
        # binding.pry
        key.failure('Should be equal to 0 or less than 3000') unless (value.to_i) >= 0 && (value.to_i) < 3000
      end

      rule(:one_time) do
        # binding.pry
        key.failure('Should be equal to 0 or equal to 1') unless (value.to_i) >= 0 && (value.to_i) < 2
      end
    end
  end
end
