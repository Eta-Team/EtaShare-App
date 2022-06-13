# frozen_string_literal: true

require 'roda'

module EtaShare
  # Web controller for EtaShare API
  class App < Roda
    route('links') do |routing|
      routing.on do
        routing.redirect '/' unless @current_account.logged_in?
        @links_route = '/links'

        routing.on(String) do |link_id|
          @link_route = "#{@links_route}/#{link_id}"

          # GET /links/[link_id]
          routing.get do
            link_info = GetLink.new(App.config).call(
              @current_account, link_id
            )
            link = Link.new(link_info)

            view :link, locals: {
              current_account: @current_account, link:
            }

          rescue StandardError => e
            puts "#{e.inspect}\n#{e.backtrace}"
            flash[:error] = 'Link no longer available'
            routing.redirect @links_route
          end

          routing.is do
            routing.post do
              method = routing.params['_method']

              link_data = Form::EditLink.new.call(routing.params)

              if link_data.failure?
                flash[:error] = Form.message_values(link_data)
                routing.halt
              end

              tasks = {
                'put' => { service: UpdateLink,
                           message: 'Updated Link Information' }
              }
              task = tasks[method]
              # binding.pry
              task[:service].new(App.config).call(
                current_account: @current_account,
                link_id:,
                link_data: link_data.to_h
              )

              flash[:notice] = 'Your link was updated'
              routing.redirect @links_route
            rescue StandardError => e
              puts e.inspect
              puts e.backtrace
              flash[:error] = 'Could not update link'
            ensure
              routing.redirect @link_route
            end
          end

          routing.on('destroy') do
            DeleteLink.new(App.config).call(
              current_account: @current_account,
              link_id:
            )

            flash[:notice] = 'Your link was deleted'
            routing.redirect @links_route
          rescue StandardError => e
            puts e.inspect
            puts e.backtrace
            flash[:error] = 'Could not delete link'
          ensure
            routing.redirect @links_route
          end

          routing.on('accessors') do
            # POST api/v1/links/[link_id]/accessors
            routing.post do
              action = routing.params['action']
              accessor_info = Form::AccessorEmail.new.call(routing.params)
              if accessor_info.failure?
                flash[:error] = Form.validation_errors(accessor_info)
                routing.halt
              end

              task_list = {
                'add' => { service: AddAccessor,
                           message: 'Added new accessor to link' },
                'remove' => { service: RemoveAccessor,
                              message: 'Removed accessor from link' }
              }

              task = task_list[action]
              # binding.pry
              task[:service].new(App.config).call(
                current_account: @current_account,
                accessor: accessor_info,
                link_id:
              )

              flash[:notice] = task[:message]

            rescue StandardError
              flash[:error] = 'Could not find accessor'
            ensure
              routing.redirect @link_route
            end
          end

          # POST /links/[link_id]/files/
          routing.on('files') do
            routing.is do
              routing.post do
                file_data = Form::NewFile.new.call(routing.params)

                if file_data.failure?
                  flash[:error] = Form.message_values(file_data)
                  routing.halt
                end

                CreateNewFile.new(App.config).call(
                  current_account: @current_account,
                  link_id:,
                  file_data: file_data.to_h
                )

                flash[:notice] = 'Your file was added'
              rescue StandardError => e
                puts e.inspect
                puts e.backtrace
                flash[:error] = 'Could not add file'
              ensure
                routing.redirect @link_route
              end
            end

            routing.on(String) do |file_id|
              DeleteFile.new(App.config).call(
                current_account: @current_account,
                link_id:,
                file_id:
              )

              flash[:notice] = 'Your file was deleted'
              routing.redirect @link_route
            rescue StandardError => e
              puts e.inspect
              puts e.backtrace
              flash[:error] = 'Could not delete file'
            ensure
              routing.redirect @link_route
            end
          end
        end

        # GET /links/
        routing.get do
          link_list = GetAllLinks.new(App.config).call(@current_account)
          links = Links.new(link_list)

          view :home, locals: {
            current_account: @current_account, links:
          }
        end

        # POST /links/
        routing.post do
          routing.redirect '/' unless @current_account.logged_in?
          puts "LINK: #{routing.params}"
          link_data = Form::NewLink.new.call(routing.params)
          if link_data.failure?
            flash[:error] = Form.message_values(link_data)
            routing.halt
          end

          CreateNewLink.new(App.config).call(
            current_account: @current_account,
            link_data: link_data.to_h
          )

          flash[:notice] = 'Link successfully created'
        rescue StandardError => e
          puts "FAILURE Creating Link: #{e.inspect}"
          flash[:error] = 'Could not create link'
        ensure
          routing.redirect @links_route
        end
      end
    end
  end
end
