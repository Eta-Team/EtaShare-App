# frozen_string_literal: true

module EtaShare
  # Service to add accessor to link
  class DeleteLink
    class LinkNotDeleted < StandardError; end

    def initialize(config)
      @config = config
    end

    def api_url
      @config.API_URL
    end

    def call(current_account:, link_id:)
      response = HTTP.auth("Bearer #{current_account.auth_token}")
                     .delete("#{api_url}/links/#{link_id}")

      raise LinkNotDeleted unless response.code == 200
    end
  end
end
