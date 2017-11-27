# ruby-chat
A simple Ruby chat server and client written for educational purposes. There's about a million things that could be improved upon, but it serves as a neat example of using Ruby's socket wrappers, as well as using ncurses for drawing a simple UI in the client's terminal.

## How to use
- download the repo and run `bundle install` to install its dependencies
- in a terminal tab, start the server with `bundle exec ruby lib/run_server.rb`
- in another terminal tab, have a client connect to the server with `bundle exec ruby lib/run_client.rb`
