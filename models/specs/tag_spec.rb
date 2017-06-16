require('minitest/autorun')
require('minitest/rg')
require('pry-byebug')
require_relative('../tag')

class TagTest < MiniTest::Test

  def setup

    @tag1 = Tag.new({
      "id" => 1,
      "name" => "clothes"
      })

    @tag2 = Tag.new({
      "id" => 2,
      "name" => "food"
      })

  end

  def test_id
    assert_equal(1, @tag1.id)
  end

  def test_name
    assert_equal("food", @tag2.name)
  end

end