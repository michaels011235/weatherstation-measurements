#!/bin/bash

# echo "-----------" >> /home/pi/weatherstation-measurements/script_log.txt
# echo "-----------" >> /home/pi/weatherstation-measurements/script_log.txt
# echo "-----------" >> /home/pi/weatherstation-measurements/script_log.txt
# echo "-----------" >> /home/pi/weatherstation-measurements/script_log.txt
# pwd >> /home/pi/weatherstation-measurements/script_log.txt
# date >> /home/pi/weatherstation-measurements/script_log.txt
# echo "-----------" >> /home/pi/weatherstation-measurements/script_log.txt

# change the working directory to the one containing this script. 
script="$0"
DIRPATH="$(dirname $script)"
cd $DIRPATH

# # add a marker to the script_log.txt file 
# date >> script_log.txt
# echo "weather.sh script started" >> script_log.txt
# echo "\n"  >> script_log.txt 

# echo "-----------" >> /home/pi/weatherstation-measurements/script_log.txt
# pwd >> /home/pi/weatherstation-measurements/script_log.txt
# date >> /home/pi/weatherstation-measurements/script_log.txt
# echo "-----------" >> /home/pi/weatherstation-measurements/script_log.txt

# # test python script
# python3 -c "print('hello from Python')" >> script_log.txt

# # add a marker to the script_log.txt file 
# date >> script_log.txt
# echo "python minimal text executed" >> script_log.txt
# echo "\n"  >> script_log.txt 



# load the environment variables
source .env



# # python3 -c "import os; print('this is Python. Trying to use the environment variables:'); print(os.getenv('API_ENDPOINT'))" >> script_log.txt
# python3 -c "import os; print('this is Python. Trying to use the environment variables:'); print(os.getenv('API_ENDPOINT'))" 2>&1 | tee -a script_log.txt

# # add a marker to the script_log.txt file 
# date >> script_log.txt
# echo "after source .env" >> script_log.txt
# echo "\n"  >> script_log.txt 


python3 -u measurements.py 
# the `-u` stands for "unbuffered" -> the output is immediatley sent to stdout.. 

# python3 -u measurements.py 2>&1 | tee -a script_log.txt # works :)
# python3 measurements.py >> script_log.txt # works :)

# # add a marker to the script_log.txt file 
# date >> script_log.txt
# echo "after measurements.py" >> script_log.txt
# echo "\n"  >> script_log.txt 

