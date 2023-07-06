require_relative 'genre'
require_relative 'item'
require_relative 'music_album'
require_relative 'book'
require_relative 'label'
require_relative 'game'
require_relative 'author'
require 'json'

class Menu
  attr_accessor :musics, :genres

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
    10 => :on_exit
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
    @games = []
    @authors = []

    load_data
  end

  def handle_options(option)
    if OPTIONS.key?(option)
      selected_option = OPTIONS[option]
      return exit if selected_option == :exit

      send(selected_option)
    else
      puts 'Invalid option. Please try again.'
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
    @musics << MusicAlbum.new(name, publish_date, on_spotify)
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
    puts 'Enter the publish date of the game:'
    publish_date = gets.chomp

    puts 'Is the game archived? (true/false):'
    archived = gets.chomp.downcase == 'true'

    puts 'Is the game multiplayer? (true/false):'
    multiplayer = gets.chomp.downcase == 'true'

    puts 'Enter the last played at date of the game:'
    last_played_at = gets.chomp

    puts 'Enter the author name:'
    author_name = gets.chomp
    first_name, last_name = author_name.split
    author = Author.new(first_name, last_name) # Create a new Author object

    game = Game.new(publish_date, archived, multiplayer, last_played_at, author)
    @games << game
    @authors << author # Add the new author to the authors array

    puts 'Game added successfully!'
  end

  def list_games
    puts 'Listing games...'
    @games.each do |game|
      puts "Publish Date: #{game.publish_date}"
      puts "Archived: #{game.archived}"
      puts "Multiplayer: #{game.multiplayer}"
      puts "Last Played At: #{game.last_played_at}"
      puts
    end
  end

  def list_authors
    puts 'Listing authors...'
    @authors.each do |author|
      puts "ID: #{author.id}, Name: #{author.first_name} #{author.last_name}"
    end
  end

  # Preserve data
  def get_data(file_name)
    if File.exist?("data/#{file_name}.json")
      File.read("data/#{file_name}.json")
    else
      empty_json = [].to_json
      File.write("data/#{file_name}.json", empty_json)
      empty_json
    end
  end

  def load_data
    musics = JSON.parse(get_data('music'))
    genres = JSON.parse(get_data('genres'))
    books = JSON.parse(get_data('books'))
    labels = JSON.parse(get_data('labels'))
    games = JSON.parse(get_data('games'))
    authors = JSON.parse(get_data('authors'))

    musics.each do |music|
      @musics << MusicAlbum.new(music['name'], music['publish_date'], music['on_spotify'])
    end

    genres.each do |genre|
      @genres << Genre.new(genre['name'])
    end

    books.each do |book|
      @books << Book.new(book['publisher'], book['cover_state'])
    end

    labels.each do |label|
      @labels << Label.new(label['title'], label['color'], label['items'])
    end

    games.each do |game|
      @games << Game.new(game['publish_date'], game['archived'], game['multiplayer'], game['last_played_at'],
                         game['author'])
    end

    authors.each do |author|
      @authors << Author.new(author['id'], author['name'])
    end
  end

  def on_exit
    puts 'Goodbye!'

    authors_data = @authors.map do |author|
      { 'id' => author.id, 'first_name' => author.first_name, 'last_name' => author.last_name }
    end

    File.write('data/authors.json', JSON.generate(authors_data))

    update_music = []
    @musics.each do |music|
      update_music << { 'name' => music.name, 'publish_date' => music.publish_date, 'on_spotify' => music.on_spotify }
    end

    File.write('data/music.json', JSON.generate(update_music))

    update_genre = []
    @genres.each do |genre|
      update_genre << { 'name' => genre.name }
    end

    File.write('data/genres.json', JSON.generate(update_genre))

    update_books = []
    @books.each do |book|
      update_books << { 'publisher' => book.publisher, 'cover_state' => book.cover_state }
    end

    File.write('data/books.json', JSON.generate(update_books))

    update_labels = []
    @labels.each do |label|
      update_labels << { 'title' => label.title, 'color' => label.color, 'items' => label.items }
    end

    File.write('data/labels.json', JSON.generate(update_labels))

    update_games = []
    @games.each do |game|
      update_games << { 'publish_date' => game.publish_date, 'archived' => game.archived,
                        'multiplayer' => game.multiplayer, 'last_played_at' => game.last_played_at }
    end

    File.write('data/games.json', JSON.generate(update_games))

    exit
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
      @menu.handle_options(option)
    end
  end
end

Library.new.run
