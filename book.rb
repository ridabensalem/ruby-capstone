require_relative 'item'

class Book < Item
  attr_accessor :publisher, :cover_state

  def initialize(publisher, cover_state)
    super(publish_date, archived: false)
    @publisher = publisher
    @cover_state = cover_state
  end

  def can_be_archived?()
    return true if super == true || @cover_state == 'bad'

    false
  end

  attr_writer :label, :color
end
