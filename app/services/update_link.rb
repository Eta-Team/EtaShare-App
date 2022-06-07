# frozen_string_literal: true

require 'http'

module EtaShare
  # Service to edit link
  class UpdateLink
    def initialize(config)
      @config = config
    end

    def api_url
      @config.API_URL
    end

    def call(current_account:, link_id:, link_data:)
      config_url = "#{api_url}/links/#{link_id}"
      response = HTTP.auth("Bearer #{current_account.auth_token}")
                     .put(config_url, json: link_data)
      # binding.pry
      response.code == 200 ? JSON.parse(response.body.to_s)['data'] : raise
    end
  end
end
