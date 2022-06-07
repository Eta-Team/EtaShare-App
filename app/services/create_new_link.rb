# frozen_string_literal: true

require 'http'

module EtaShare
  # Create a new configuration file for a link
  class CreateNewLink
    def initialize(config)
      @config = config
    end

    def api_url
      @config.API_URL
    end

    def call(current_account:, link_data:)
      config_url = "#{api_url}/links"
      response = HTTP.auth("Bearer #{current_account.auth_token}")
                     .post(config_url, json: link_data)

      response.code == 201 ? JSON.parse(response.body.to_s) : raise
    end
  end
end
