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
        10 => exit
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

def handle_options(option)
    if OPTIONS.key?(option)
        selected_option = OPTIONS[option]
        return exit if selected_option == :exit

        send(selected_option)
    else
        puts 'Invalid option'
    end
end
end

class Library 
    def initialize
        @menu = Menu.new()
    end

    def run
        puts 'Welcome to App!'
    loop do
      puts @menu.display_options
      option = gets.chomp.to_i
      @menu.handle_options(option)
    end 
    end
end

Library.new.run