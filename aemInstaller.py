import subprocess
import signal
import os
import sys
import psutil
#
# Waits for connection on 5007, and then checks that the returned
# success message has been recieved.
#
#

# Starts AEM installer
installProcess = subprocess.Popen(['java', '-jar', 'cq-author-4502.jar', '-listener-port','50007','-r','nosample'])

# Starting listener
import socket
HOST = ''                 # Symbolic name meaning all available interfaces
PORT = 50007              # Arbitrary non-privileged port
s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
s.bind((HOST, PORT))
s.listen(1)
conn, addr = s.accept()

successfulStart = False
while 1:
    data = conn.recv(1024)
    if not data:
      break
    else:
      print str(data)
      if str(data).strip() == 'started':
        successfulStart = True
      break
    # conn.sendall(data)
conn.close()

#
# If the success message was recieved, attempt to close all associated
# processes.
#
if successfulStart == True:
  parentAEMprocess= psutil.Process(installProcess.pid)
  for childProcess in parentAEMprocess.get_children():
    os.kill(childProcess.pid,signal.SIGINT)

  os.kill(parentAEMprocess.pid, signal.SIGINT)

  installProcess.wait()
  sys.exit(0)
else:
  installProcess.kill()
  sys.exit(1)
