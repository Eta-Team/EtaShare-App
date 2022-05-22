# frozen_string_literal: true

module EtaShare
  # Behaviors of the currently logged in account
  class Link
    attr_reader :id, :description, :is_clicked, :valid_period

    def initialize(link_info)
      @id = link_info['attributes']['id']
      @description = link_info['attributes']['description']
      @is_clicked = link_info['attributes']['is_clicked']
      @valid_period = link_info['attributes']['valid_period']
    end
  end
end
