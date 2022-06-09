# frozen_string_literal: true

require 'http'

module EtaShare
  # Returns an authenticated user, or nil
  class VerifyRegistration
    class VerificationError < StandardError; end
    class ApiServerError < StandardError; end

    def initialize(config)
      @config = config
    end

    def call(registration_data)
      registration_data = registration_data.to_h
      registration_token = SecureMessage.encrypt(registration_data)
      registration_data['verification_url'] =
        "#{@config.APP_URL}/auth/register/#{registration_token}"
      binding.pry

      response = HTTP.post("#{@config.API_URL}/auth/register",
                           json: registration_data)

      raise(VerificationError) unless response.code == 202

      JSON.parse(response.to_s)
    rescue HTTP::ConnectionError
      raise(ApiServerError)
    end
  end
end
