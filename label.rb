require_relative 'item'
class Label
  attr_accessor :title, :color, :items

  def initialize(title, color, items)
    @id = Random.rand(1..1000)
    @title = title
    @color = color
    @items = items
  end

  def add_item(item, _color)
    items << item
    item.label = self
    _color = color
  end
end
