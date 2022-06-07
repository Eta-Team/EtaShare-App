# frozen_string_literal: true

require 'http'

module EtaShare
  # Returns a single link based on a link_id
  class GetLink
    def initialize(config)
      @config = config
    end

    def call(current_account, link_id)
      response = HTTP.auth("Bearer #{current_account.auth_token}")
                     .get("#{@config.API_URL}/links/#{link_id}")

      response.code == 200 ? JSON.parse(response.body.to_s)['data'] : nil
    end
  end
end
