# frozen_string_literal: true

require_relative 'form_base'

module EtaShare
  module Form
    # Adding a new link
    class EditLink < Dry::Validation::Contract
      config.messages.load_paths << Object::File.join(__dir__, 'errors/edit_link.yml')

      params do
        optional(:title).maybe(max_size?: 100, format?: FILENAME_REGEX)
        optional(:description).maybe(max_size?: 255, format?: FILENAME_REGEX)
        optional(:valid_period).filled
      end

      rule(:valid_period) do
        # binding.pry
        key.failure('Should be equal to 0 or less than 3000') unless (value.to_i) >= 0 && (value.to_i) < 3000
      end
    end
  end
end
