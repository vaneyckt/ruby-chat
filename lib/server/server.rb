require 'socket'

class Server
  def initialize(host, port)
    @host = host
    @port = port

    @sockets = []
    @mutex   = Mutex.new

    @forwarder_queue = Queue.new
  end

  def run
    # start thread that forwards received messages to all sockets
    Thread.new do
      loop do
        msg = @forwarder_queue.pop
        @mutex.synchronize do
          @sockets.each do |socket|
            begin
              socket.puts(msg)
            rescue
            end
          end
        end
      end
    end

    # listen to incoming messages
    Socket.tcp_server_loop(@host, @port) do |socket|
      @mutex.synchronize { @sockets << socket }
      socket.puts('Welcome to the super cool chat server')
      socket.puts('-------------------------------------')

      Thread.new do
        while (msg = socket.gets)
          @forwarder_queue << msg
        end

        # we only get here if the client closed its socket
        @mutex.synchronize { @sockets.delete(socket) }
        socket.close
      end
    end
  end
end
