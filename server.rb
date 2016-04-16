require 'socket'
require 'thread'
require_relative 'dataset'

class Server

  #define enum for command type
  #command_type {SET, GET, DBSIZE}

  def self.run
    server = TCPServer.open(5555) #make port number customizable
    puts 'Server started on port 5555'
    loop {
      begin
        Thread.start(server.accept) do |client|
          client.puts('Connected at: ' + Time.now.ctime)
          client.puts('Accepting commands now')
          while(client)
            if command = client.gets('\n')
              command_details = command.split(' ')
              command_details.delete('\n')

              case command_details[0] 
                when "SET" #change_this to use enum
                  key = command_details[1] ? command_details[1] : 'Missing key'
                  value = command_details[2] ? command_details[2] : 'Missing value'
                  response = Dataset.set_values(key, value)
                when "GET"
                  key = command_details[1] ? command_details[1] : 'Missing key'
                  response = Dataset.get_value(key)
                when "DBSIZE"
                  response = Dataset.get_dbsize
                when "DEL"
                  key = command_details[1] ? command_details[1] : 'Missing key'
                  response = Dataset.delete
                when "INCR"
                  key = command_details[1] ? command_details[1] : 'Missing key'
                  response = Dataset.increment(key)
                else
                  response = "UNKNOWN COMMAND"
              end
              client.puts response
            end
          end
        end
      rescue => e
        # add logging
        puts 'Error: ' + e.inspect
        client.close unless !client
      end
    }
  end
end
#
Server.run