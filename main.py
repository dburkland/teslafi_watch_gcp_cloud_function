#!/usr/bin/env python3
# importing the requests library 
import json,requests

def request_handler(request):
  request_args = request.args
  if request_args and 'TOKEN' in request_args:
    ########################################### Variables #####################################################
    BASE_URL = "https://www.teslafi.com/feed.php?command=lastGood&token="
    TOKEN = request_args['TOKEN']
    HEADERS = {
      'Content-Type': 'application/json'
    }
    URL = BASE_URL + TOKEN
    RESPONSE = requests.get(url = URL, headers=HEADERS)
    VEHICLE_INFO = json.loads(RESPONSE.text)
    BATTERY_LEVEL = VEHICLE_INFO["battery_level"]
    BATTERY_CHARGE_LIMIT = VEHICLE_INFO["charge_limit_soc"]
    OUTPUT = BATTERY_LEVEL + " / " + BATTERY_CHARGE_LIMIT + " %"
    ###########################################################################################################
    
    return (OUTPUT)
  else:
    return ("An error has occured", 400)