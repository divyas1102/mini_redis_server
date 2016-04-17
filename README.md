# mini_redis_server
mini redis server to support commands like get, set, dbsize etc.


== README

Goal: A mini redis server that responds to simple commands like Get, Set, DBsize etc.

***Requirements:***
- server running on port 5555
- atomic access to data
- ability to perform operations on data
- ability for multiple connections to read the same data (??does this mean it needs to be persisted?)

***Assumptions:***
- data can be stored in memory (does not need to persisted ie. restarting the app will clear the data)

***Initial_plan:***
- simple rails server
- interface to accept commands
- for easy access to read/write = use of a hashtable since it's 0(1) (best & average case depending on data and hashing algorithm)

####Basic_usage####

#####Starting the server:#####
ruby server.rb (default port used 5555)

#####Connect Client1:#####
telnet localhost 5555

#####Connect Client2:#####
telnet localhost 5555

Commands supported:

GET, SET, INCR, DELETE, DBSIZE

Future enhancements:
- include more commands
- add tests
- clean up command interface
- add more error messages and rescues

Example usage:

telnet localhost 5555
SET 1 "abc"
GET 1
DBSIZE

#####UPDATES: 04/17#####
Goal for next hour:
- identify and implement appropriate data structure for redis-like sorted set storage - done
- implement atleast 2 of the Z commands - done
- fix issue with requiring '\n' for the input - done
- think about handling multithreading and effective concurrent & parallel access to data
 - do we need locks to protect integrity of data?
 - if we use mutex, how will deadlock be handled?

Assumptions:
- score is an integer
- response from zadd is just the number of records/unique keys added
- current implementation only requires ability to zadd one member at a time to one key

Execution:
ruby server.rb - starts the server
telnet localhost 5555 - starts the client connection to server
ZADD "a" 1 "one" => 1 
ZCARD "a" => 1
ZADD "a" 2 "two" => 1 
ZCARD "a" => 2
