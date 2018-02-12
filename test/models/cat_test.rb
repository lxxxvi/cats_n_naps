require 'test_helper'

class CatTest < ActiveSupport::TestCase
  test "association is valid" do
    cat = Cat.new(name: 'Fritz')
    cat.naps.new(title: 'Naptime')
    assert cat.valid?
  end
end
