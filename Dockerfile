# Python Base Image from https://hub.docker.com/r/arm32v7/python/
FROM arm32v7/python:3.9.0rc1-buster

# Copy the Python Script to blink LED
COPY controlFan.py ./

# Intall the rpi.gpio python module
RUN pip install --no-cache-dir rpi.gpio
RUN pip install gpiozero

# Trigger Python script
CMD ["python", "-u", "./controlFan.py"]
