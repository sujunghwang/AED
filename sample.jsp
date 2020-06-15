<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>AED 지도</title>
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    
</head>
<body>
<div id="map" style="width:100%;height:500px;"></div>

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=c01da46b842a4cdd71330ffa97f00afd&libraries=services&libraries=clusterer"></script>
<script>

	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	mapOption = { 
	    center: new daum.maps.LatLng(36.2683, 127.6358), // 지도의 중심좌표
	    level: 13 // 지도의 확대 레벨
	}; 
	
	var map = new daum.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
	
	// 마커 클러스터러를 생성합니다 
	var clusterer = new daum.maps.MarkerClusterer({
	    map: map, // 마커들을 클러스터로 관리하고 표시할 지도 객체 
	    averageCenter: true, // 클러스터에 포함된 마커들의 평균 위치를 클러스터 마커 위치로 설정 
	    minLevel: 10 // 클러스터 할 최소 지도 레벨 
	});
	
	// 데이터를 가져오기 위해 jQuery를 사용합니다
	// 데이터를 가져와 마커를 생성하고 클러스터러 객체에 넘겨줍니다
	$.get("js/sample.json", function(data) {
	    // 데이터에서 좌표 값을 가지고 마커를 표시합니다
	    // 마커 클러스터러로 관리할 마커 객체는 생성할 때 지도 객체를 설정하지 않습니다
	    var markers = $(data.positions).map(function(i, position) {
	        var maks = new daum.maps.Marker({
	            map: map,
	            position : new daum.maps.LatLng(position.lat, position.lon)
	        });
	        
	        var infowindow = new daum.maps.InfoWindow({
	            content: position.address,
	            removable : true
	        });
	
	        daum.maps.event.addListener(maks, 'click', makeOverListener(map, maks, infowindow));
	
	        return maks;
	
	    });
	
	    // 클러스터러에 마커들을 추가합니다
	    clusterer.addMarkers(markers);
	    
	});
	
	// 인포윈도우를 표시하는 클로저를 만드는 함수입니다 
	function makeOverListener(map, marker, infowindow) {
	    infowindow.close();
	    return function() {
	        infowindow.open(map, marker);
	    };
	}
	
	// 인포윈도우를 닫는 클로저를 만드는 함수입니다 
	function makeOutListener(infowindow) {
	    return function() {
	        infowindow.close();
	    };
	}


   
</script>
</body>
</html>