# stopwatch.py - simple stopwatch program

import time

# instruction
print("Press enter to start and Ctrl-C to Stop")

input()
print("Start")
startTime = time.time()
endTime = startTime
lapNumber = 1
print(" Press enter to start new Lap and Ctrl-C to Stop")
try:
    while True:
        input()
        lapTime = round(time.time() - endTime, 2) # current time - last time (single lap time)
        totalTime =round(time.time() - startTime, 2) # current time - starting time
        endTime = time.time()
        print(f"lapTime =  {lapTime},Lap Number =  {lapNumber},total time = {totalTime}",end =" ")
        lapNumber += 1
except KeyboardInterrupt:
    print("\n Stopped ")
    time.sleep(5)

