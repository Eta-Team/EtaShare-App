# frozen_string_literal: true

module EtaShare
  # Behaviors of the currently logged in account
  class Link
    attr_reader :id, :name, :repo_url

    def initialize(link_info)
      @id = link_info['attributes']['id']
      @name = link_info['attributes']['name']
      @repo_url = link_info['attributes']['repo_url']
    end
  end
end
