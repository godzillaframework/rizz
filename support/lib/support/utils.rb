require 'cgi'

module Rizz
    module Utils
        extend self

        def build_uri_query(object, namespace = nil)
            case object
            when Hash
                object.map do |key, value|
                    next if value == {} || value == []
                    build_uri_query(value, namespace ? "#{namespace}")
                end
            end
        end

        def symbolize_keys(hash)
            results = hash.class.new
            hash.each_key do |key|
                result[(key.to_sym rescue key)]  = hash[key]
            end
        end


    end
end