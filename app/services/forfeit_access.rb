# frozen_string_literal: true

module EtaShare
  # Service to forfeit access to link
  class ForfeitAccess
    class AccessNotForfeited < StandardError; end

    def initialize(config)
      @config = config
    end

    def api_url
      @config.API_URL
    end

    def call(current_account:, link_id:)
      response = HTTP.auth("Bearer #{current_account.auth_token}")
                     .delete("#{api_url}/links/#{link_id}/forfeit")

      raise AccessNotForfeited unless response.code == 200
    end
  end
end
