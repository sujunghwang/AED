<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>��Ŀ Ŭ�����ͷ� ����ϱ�</title>
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    
</head>
<body>
<div id="map" style="width:100%;height:500px;"></div>

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=c01da46b842a4cdd71330ffa97f00afd&libraries=services&libraries=clusterer"></script>
<script>
    var map = new kakao.maps.Map(document.getElementById('map'), { // ������ ǥ���� div
        center : new kakao.maps.LatLng(36.2683, 127.6358), // ������ �߽���ǥ 
        level : 14 // ������ Ȯ�� ���� 
    });
    
    // ��Ŀ Ŭ�����ͷ��� �����մϴ� 
    var clusterer = new kakao.maps.MarkerClusterer({
        map: map, // ��Ŀ���� Ŭ�����ͷ� �����ϰ� ǥ���� ���� ��ü 
        averageCenter: true, // Ŭ�����Ϳ� ���Ե� ��Ŀ���� ��� ��ġ�� Ŭ������ ��Ŀ ��ġ�� ���� 
        minLevel: 7 // Ŭ������ �� �ּ� ���� ���� 
    });
    
    var marker = new kakao.maps.Marker({
    	map: map,
    	position: position,
    	clickable: true // ��Ŀ�� Ŭ������ �� ������ Ŭ�� �̺�Ʈ�� �߻����� �ʵ��� �����մϴ�
    });

    	// �Ʒ� �ڵ�� ���� ��Ŀ�� �����ϴ� �ڵ忡�� clickable: true �� ����
    	// ��Ŀ�� Ŭ������ �� ������ Ŭ�� �̺�Ʈ�� �߻����� �ʵ��� �����մϴ�
    	// marker.setClickable(true);

    	// ��Ŀ�� ������ ǥ���մϴ�.
    	
    $.get("js/AED data.json", function(data) {
        // �����Ϳ��� ��ǥ ���� ������ ��Ŀ�� ǥ���մϴ�
        // ��Ŀ Ŭ�����ͷ��� ������ ��Ŀ ��ü�� ������ �� ���� ��ü�� �������� �ʽ��ϴ�
        var markers = $(data.positions).map(function(i, position) {
            return new kakao.maps.Marker({
                position : new kakao.maps.LatLng(position.lat, position.lon)
            });
        var infowindow = new daum.maps.InfoWindow({
        	content: position.address,
        	removable : true
        });
        
        daum.maps.event.addListener(maks, 'click', makeOverListener(map, markers, infowindow));
      

        // Ŭ�����ͷ��� ��Ŀ���� �߰��մϴ�
        clusterer.addMarkers(markers);
               
        marker.setMap(markers);

    	// ���������츦 �����մϴ�
    	var infowindow = new kakao.maps.InfoWindow({
    	    content : iwContent,
    	    removable : iwRemoveable
    	});

    	// ��Ŀ�� Ŭ���̺�Ʈ�� ����մϴ�
    	kakao.maps.event.addListener(marker, 'click', function() {
    	      // ��Ŀ ���� ���������츦 ǥ���մϴ�
    	      infowindow.open(map, marker);  
    	});
    });
</script>
</body>
</html>