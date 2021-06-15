# weatherstation-measurements

This project about making temperature and humidity measurements using the Adafruit DHT22 sensor on a Raspberry Pi. After making a measurement, the data shall be sent to a server via HTTP requests.

## Prerequisites

- Raspberry Pi (just tested with Model 3)

- Arduino DHT22 sensor

- power supply for the Raspberry Pi: micro USB. This can be a power bank too.

- micro SD card for the Raspberry Pi. >= 4 GB should be enough.

- SD card adapter for PC.

- wireless LAN

## Raspberry Pi setup.

- Connect DHT22 sensor with Raspberry Pi GPIO (general-purpose in/output) pins
  - Pin layout: https://www.raspberrypi.org/documentation/usage/gpio/
  - make the following connections:
    - DHT22 sensor '+' pin with a 5 volt pin of the Raspberry Pi. (I used the top left pin.)
    - DHT22 sensor 'out' pin with a GPIO pin. (I used pin 2.)
    - DHT22 sensor '-' with a ground pin. (I used the 3rd pin in the top row.)


- Download and install Raspbian image.
  - Good introduction: https://projects.raspberrypi.org/en/projects/raspberry-pi-setting-up
  - Download Raspbian image. Raspbian is the operating system of choice. https://www.raspberrypi.org/downloads/raspbian/  I used Raspbian Buster Lite ~ 400 MB Download.

  - For Linux: Follow this guide to install the image: https://www.raspberrypi.org/documentation/installation/installing-images/linux.md After unzipping I used `sudo cp raspbian-image.img /dev/mmcblk0`

  - Follow headless setup: https://www.raspberrypi.org/documentation/configuration/wireless/headless.md CAVE: The boot folder in the tutorial is the `boot` partition of the SD-card. It is NOT the `boot` folder in the `rootfs` directory. 

    I added a file named `wpa_supplicant.conf` to the boot partition whose contents are:

    ```
    ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev
    update_config=1
    country=AT

    network={
    ssid="<NameOfWifiNetwork>"
    psk="<password>"
    priority=2
    }

    network={
    ssid="<NameOfWifiNetworkNumber2>"
    psk="<passwordofNetworkNumber2>"
    priority=1
    }
    ```
    As indicated several networks are possible.
    The network given the priority 2 is preferred.

  - To enable SSH on a headless Raspberry Pi add a file named `ssh` to the boot partition. The content does not matter. This file activates SSH.

  - Insert the SD-card into the Raspberry Pi. Connect the power supply. The Pi will boot. 

  - For the following step, make sure, your PC is connected to the same network router as the Raspberry Pi.

  - For remote control SSH into the Raspberry Pi. Make sure you have `ssh` installed. Then use `ssh pi@raspberrypi.local`. This works, due to the Raspberry Pi's built-in support for Multicast DNS (mDNS). -- It's like magic and is way faster than finding the Raspberry Pi's IP-address!

  - You will be prompted a password. By default it is: `raspberry`.

  - Change the default password: `sudo raspi-config`.

  - install `pip3` for Python package loading: `sudo apt-get install python3-pip`.


## Installation and basic execution.

- `git clone` this repository.

- change to the directory containing this `README.md` file.

- copy `.env.example` to `.env` and adapt the variables as neccessary.

- `source .env` - This will load the variables defined in `.env` to the environment.

- `pip3 install Adafruit_DHT requests` to install the required external libraries. 

- `python3 <PATHTOFILE>/measurements.py` to run the program.

## Automatic execution after plugging in the Raspberry Pi.

- `chmod 777 weather.sh`

- Crontab let's you automatically execute programs. Run `crontab -e` and add the line `@reboot /home/pi/weatherstation-measurements/weather.sh` at the end. 

  Beware not to use `sudo crontab -e`. It took me a **day** to realize that the owner of the process would be *root* who does not have access to the libaries installed by `pip3 install Adafruit_DHT requests`. If you want to use the *root* user, you have to run `sudo pip3 install Adafruit_DHT requests` in preparation.

- Now, upon connecting the Raspberry Pi to a power supply it should connect automatically to the internet (if the network is accessible) and execute `measurements.py`. That means, it should measure the temperature and humidity periodically and send it to the server.