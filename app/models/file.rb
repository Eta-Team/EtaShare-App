# frozen_string_literal: true

require_relative 'link'

module EtaShare
  # Behaviors of the currently logged in account
  class File
    attr_reader :id, :name, :description, # basic info
                :content,
                :link # full details

    def initialize(info)
      process_attributes(info['attributes'])
      process_included(info['included'])
    end

    private

    def process_attributes(attributes)
      @id             = attributes['id']
      @name           = attributes['name']
      @description    = attributes['description']
      @content        = attributes['content']
    end

    def process_included(included)
      @link = Link.new(included['link'])
    end
  end
end
