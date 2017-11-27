require 'ncurses'

class DisplayWindow
  def initialize(x:, y:, width:, height:)
    @border = create_border(x, y, width, height)
    @area   = create_area(x + 1, y + 1, width - 2, height - 2)
    refresh_window
  end

  def <<(str)
    @area.printw("#{str}\n")
    refresh_window
  end

  private

  def create_border(x, y, width, height)
    border = Ncurses::WINDOW.new(height, width, y, x)
    border.border(0, 0, 0, 0, 0, 0, 0, 0)
    border
  end

  def create_area(x, y, width, height)
    area = Ncurses::WINDOW.new(height, width, y, x)
    Ncurses.scrollok(area, true)
    Ncurses.idlok(area, true)
    area
  end

  def refresh_window
    @border.noutrefresh
    @area.noutrefresh
    Ncurses.doupdate
  end
end
