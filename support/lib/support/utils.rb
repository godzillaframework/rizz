require 'cgi'

module Rizz
  module Utils
    extend self

    def build_uri_query(object, namespace = nil)
      case object
      when Hash
        object.map do |key, value|
          next if value == {} || value == []
          build_uri_query(value, namespace ? "#{namespace}[#{key}]" : key)
        end.compact.join('&')
      when Array
        fail ArgumentError, 'namespace is missing' unless namespace
        (object.empty? ? [''] : object).map do |value|
          build_uri_query(value, "#{namespace}[]")
        end.join('&')
      else
        fail ArgumentError, 'namespace is missing' unless namespace
        "#{CGI.escape(namespace.to_s)}=#{CGI.escape(object.to_s)}"
      end
    end

    def deep_dup(object)
      case object
      when Array
        object.map{ |value| deep_dup(value) }
      when Hash
        object.each_with_object(object.dup.clear) do |(key, value), new_hash|
          new_hash[deep_dup(key)] = deep_dup(value)
        end
      when NilClass, FalseClass, TrueClass, Symbol, Numeric, Method
        object
      else
        begin
          object.dup
        rescue TypeError
          object
        end
      end
    end

    def symbolize_keys(hash)
      result = hash.class.new
      hash.each_key do |key|
        result[(key.to_sym rescue key)] = hash[key]
      end
      result
    end
  end
end