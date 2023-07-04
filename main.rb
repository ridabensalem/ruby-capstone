require_relative 'genre'
require_relative 'item'
require_relative 'music_album'
require_relative 'book'
require_relative 'label'
class Menu
  OPTIONS = {
    1 => :add_book,
    2 => :list_books,
    3 => :list_labels,
    4 => :add_music,
    5 => :list_genre,
    6 => :list_music,
    7 => :add_game,
    8 => :list_games,
    9 => :list_authors,
    10 => :exit
  }.freeze

  def display_options
    <<~OPTIONS
      1 - Add a book
      2 - List books
      3 - List labels
      4 - Add music
      5 - List genre
      6 - List music
      7 - Add game
      8 - List game
      9 - List authors
      10 - Exit
    OPTIONS
  end

  # initialize the arrays
  def initialize
    @books = []
    @labels = []
    @musics = []
    @genres = []
  end

  def handle_options(option)
    if OPTIONS.key?(option)
      selected_option = OPTIONS[option]
      return exit if selected_option == :exit

      send(selected_option)
    else
      puts 'Invalid option'
    end
  end

  def add_music
    # Implement the logic to add music
    puts 'Enter Album name: '
    name = gets.chomp
    puts 'Enter published date:'
    publish_date = gets.chomp
    puts 'Is it on sportify[Yes/No]:'
    on_spotify = gets.chomp.downcase
     @musics <<  MusicAlbum.new(name, publish_date, on_spotify)
    puts 'Enter music genre(Rock, Pop etc):'
    genre = gets.chomp
    @genres << Genre.new(genre)

    puts 'Music added succesfully'
  end

  def list_genre
    # Implement the logic to list genres
    puts 'Listing genres...'
    @genres.each do |genre|
      puts "Genre: #{genre.name}"
    end
  end

  def list_music
    # Implement the logic to list music
    puts 'Listing music...'
    @musics.each do |music|
      puts "Name: #{music.name}, Published date: #{music.publish_date}, On sportify: #{music.on_spotify}"
    end
  end

  def add_book
    puts 'Enter the publisher:'
    publisher = gets.chomp

    puts 'Enter the cover state (good/bad):'
    cover_state = gets.chomp.downcase
    book = Book.new(publisher, cover_state)
    puts 'Enter the labels (separated by commas):'
    labels = gets.chomp.split(';').map(&:strip)

    labels.each do |label_info|
      if label_info.include?(',')
        title, color = label_info.split(',').map(&:strip)
      else
        title = label_info.strip
        color = nil
      end
      label = find_or_create_label(title, color)
      label.add_item(book, color)
    end
    @books << book

    puts 'Book added successfully!'
  end

  def find_or_create_label(title, color)
    label = @labels.find { |l| l.title == title && l.color == color }
    return label if label

    label = Label.new(title, color, [])
    @labels << label
    label
  end

  def list_books
    puts 'Listing books...'
    @books.each do |book|
      puts "Publisher: #{book.publisher}, Cover State: #{book.cover_state}"
    end
  end

  def list_labels
    puts 'Listing labels...'
    @labels.each do |label|
      puts "Title: #{label.title}, Color: #{label.color}"
    end
  end

  def add_game
    # Implement the logic to add a game
    puts 'Adding a game...'
  end

  def list_games
    # Implement the logic to list games
    puts 'Listing games...'
  end

  def list_authors
    # Implement the logic to list authors
    puts 'Listing authors...'
  end
end

class Library
  def initialize
    @menu = Menu.new
  end

  def run
    puts 'Welcome to the App!'
    loop do
      puts @menu.display_options
      option = gets.chomp.to_i

      if option == 10
        puts 'Goodbye!'
        break
      end

      @menu.handle_options(option)
    end
  end
end

Library.new.run
