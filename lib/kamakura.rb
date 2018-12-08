require "kamakura/version"

module Kamakura
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
