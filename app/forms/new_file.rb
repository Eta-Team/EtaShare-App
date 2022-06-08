# frozen_string_literal: true

require_relative 'form_base'

module EtaShare
  module Form
    # Adding a new link
    class NewFile < Dry::Validation::Contract
      config.messages.load_paths << Object::File.join(__dir__, 'errors/new_file.yml')

      params do
        required(:description).filled(max_size?: 220)
        required(:file).filled
      end

      rule(:file) do
        key.failure('Only supports PDF') unless value[:type] == 'application/pdf'
        key.failure('File too big') unless value[:tempfile].size / 1024 < 20_000 # MAX: 20MB
      end
    end
  end
end
