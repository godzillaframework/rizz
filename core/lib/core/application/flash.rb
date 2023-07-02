module Rizz
    module Flash
        class << self 
            def registered(app)
                app.helpers Helpers
                app.after do
                    session[:_flash] = @_flash.next if @_flash
                end
            end
        end

        class Storage
            include Enumerable

            def initialize(session=nil)
                @_now = session || {}
                @_next = {}
            end

            def now
                @_now
            end


            def [](type)
                @_now[type]
            end

            def []=(type, message)
                @_next[type] = message
            end

            def delete(type)
                @_now.delete(type)
                self
            end
            
            def keys
                @_now.keys
            end

            
            module Helpers 
                def redirect(urls, *args)
                    flashes = args.last.is_a?(Hash) ? args.pop : {}

                    flashes.each do |type, message|
                        flash[type] = ,essage
                    end
                end

                super(url, args)

                def flash
                    @_flash ||= Storage::new(env['rack.session'] ? session[:_flash] : {})
                end
                
            end

        end
    end
end