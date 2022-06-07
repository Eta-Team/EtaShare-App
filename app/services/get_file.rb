# frozen_string_literal: true

require 'http'

module EtaShare
  # Returns a file belonging to a link
  class GetFile
    def initialize(config)
      @config = config
    end

    def call(user, file_id)
      response = HTTP.auth("Bearer #{user.auth_token}")
                     .get("#{@config.API_URL}/files/#{file_id}")

      response.code == 200 ? JSON.parse(response.body.to_s)['data'] : nil
    end
  end
end
