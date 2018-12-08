require "kamakura/attribute"
require "kamakura/version"

module Kamakura
  module ClassMethods
    def attribute(name, type, options = {})
      attribute = Attribute.new(name, type, options)
      register_attribute(attribute)
      define_attribute_reader_method(attribute)
    end

    def parse(attributes = {})
      new(attributes)
    end

    def attribute_set
      @__attribute_set ||= {}
    end

    private

    def define_attribute_reader_method(attribute)
      name = attribute.name
      class_eval <<~RUBY
        def #{name}
          self[:"#{name}"]
        end
      RUBY
    end

    def register_attribute(attribute)
      attribute_set[attribute.key] = attribute
    end
  end

  def self.included(klass)
    klass.extend(ClassMethods)
  end

  def initialize(attributes = {})
    @__attributes = parse_attributes(attributes).freeze
  end

  def attributes
    @__attributes
  end

  def [](name)
    @__attributes[name.to_sym]
  end

  private

  def parse_attributes(hash)
    hash.inject({}) do |s, (key, value)|
      key = key.to_sym
      attribute = self.class.attribute_set[key]
      if attribute
        s[attribute.name] = attribute.parse(value)
      else
        s[key] = value
      end
      s
    end
  end
end
