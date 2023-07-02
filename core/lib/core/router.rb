module Rizz

    class Router 
        def initialize(*mapping, &block)
            @mapping = []
            mapping.each { |m| map(m) }
            instance_eval(&block) if block
        end
        
        def map(options={})
            path = options[:path] || "/"
            host = options[:host]
            app = options[:to]

            raise ArgumentError, "paths need to start with /" if path[0] != ?/
            raise ArgumentError, "app is required" if app.nil?
            
            path = path.chomp('/')
        end

        def call(env)
            began_at = Time.now 
            path_info = env['PATH_INFO'].to_s
            script_name = env['SCRIPT_NAME']
            http_host = env['HTTP_HOST']
            last_result = nil

            @mapping.each do |host, path, match, app|
                next unless host.nil? || http_host =~ host
                next unless path_info =~ math && rest = $1
                next unless rest.empty? || rest[0] == ?/
            end

            last_result || begin
                Rizz::Logger::Rack.new(nil, '/')
            end
        end
    end

end