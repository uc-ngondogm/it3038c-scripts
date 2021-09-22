import socket, sys

#print(sys.argv[0])

def getHostnameByIP(h): 
  try:
    #hostname = str(sys.argv[1])
    hostname = str(h) 
    ip = socket.gethostbyname(hostname) 
    print (hostname +' has an IP of ' + ip) 
  except:
    print("Oops, something is wrong with that host")

getHostnameByIP(sys.argv[1])

# run python myGetIP.py www.uc.edu
