require 'ncurses'

class InputWindow
  def initialize(x:, y:, width:, height:)
    @border = create_border(x, y, width, height)
    @area   = create_area(x + 1, y + 1, width - 2, height - 2)

    @enter_pressed_hook = nil
    start_keypress_loop
  end

  def set_enter_pressed_hook(&block)
    @enter_pressed_hook = block
  end

  private

  def create_border(x, y, width, height)
    border = Ncurses::WINDOW.new(height, width, y, x)
    border.border(0, 0, 0, 0, 0, 0, 0, 0)
    border
  end

  def create_area(x, y, width, height)
    area = Ncurses::WINDOW.new(height, width, y, x)
    area.keypad(true)
    area.intrflush(false)
    Ncurses.scrollok(area, true)
    Ncurses.idlok(area, true)
    area
  end

  def refresh_window
    @border.noutrefresh
    @area.noutrefresh
    Ncurses.doupdate
  end

  def start_keypress_loop
    Thread.new do
      @input = '>> '

      loop do
        @area.clear
        @area.move(1, 1)
        @area.printw(@input)

        refresh_window

        case ch = @area.getch
        when Ncurses::KEY_LEFT
        when Ncurses::KEY_RIGHT
        when Ncurses::KEY_UP
        when Ncurses::KEY_DOWN
        when Ncurses::KEY_BACKSPACE, 127
          @input.chop!
        when Ncurses::KEY_ENTER, "\n".ord, "\r".ord
          @enter_pressed_hook.call(@input) unless @enter_pressed_hook.nil?
          @input = '>> '
        else
          @input << ch.chr
        end
      end
    end
  end
end
