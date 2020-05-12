<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8"/>
	<title>Kakao 지도 시작하기</title>
</head>
<body>
	<div id="map" style="width:500px;height:400px;"></div>
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=c01da46b842a4cdd71330ffa97f00afd"></script>
	<script>
		var container = document.getElementById('map');
		var options = {
			center: new kakao.maps.LatLng(37.5642135, 127.0016985),
			level: 9
		};

		var map = new kakao.maps.Map(container, options);
	</script>
</body>
</html>