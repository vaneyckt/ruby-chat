require_relative 'server/server.rb'

server = Server.new('0.0.0.0', 16451)
server.run
