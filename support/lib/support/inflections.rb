require 'support/default_inflections'

module Rizz
  module Inflections
    CAMELIZE_CONVERT_REGEXP = /(^|_)(.)/.freeze
    CAMELIZE_MODULE_REGEXP = /\/(.?)/.freeze
    DASH = '-'.freeze
    DEMODULIZE_CONVERT_REGEXP = /^.*::/.freeze
    EMPTY_STRING= ''.freeze
    SLASH = '/'.freeze
    VALID_CONSTANT_NAME_REGEXP = /\A(?:::)?([A-Z]\w*(?:::[A-Z]\w*)*)\z/.freeze
    UNDERSCORE = '_'.freeze
    UNDERSCORE_CONVERT_REGEXP1 = /([A-Z]+)([A-Z][a-z])/.freeze
    UNDERSCORE_CONVERT_REGEXP2 = /([a-z\d])([A-Z])/.freeze
    UNDERSCORE_CONVERT_REPLACE = '\1_\2'.freeze
    UNDERSCORE_MODULE_REGEXP = /::/.freeze

    @plurals, @singulars, @uncountables = [], [], []

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
        instance_variable_set("@#{scope}", [])
      end
    end

    def self.irregular(singular, plural)
      plural(Regexp.new("(#{singular[0,1]})#{singular[1..-1]}$", "i"), '\1' + plural[1..-1])
      singular(Regexp.new("(#{plural[0,1]})#{plural[1..-1]}$", "i"), '\1' + singular[1..-1])
    end

    def self.plural(rule, replacement)
      @plurals.insert(0, [rule, replacement])
    end

    def self.singular(rule, replacement)
      @singulars.insert(0, [rule, replacement])
    end

    def self.uncountable(*words)
      (@uncountables << words).flatten!
    end

    instance_eval(&DEFAULT_INFLECTIONS_PROC)

    extend self

    def camelize(s)
      s = s.to_s
      return s.camelize if s.respond_to?(:camelize)
      s = s.gsub(CAMELIZE_MODULE_REGEXP){|x| "::#{x[-1..-1].upcase unless x == SLASH}"}.gsub(CAMELIZE_CONVERT_REGEXP){|x| x[-1..-1].upcase}
      s
    end

    def constantize(s)
      s = s.to_s
      return s.constantize if s.respond_to?(:constantize)
      raise(NameError, "#{s.inspect} is not a valid constant name!") unless m = VALID_CONSTANT_NAME_REGEXP.match(s)
      Object.module_eval("::#{m[1]}", __FILE__, __LINE__)
    end

    def demodulize(s)
      s = s.to_s
      return s.demodulize if s.respond_to?(:demodulize)
      s.gsub(DEMODULIZE_CONVERT_REGEXP, EMPTY_STRING)
    end

    def pluralize(s)
      s = s.to_s
      return s.pluralize if s.respond_to?(:pluralize)
      result = s.dup
      Inflections.plurals.each{|(rule, replacement)| break if result.gsub!(rule, replacement)} unless Inflections.uncountables.include?(s.downcase)
      result
    end

    def singularize(s)
      s = s.to_s
      return s.singularize if s.respond_to?(:singularize)
      result = s.dup
      Inflections.singulars.each{|(rule, replacement)| break if result.gsub!(rule, replacement)} unless Inflections.uncountables.include?(s.downcase)
      result
    end

    def underscore(s)
      s = s.to_s
      return s.underscore if s.respond_to?(:underscore)
      s.gsub(UNDERSCORE_MODULE_REGEXP, SLASH).gsub(UNDERSCORE_CONVERT_REGEXP1, UNDERSCORE_CONVERT_REPLACE).
        gsub(UNDERSCORE_CONVERT_REGEXP2, UNDERSCORE_CONVERT_REPLACE).tr(DASH, UNDERSCORE).downcase
    end

    def humanize(s)
      s = s.to_s
      return s.humanize if s.respond_to?(:humanize)
      s.gsub(/_id$/, '').tr('_', ' ').capitalize
    end

    def classify(s)
      s = s.to_s
      return s.classify if s.respond_to?(:classify)
      camelize(singularize(s.sub(/.*\./, '')))
    end
  end
end