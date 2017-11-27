require 'socket'
require_relative 'windows/window_manager.rb'

begin
  socket = TCPSocket.new('localhost', 16451)
  window_manager = WindowManager.new

  # hook that gets called by input_window when enter is pressed
  window_manager.input_window.set_enter_pressed_hook do |msg|
    socket.puts(msg)
  end

  # display messages received from server
  while (msg = socket.gets)
    window_manager.display_window << msg.chomp
  end
ensure
  window_manager.teardown
end
