<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8"/>
	<title>AED ����</title>
</head>
<body>
	<div id="map" style="width:500px;height:400px;"></div>
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=c01da46b842a4cdd71330ffa97f00afd&libraries=services"></script>
	<script>
		var container = document.getElementById('map');
		var options = {
			center: new kakao.maps.LatLng(37.5642135, 127.0016985),
			level: 9
		};

		var map = new kakao.maps.Map(container, options);
		var geocoder = new kakao.maps.services.Geocoder();

		// �ּҷ� ��ǥ�� �˻��մϴ�
		geocoder.addressSearch('����Ư���� ���α� ������ 288���� ������', function(result, status) {

		    // ���������� �˻��� �Ϸ������ 
		     if (status === kakao.maps.services.Status.OK) {

		        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);

		        // ��������� ���� ��ġ�� ��Ŀ�� ǥ���մϴ�
		        var marker = new kakao.maps.Marker({
		            map: map,
		            position: coords
		        });

		        // ����������� ��ҿ� ���� ������ ǥ���մϴ�
		        var infowindow = new kakao.maps.InfoWindow({
		            content: '<div style="width:150px;text-align:center;padding:6px 0;">����Ư���� ���α� ���ϴ�� 428, ������ 4�� (������)</div>'
		        });
		        infowindow.open(map, marker);

		        // ������ �߽��� ��������� ���� ��ġ�� �̵���ŵ�ϴ�
		        map.setCenter(coords);
		    } 
		});    
	</script>
</body>
</html>