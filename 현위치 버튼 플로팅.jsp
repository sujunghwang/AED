<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" charset="UTF-8, width=device-width, initial-scale=1.0">
    <title>AED 지도</title>
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <style>
    	html, body {height:100%; margin:0;}
    	.map_wrap {position:relative;overflow:hidden;width:100%;height:100%;}
    	button {
    		width:10%;
    		position:absolute;
    		overflow:hidden;
    		right:2%;
    		bottom:2%;
    		z-index:1;
    		float:left;
    	}
    	button:after {
    		content: "";
    		display: block;
    		padding-bottom: 100%;
    		overflow:hidden;
    		float:left;
    		z-index:1;
    		position:fixed;
    	}
    	button span {display:block; float:left; cursor:pointer;}
    	img {width:100%; height:100%; padding:0;}
    </style>
</head>
<body>

<div class="map_wrap">
    <div id="map" style="width:100%;height:100%;position:relative;overflow:hidden;"></div> 
    <button onclick="CurLoc()"><img src="img/mark.png" alt=""></button> 
</div>

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=c01da46b842a4cdd71330ffa97f00afd&libraries=services&libraries=clusterer"></script>
<script>

	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	mapOption = { 
	    center: new daum.maps.LatLng(36.2683, 127.6358), // 지도의 중심좌표
	    level: 4 // 지도의 확대 레벨
	}; 
	
	var map = new daum.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
	
	// 마커 클러스터러를 생성합니다 
	var clusterer = new daum.maps.MarkerClusterer({
	    map: map, // 마커들을 클러스터로 관리하고 표시할 지도 객체 
	    averageCenter: true, // 클러스터에 포함된 마커들의 평균 위치를 클러스터 마커 위치로 설정 
	    minLevel: 5 // 클러스터 할 최소 지도 레벨 
	});
	
	// 데이터를 가져오기 위해 jQuery를 사용합니다
	// 데이터를 가져와 마커를 생성하고 클러스터러 객체에 넘겨줍니다
	$.get("js/test.json", function(data) {
	    // 데이터에서 좌표 값을 가지고 마커를 표시합니다
	    // 마커 클러스터러로 관리할 마커 객체는 생성할 때 지도 객체를 설정하지 않습니다
	   	    var markers = $(data.positions).map(function(i, position) {
	        var marks = new daum.maps.Marker({
	            map: map,
	            position : new daum.maps.LatLng(position.lat, position.lon)
	        });
	        
	        var infowindow = new daum.maps.InfoWindow({
	            content: '<div style="margin:5px; padding-right:20px;">'+position.address+'</div>',
	            removable : true
	        });
	
	        daum.maps.event.addListener(marks, 'click', makeOverListener(map, marks, infowindow));
	
	        return marks;
	
	    });    
	   	
	    
	    clusterer.addMarkers(markers); // 클러스터러에 마커들을 추가합니다
	    
	    var disarr = new Array(); //현위치와 AED간의 거리를 저장할 배열입니다.
	    var disobj = new Object();
	    	    
	    $(data.positions).each(function(key, add){
	    	
			 navigator.geolocation.getCurrentPosition(function(position) {
				 
				 var mylat = position.coords.latitude, // 위도
				 mylon = position.coords.longitude; // 경도
				 			 
				 var linePath = [
					    new daum.maps.LatLng(add.lat, add.lon), 
					    new daum.maps.LatLng(mylat, mylon)
					];
				 
				 var polyline = new daum.maps.Polyline({
					 path: linePath, // 선을 구성하는 좌표배열 입니다
					 strokeWeight: 5, // 선의 두께 입니다
					 strokeColor: '#FFAE00', // 선의 색깔입니다
					 strokeOpacity: 0.7, // 선의 불투명도 입니다 1에서 0 사이의 값이며 0에 가까울수록 투명합니다
					 strokeStyle: 'solid' // 선의 스타일입니다
					 
				 });
				 
				 polyline.setMap(map);
				 
				 var distance = polyline.getLength();
				 
				 disobj.address = add.address;
				 disobj.distance = distance;					 
				 disarr.unshift(disobj);
				 console.log(disobj);
				 console.log(add.address);
				 console.log(disarr);
				 return distance;
				 
			 });
			 
			 
			 
		 });
	    
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
	 navigator.geolocation.getCurrentPosition(function(position) {
	        
	        var mylat = position.coords.latitude, // 위도
	            mylon = position.coords.longitude; // 경도

	        var moveLatLon = new kakao.maps.LatLng(mylat, mylon);
	   
	        var circle = new kakao.maps.Circle({
		        center : new kakao.maps.LatLng(mylat, mylon),  // 원의 중심좌표 입니다 
		        radius: 300, // 미터 단위의 원의 반지름입니다 
		        strokeWeight: 5, // 선의 두께입니다 
		        strokeColor: '#FE2EF7', // 선의 색깔입니다
		        strokeOpacity: 1, // 선의 불투명도 입니다 1에서 0 사이의 값이며 0에 가까울수록 투명합니다
		        strokeStyle: 'solid', // 선의 스타일 입니다
		        fillColor: '#F781F3', // 채우기 색깔입니다
		        fillOpacity: 0.7  // 채우기 불투명도 입니다   
		    }); 
	        
	        var circle2 = new kakao.maps.Circle({
	        	center : new kakao.maps.LatLng(mylat, mylon),  
		        radius: 150, 
		        strokeWeight: 5, 
		        strokeColor: '#FE2E2E',
		        strokeOpacity: 1, 
		        strokeStyle: 'solid', 
		        fillColor: '#FA5858',
		        fillOpacity: 0.7   
		    }); 
	            
	        circle.setMap(map);
	        circle2.setMap(map);
	        
	        map.setCenter(moveLatLon);
	        
	 });
	        
	 function CurLoc(){
		 navigator.geolocation.getCurrentPosition(function(position) {
			 var mylat = position.coords.latitude, // 위도
			 mylon = position.coords.longitude; // 경도
			 
			 var moveLatLon = new kakao.maps.LatLng(mylat, mylon);
			 
			 map.setLevel(4); //지도의 레벨을 4로 변경
			 map.panTo(moveLatLon); //지도 중심 좌표를 현재 위치로 이동 
		 });	
	}
	 

	 

   
</script>
</body>
</html>


