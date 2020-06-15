<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>마커 클러스터러 사용하기</title>
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    
</head>
<body>
<div id="map" style="width:100%;height:500px;"></div>

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=c01da46b842a4cdd71330ffa97f00afd&libraries=services&libraries=clusterer"></script>
<script>
    var map = new kakao.maps.Map(document.getElementById('map'), { // 지도를 표시할 div
        center : new kakao.maps.LatLng(36.2683, 127.6358), // 지도의 중심좌표 
        level : 14 // 지도의 확대 레벨 
    });
    
    // 마커 클러스터러를 생성합니다 
    var clusterer = new kakao.maps.MarkerClusterer({
        map: map, // 마커들을 클러스터로 관리하고 표시할 지도 객체 
        averageCenter: true, // 클러스터에 포함된 마커들의 평균 위치를 클러스터 마커 위치로 설정 
        minLevel: 7 // 클러스터 할 최소 지도 레벨 
    });
    
    var marker = new kakao.maps.Marker({
    	map: map,
    	position: position,
    	clickable: true // 마커를 클릭했을 때 지도의 클릭 이벤트가 발생하지 않도록 설정합니다
    });

    	// 아래 코드는 위의 마커를 생성하는 코드에서 clickable: true 와 같이
    	// 마커를 클릭했을 때 지도의 클릭 이벤트가 발생하지 않도록 설정합니다
    	// marker.setClickable(true);

    	// 마커를 지도에 표시합니다.
    	
    $.get("js/AED data.json", function(data) {
        // 데이터에서 좌표 값을 가지고 마커를 표시합니다
        // 마커 클러스터러로 관리할 마커 객체는 생성할 때 지도 객체를 설정하지 않습니다
        var markers = $(data.positions).map(function(i, position) {
            return new kakao.maps.Marker({
                position : new kakao.maps.LatLng(position.lat, position.lon)
            });
        var infowindow = new daum.maps.InfoWindow({
        	content: position.address,
        	removable : true
        });
        
        daum.maps.event.addListener(maks, 'click', makeOverListener(map, markers, infowindow));
      

        // 클러스터러에 마커들을 추가합니다
        clusterer.addMarkers(markers);
               
        marker.setMap(markers);

    	// 인포윈도우를 생성합니다
    	var infowindow = new kakao.maps.InfoWindow({
    	    content : iwContent,
    	    removable : iwRemoveable
    	});

    	// 마커에 클릭이벤트를 등록합니다
    	kakao.maps.event.addListener(marker, 'click', function() {
    	      // 마커 위에 인포윈도우를 표시합니다
    	      infowindow.open(map, marker);  
    	});
    });
</script>
</body>
</html>