import urllib.request as ul
import xmltodict
import json
import sys
import io



for x in range(1,203) :
	url = "http://apis.data.go.kr/B552657/AEDInfoInqireService/getAedFullDown?serviceKey=od4tYuNxQ5HvGbEBsN2kqk0zqXlfms1zAs47tLMg%2B85HwhUETJDGOzeGYzoZp5Hz%2F1jVetfc6MikfHmaUKlVqw%3D%3D&pageNo="+str(x)+"&numOfRows=100"


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
			json_lat = i['wgs84Lat']
			json_lon = i['wgs84Lon']
			print("{\"lat\" : " + json_lat + ",")
			print("\"lon\" : " + json_lon + "},")