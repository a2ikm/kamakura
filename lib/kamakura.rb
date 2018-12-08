require "kamakura/version"

module Kamakura
  def initialize(attributes = {})
    @__attributes = attributes.dup.freeze
  end

  def attributes
    @__attributes
  end
end
