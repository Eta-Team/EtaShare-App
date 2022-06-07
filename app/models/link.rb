# frozen_string_literal: true

module EtaShare
  # Behaviors of the currently logged in account
  class Link
    attr_reader :id, :description, :one_time, :valid_period, :title, :created_at,
                :owner, :accessors, :files, :policies # full details

    def initialize(link_info)
      process_attributes(link_info['attributes'])
      process_relationships(link_info['relationships'])
      process_policies(link_info['policies'])
    end

    private

    def process_attributes(attributes)
      @id = attributes['identifier']
      @title = attributes['title']
      @created_at = attributes['created_at']
      @description = attributes['description']
      @valid_period = attributes['valid_period']
      @one_time = attributes['one_time']
      @owner = attributes['owner']
    end

    def process_relationships(relationships)
      return unless relationships

      @owner = Account.new(relationships['owner'])
      @accessors = process_accessors(relationships['accessors'])
      @files = process_files(relationships['files'])
    end

    def process_policies(policies)
      @policies = OpenStruct.new(policies)
    end

    def process_files(files_info)
      return nil unless files_info

      files_info.map { |file_info| File.new(file_info) }
    end

    def process_accessors(accessors)
      return nil unless accessors

      accessors.map { |account_info| Account.new(account_info) }
    end
  end
end
