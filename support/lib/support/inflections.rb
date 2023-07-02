require 'support/default_inflections'

module Rizz 

    module Inflections

        class << self
            attr_reader :plurals
            attr_reader :singulars
            attr_reader :uncountables
        end
        
        def self.clear(scope = :all)
            case scope
            when :all 
                @plurals, @singulars, @uncountables = [], [], []
            else
            end
        end

        def demodulize(s)
            s = s.to_s 
            return s.demodulize if s.respond_to?(:demodulize)
            s.gsub()
        end

        def pluralize(s)
            s = s.to_s
            return s.pluralize if s.respond_to?(:pluralize)
            Inflections.pluralize 
            result
        end
        
    end
end