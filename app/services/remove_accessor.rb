# frozen_string_literal: true

module EtaShare
  # Service to add accessor to link
  class RemoveAccessor
    class AccessorNotRemoved < StandardError; end

    def initialize(config)
      @config = config
    end

    def api_url
      @config.API_URL
    end

    def call(current_account:, accessor:, link_id:)
      response = HTTP.auth("Bearer #{current_account.auth_token}")
                     .delete("#{api_url}/links/#{link_id}/accessors",
                             json: { email: accessor[:email] })

      raise AccessorNotRemoved unless response.code == 200
    end
  end
end
