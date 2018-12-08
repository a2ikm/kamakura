require "test_helper"

class KamakuraTest < Minitest::Test
  class User
    include Kamakura
  end

  def test_attributes
    user = User.new(:name => "Piotr", :age => 31)
    assert_equal({ :name => "Piotr", :age => 31 }, user.attributes)
  end
end
