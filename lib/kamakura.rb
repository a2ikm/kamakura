require "kamakura/version"

module Kamakura
  module ClassMethods
    def attribute(name)
      define_method(name) { self[name] }
    end
  end

  def self.included(klass)
    klass.extend(ClassMethods)
  end

  def initialize(attributes = {})
    @__attributes = symbolize_keys(attributes).freeze
  end

  def attributes
    @__attributes
  end

  def [](name)
    @__attributes[name.to_sym]
  end

  private

  def symbolize_keys(hash)
    hash.inject({}) do |s, (k, v)|
      s[k.to_sym] = v
      s
    end
  end
end
