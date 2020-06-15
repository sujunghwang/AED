<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>AED ����</title>
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    
</head>
<body>
<div id="map" style="width:100%;height:500px;"></div>

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=c01da46b842a4cdd71330ffa97f00afd&libraries=services&libraries=clusterer"></script>
<script>

	var mapContainer = document.getElementById('map'), // ������ ǥ���� div 
	mapOption = { 
	    center: new daum.maps.LatLng(36.2683, 127.6358), // ������ �߽���ǥ
	    level: 13 // ������ Ȯ�� ����
	}; 
	
	var map = new daum.maps.Map(mapContainer, mapOption); // ������ �����մϴ�
	
	// ��Ŀ Ŭ�����ͷ��� �����մϴ� 
	var clusterer = new daum.maps.MarkerClusterer({
	    map: map, // ��Ŀ���� Ŭ�����ͷ� �����ϰ� ǥ���� ���� ��ü 
	    averageCenter: true, // Ŭ�����Ϳ� ���Ե� ��Ŀ���� ��� ��ġ�� Ŭ������ ��Ŀ ��ġ�� ���� 
	    minLevel: 10 // Ŭ������ �� �ּ� ���� ���� 
	});
	
	// �����͸� �������� ���� jQuery�� ����մϴ�
	// �����͸� ������ ��Ŀ�� �����ϰ� Ŭ�����ͷ� ��ü�� �Ѱ��ݴϴ�
	$.get("js/sample.json", function(data) {
	    // �����Ϳ��� ��ǥ ���� ������ ��Ŀ�� ǥ���մϴ�
	    // ��Ŀ Ŭ�����ͷ��� ������ ��Ŀ ��ü�� ������ �� ���� ��ü�� �������� �ʽ��ϴ�
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
	
	    // Ŭ�����ͷ��� ��Ŀ���� �߰��մϴ�
	    clusterer.addMarkers(markers);
	    
	});
	
	// ���������츦 ǥ���ϴ� Ŭ������ ����� �Լ��Դϴ� 
	function makeOverListener(map, marker, infowindow) {
	    infowindow.close();
	    return function() {
	        infowindow.open(map, marker);
	    };
	}
	
	// ���������츦 �ݴ� Ŭ������ ����� �Լ��Դϴ� 
	function makeOutListener(infowindow) {
	    return function() {
	        infowindow.close();
	    };
	}


   
</script>
</body>
</html>