require 'date'

class Item
  attr_reader :publish_date, :archived
  attr_accessor :genre, :author, :source, :label

  def initialize(publish_date, archived)
    @id = Random.rand(1..1000)
    @publish_date = publish_date
    @archived = archived
  end

  def add_genre(name)
    Genre.new(name)
  end

  def add_source
    Source.new
  end

  def add_label
    Label.new
  end

  def can_be_archived?
    publish_date = Date.parse(@publish_date)
    current_date = Date.today
    years_difference = current_date.year - publish_date.year

    years_difference >= 10
  end

  def move_to_archive
    @archived = true if can_be_archived?
  end
end
