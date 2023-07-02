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
        app  = options[:to]
  
        raise ArgumentError, "paths need to start with /" if path[0] != ?/
        raise ArgumentError, "app is required" if app.nil?
  
        path  = path.chomp('/')
        match = Regexp.new("^#{Regexp.quote(path).gsub('/', '/+')}(.*)", nil, 'n')
        host  = Regexp.new("^#{Regexp.quote(host)}$", true, 'n') unless host.nil? || host.is_a?(Regexp)
  
        @mapping << [host, path, match, app]
      end
  
      def call(env)
        began_at = Time.now
        path_info = env["PATH_INFO"].to_s
        script_name = env['SCRIPT_NAME']
        http_host = env['HTTP_HOST']
        last_result = nil
  
        @mapping.each do |host, path, match, app|
          next unless host.nil? || http_host =~ host
          next unless path_info =~ match && rest = $1
          next unless rest.empty? || rest[0] == ?/
  
          rest = "/" if rest.empty?
  
          env['SCRIPT_NAME'] = script_name + path
          env['PATH_INFO'] = rest
          last_result = app.call(env)
  
          cascade_setting = app.respond_to?(:cascade) ? app.cascade : true
          cascade_statuses = cascade_setting.respond_to?(:include?) ? cascade_setting : Mounter::DEFAULT_CASCADE
          break unless cascade_setting && cascade_statuses.include?(last_result[0])
        end
        last_result || begin
          env['SCRIPT_NAME'] = script_name
          env['PATH_INFO'] = path_info
          Rizz::Logger::Rack.new(nil,'/').send(:log, env, 404, {}, began_at) if logger.debug?
          [404, {"Content-Type" => "text/plain", "X-Cascade" => "pass"}, ["Not Found: #{path_info}"]]
        end
      end
    end
  end