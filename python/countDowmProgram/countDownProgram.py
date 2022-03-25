import time
import os
import subprocess
"""
This program starts count down from 60 seconds and then when it is 0 then it will play alarm
"""
x = 60  # number of seconds
while x > 0:
    print(f"\t\t\t{x}")    # display seconds
    time.sleep(1)
    x -= 1
    os.system("cls")
subprocess.Popen(["start", "alarm.wav"], shell=True)    # plays sound
