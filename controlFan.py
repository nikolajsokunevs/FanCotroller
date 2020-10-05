#!/usr/bin/python
import sys
import time
from gpiozero import LED # doc: https://gpiozero.readthedocs.io/

# define the GPIO to control the transistor's B pin
fan = LED(17)

def cpu_temp():
    with open("/sys/class/thermal/thermal_zone0/temp", 'r') as f:
        return float(f.read())/1000


def main():
    # close fan at begining
    is_close = True
    fan.off()
    while True:
        temp = cpu_temp()
        if is_close:
            if temp > 65.0: # upper bound to turn on the fan
                print(temp, 'Fan ON')
                fan.on()
                is_close = False
        else:
            if temp < 45.0: # lower bound to turn off the fan
                print(temp, 'Fan OFF')
                fan.off()
                is_close = True

        time.sleep(2.0)
        print(temp)


if __name__ == '__main__':
    main()
