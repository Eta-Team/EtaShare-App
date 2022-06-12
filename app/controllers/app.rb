# frozen_string_literal: true

require 'roda'
require 'slim'
require 'slim/include'

module EtaShare
  # Base class for Etashare Web Application
  class App < Roda
    plugin :render, engine: 'slim', views: 'app/presentation/views'
    plugin :assets, path: 'app/presentation/assets',
                    css: 'style.css', js: 'index.js'
    plugin :public, root: 'app/presentation/public'
    plugin :multi_route
    plugin :flash

    route do |routing|
      response['Content-Type'] = 'text/html; charset=utf-8'
      @current_account = CurrentSession.new(session).current_account
      url = App.config.GOOGLE_OAUTH_URL
      oauth_params = ["client_id=#{App.config.GOOGLE_CLIENT_ID}",
                      "redirect_uri=#{App.config.REDIRECT_URI}",
                      "scope=#{App.config.SCOPE}",
                      'response_type=code'].join('&')
      @link = "#{url}?#{oauth_params}"

      routing.public
      routing.assets
      routing.multi_route

      # GET /
      routing.redirect '/links' if @current_account.logged_in?
      routing.root do
        view 'home', locals: { current_account: @current_account, g_url: @link }
      end
    end
  end
end
