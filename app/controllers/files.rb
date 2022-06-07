# frozen_string_literal: true

require 'roda'

module EtaShare
  # Web controller for EtaShare API
  class App < Roda
    route('files') do |routing|
      routing.redirect '/' unless @current_account.logged_in?

      # GET /files/[file_id]
      routing.get(String) do |file_id|
        file_info = GetFile.new(App.config)
                           .call(@current_account, file_id)
        file = File.new(file_info)

        view :file, locals: {
          current_account: @current_account, file:
        }
      end
    end
  end
end
