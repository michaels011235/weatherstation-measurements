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

  - Follow headless setup: https://www.raspberrypi.org/documentation/configuration/wireless/headless.md CAVE: The boot folder in the tutorial is the `boot` mount point. It is NOT the `boot` folder in the `rootfs` directory.

  - connect the power supply. The Pi will boot. 

  - Find the IP Address of the Raspberry Pi:

    - Open internet router webpage (something like `10.0.0.xxx`) in the browser. Get the IP address of the Raspberry Pi. 
  
    - Use `nmap`

      - run `ifconfig` and get the own IP address (this is the one your router assigns you, not the one one could Google).
      - install `nmap`: `sudo apt install nmap`. 
      - run the following command: `sudo nmap -sn 10.0.0.0`. The IP address at the and has to be: Replace the last number of your IP address with `0`. The output tells you the Raspberry Pi IP adress.

  - SSH into it. Make you have `ssh` installed. Then: `ssh pi@10.0.0.xxx`, where the ip address has to be the Raspberry Pi's address. 

  - You will be prompted a password. By default it is: `raspberry`.

  - Change the default password: `sudo raspi-config`.

  - Done.

## Installation.

- `git clone` this repository.

- change to the directory containing this `README.md` file.

- copy `.env.example` to `.env` and adapt the variables as neccessary.

- 