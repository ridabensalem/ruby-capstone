class Item
    attr_reader :genre, :author, :source, :label, :publish_date, :archived
  
    def initialize(publish_date, archived: true)
      @id = Random.rand(1..1000)
      @publish_date = publish_date
      @archived = archived
    end
  
    def add_genre
      Genre.new
    end
  
    def add_author
      Author.new
    end
  
    def add_source
      Source.new
    end
  
    def add_label
      Label.new
    end
  
    def can_be_archived?
      @publish_date < 10
    end
  
    def move_to_archive
      @archived = true if can_be_archived?
    end
  end