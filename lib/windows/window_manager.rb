require 'ncurses'
require_relative 'display_window.rb'
require_relative 'input_window.rb'

class WindowManager
  INPUT_WINDOW_HEIGHT = 3

  attr_reader :input_window
  attr_reader :display_window

  def initialize
    setup_ncurses
    create_windows
  end

  def teardown
    Ncurses.nocbreak
    Ncurses.echo
    Ncurses.nl
    Ncurses.endwin
  end

  private

  def setup_ncurses
    Ncurses.initscr
    Ncurses.cbreak
    Ncurses.noecho
    Ncurses.nonl
    Ncurses.curs_set(0)
  end

  def create_windows
    @display_window = DisplayWindow.new(
      x: 0, y: 0, width: Ncurses.COLS, height: Ncurses.LINES - INPUT_WINDOW_HEIGHT)

    @input_window = InputWindow.new(
      x: 0, y: Ncurses.LINES - INPUT_WINDOW_HEIGHT, width: Ncurses.COLS, height: INPUT_WINDOW_HEIGHT)
  end
end
