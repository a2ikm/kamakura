require "kamakura/attribute"
require "kamakura/version"

module Kamakura
  module ClassMethods
    def attribute(name, type)
      attribute = Attribute.new(name, type)
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
      attribute_set[attribute.name] = attribute
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
    hash.inject({}) do |s, (name, value)|
      name = name.to_sym
      attribute = self.class.attribute_set[name]
      s[name] = attribute ? attribute.parse(value) : value
      s
    end
  end
end
