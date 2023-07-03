class Item
    attr_reader :genre, :author, :source, :label, :publish_date, archieved

    def initialize(publish_date, archieved: true)
        @id = Random.rand(1..1000)
        @publish_date = publish_date
        @archieved = archieved
    end

    def add_genre
        Genre.new()
    end

    def add_author
        Author.new()
    end

    def add_source
        Source.new()
    end

    def add_label
        Label.new()
    end
    def can_be_archived?
        if @publish_date < 10
            return true
        else
            return false
        end
    end

    def move_to_archive
        if can_be_archived? == true
            @archieved = true
        else
            return nil
        end
    end
end