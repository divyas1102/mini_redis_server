
system("telnet localhost 5555")
if $?.exitstatus == 0
  puts("SET a 1")
else
  puts("failed to connect to server")
end