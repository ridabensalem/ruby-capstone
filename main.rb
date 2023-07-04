require_relative 'genre'
require_relative 'item'
require_relative 'music_album'
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

  def initialize
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

  def add_book
    # Implement the logic to add a book
    puts 'Adding a book...'
  end

  def list_books
    # Implement the logic to list books
    puts 'Listing books...'
  end

  def list_labels
    # Implement the logic to list labels
    puts 'Listing labels...'
  end

  def add_music
    # Implement the logic to add music
    puts 'Enter published date:'
    publish_date = gets.chomp
    puts 'Is it on sportify[Yes/No]:'
    on_spotify = gets.chomp.downcase
    @musics << MusicAlbum.new(publish_date, on_spotify)
    puts 'Enter genre(Rock, Pop etc):'
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
      puts "Published date: #{music.publish_date}, Sportify: #{music.on_spotify}"
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
