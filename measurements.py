print('running measurements.py')

import os
import datetime
from urllib.parse import urljoin
import time as time_library

# External libraries
# --- begin external libraries
# making HTTP requests
import requests

# import sensor specific library.
from Adafruit_DHT import DHT22, read_retry
# --- end of external libraries.

# load environment variables.
raspberrypi_data_pin = int(os.getenv('DHT22_GPIO_PIN_NUMBER'))
url = urljoin(os.getenv('WEATHER_SERVER_URL'), os.getenv('API_ENDPOINT'))
print(url)

def read_sensor():
  '''
  Returns a tuple of 2 floats:
    humidity in percent e.g. 54.2 stands for 54.2% relative humidity
    temperature in degrees Celsius. e.g. 32.3 stands for 32.3 degrees Celsius
  '''
  hum, temp =  read_retry(DHT22, raspberrypi_data_pin)
  return hum, temp

# if there is no internet connection to the server, we shall store the 
# measurements and send if there is a connection
# initialize an empty list for storage
measurements_list = []


print('before main loop')

while True:
  # make a measurement
  hum, temp = read_sensor()

  # record the current time - use UTC, the webpage can change the timezone.
  time = datetime.datetime.now(datetime.timezone.utc).replace(microsecond=0)
  # store the time as str 
  time = time.isoformat()

  measurement = {
    'time': time,
    'temperature': temp,
    'humidity': hum
  }

  # add this measurement to the list
  measurements_list.append(measurement)

  # try to send the data.
  try:
    # make the actual request
    req = requests.post(url, json=measurements_list, timeout = 2)
    print('Made a request: Statuscode: {}, Text: {}'.format(
      req.status_code, req.text))
    # clean the measurements list
    measurements_list = []
  except Exception as e:
    print(type(e).__name__, e.args)
    print(measurements_list)
    # print('Statuscode: {}'.format(req.status_code))
  
  # start the code INTERVAL_SECONDS later
  time_library.sleep(int(os.getenv('INTERVAL_SECONDS')))
