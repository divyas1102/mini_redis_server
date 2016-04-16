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
- FIX \n issue with retrieving values

Example usage:

telnet localhost 5555
SET 1 "abc" \n
GET 1 \n
DBSIZE \n