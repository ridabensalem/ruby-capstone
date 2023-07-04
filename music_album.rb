require_relative 'item'

class MusicAlbum < Item
  attr_accessor :name, :publish_date, :on_spotify

  def initialize(name, publish_date, on_spotify)
    super(publish_date, archived: false)
    @name = name
    @on_spotify = on_spotify
  end

  def can_be_archived?
    super && @on_spotify
  end
end
