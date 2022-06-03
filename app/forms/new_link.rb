# frozen_string_literal: true

require_relative 'form_base'

module EtaShare
  module Form
    # Each new link info
    class NewLink < Dry::Validation::Contract
      config.messages.load_paths << File.join(__dir__, 'errors/new_link.yml')

      params do
        required(:description).filled(:string)
        required(:valid_period).filled(format?: VALID_PERIOD_REGEX)
        required(:is_clicked).filled(:string)
      end
    end
  end
end
