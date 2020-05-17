import urllib.request as ul
import xmltodict
import json
import sys
import io

url = "http://apis.data.go.kr/B552657/AEDInfoInqireService/getAedFullDown?serviceKey=od4tYuNxQ5HvGbEBsN2kqk0zqXlfms1zAs47tLMg%2B85HwhUETJDGOzeGYzoZp5Hz%2F1jVetfc6MikfHmaUKlVqw%3D%3D&pageNo=1&numOfRows=100"

 
request = ul.Request(url)

response = ul.urlopen(request)

rescode = response.getcode()

if(rescode == 200):
    responseData = response.read()
    
    rD = xmltodict.parse(responseData)
    

    rDJ = json.dumps(rD)
    

    rDD = json.loads(rDJ)
    
    
    
    data = rDD['response']['body']['items']['item']


    for i in data :
    	json_txt = i['wgs84Lat']
    	print(json_txt)

    for i in data :
    	json_txt = i['wgs84Lon']
    	print(json_txt)