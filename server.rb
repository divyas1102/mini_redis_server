require 'socket'
require 'thread'
require_relative 'dataset'
require_relative 'sortedset'

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
          client.puts('Server is accepting commands now')
          while(client)
            if command = client.gets
              command_details = command.split(' ')
              response = process_commands(command_details)
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

  def self.process_commands(command_details)
    response = ''
    case command_details[0]
      when "SET" #change_this to use enum
        key = command_details[1] ? command_details[1] : 'Missing key'
        value = command_details[2] ? command_details[2] : 'Missing value'
        mutex = Mutex.new
        mutex.synchronize do
         response = Dataset.set_values(key, value)
        end

      when "GET"
        key = command_details[1] ? command_details[1] : 'Missing key'
        response = Dataset.get_value(key)

      when "DBSIZE"
        response = Dataset.get_dbsize

      when "DEL"
        key = command_details[1] ? command_details[1] : 'Missing key'
        mutex = Mutex.new
        mutex.synchronize do
          response = Dataset.delete
        end

      when "INCR"
        key = command_details[1] ? command_details[1] : 'Missing key'
        response = Dataset.increment(key)

      when "ZADD"
        key = command_details[1] ? command_details[1] : 'Missing key'
        score = command_details[2] ? command_details[2] : 'Missing score'
        member = command_details[3] ? command_details[3] : 'Missing member'
        mutex = Mutex.new
        mutex.synchronize do
          response = Sortedset.add_value(key, score, member)
        end

      when "ZCARD"
        key = command_details[1] ? command_details[1] : 'Missing key'
        response = Sortedset.get_cardinality(key)

      when "ZRANK"
        key = command_details[1] ? command_details[1] : 'Missing key'
        member = command_details[2] ? command_details[2] : 'Missing member'

        response = Sortedset.get_rank(key, member)
      else
        response = "UNKNOWN COMMAND"
    end
    return response
  end
end
#
Server.run
