# frozen_string_literal: true

require 'http'

module EtaShare
  # Create a new configuration file for a project
  class CreateNewFile
    def initialize(config)
      @config = config
    end

    def api_url
      @config.API_URL
    end

    def call(current_account:, link_id:, file_data:)
      pdf_str = Object::File.read(file_data[:file][:tempfile])
      pdf_encoded = Base64.strict_encode64(pdf_str)
      config_url = "#{api_url}/links/#{link_id}/files"
      response = HTTP.auth("Bearer #{current_account.auth_token}")
                     .post(config_url, json: { 'content' => pdf_encoded,
                                               'name' => file_data[:file][:filename],
                                               'description' => file_data[:description] })

      response.code == 201 ? JSON.parse(response.body.to_s) : raise
    end
  end
end
