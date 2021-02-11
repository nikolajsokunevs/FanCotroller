import os
import sys
import time

onTemperature=sys.argv[1]
offTemperature=sys.argv[2]
pin=sys.argv[3]

def cpu_temp():
    with open("/sys/class/thermal/thermal_zone0/temp", 'r') as f:
        return float(f.read())/1000


def main():
    cooling_started = False
    while True:
        temp = cpu_temp()
        if cooling_started:
            if temp >  float(offTemperature): 
                os.system("/usr/local/export/rootfs/bin/gpioset --mode=time --sec=60 0 "+str(pin)+"=1")
                cooling_started = True
            else:
                if temp< float(offTemperature): 
                    print(temp, 'Fan OFF')
                    cooling_started = False
        else:
            if temp > float(onTemperature):
                print(temp, 'Fan ON')
                cooling_started = True
            else:
                print(temp)
                time.sleep(1.0)
        time.sleep(0.5)


if __name__ == '__main__':
    main()
