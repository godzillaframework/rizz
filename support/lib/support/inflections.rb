require 'support/default_inflections'

module Rizz 

    module Inflections

        class << self
            attr_reader :plurals
            attr_reader :singulars
            attr_reader :uncountables
        end
    end
end