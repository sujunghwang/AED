<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*, javax.sql.*, java.io.*, java.net.*"%>
<%@ page
	import="javax.xml.parsers.* ,org.w3c.dom.*, javax.xml.xpath.*, org.xml.sax.InputSource"%>
<html>
<head>
</head>
<body>
	<h1 align=center>xml 파싱</h1>
	<%
		//파싱을 위한 준비과정
		DocumentBuilder docBuilder = DocumentBuilderFactory.newInstance().newDocumentBuilder();
		out.println("<table cellspacing=1 width=700 border=1 align=center>");
		out.println("<tr>");
		out.println("<th width=50>순번</th>");
		out.println("<th width=450>주소</th>");
		out.println("<th width=100>위도</th>");
		out.println("<th width=100>경도</th>");
		out.println("</tr>");

		for (int x = 1; x <= 214; x++) {

			String url = "http://apis.data.go.kr/B552657/AEDInfoInqireService/getAedFullDown?serviceKey=od4tYuNxQ5HvGbEBsN2kqk0zqXlfms1zAs47tLMg%2B85HwhUETJDGOzeGYzoZp5Hz%2F1jVetfc6MikfHmaUKlVqw%3D%3D&pageNo="
					+ x + "&numOfRows=100";

			//xml정규화
			DocumentBuilderFactory f = DocumentBuilderFactory.newInstance();
			DocumentBuilder b = f.newDocumentBuilder();
			//위에서 구성한 URL을 통해 XMl 파싱 시작
			Document doc = b.parse(url);
			doc.getDocumentElement().normalize();

			XPath xpath = XPathFactory.newInstance().newXPath();


			NodeList tag_local = doc.getElementsByTagName("buildPlace");
			NodeList tag_local_address = doc.getElementsByTagName("buildAddress");
			NodeList tag_local_org = doc.getElementsByTagName("org");
			NodeList tag_lat = doc.getElementsByTagName("wgs84Lat");
			NodeList tag_lng = doc.getElementsByTagName("wgs84Lon");

			//테이블 형태로 데이터 출력

			for (int i = 0; i < tag_local.getLength(); i++) {
				out.println("<tr>");
				out.println("<td align=center>" + ((x-1)*100 + (i+1)) + "</td>");

				if (tag_local.item(i).getNodeType() != Node.ELEMENT_NODE) {
					continue;
				}

				//아래 내용은 도로명 주소가 없을 경우 지번주소 컬럼값을 읽어오도록 한 것 입니다.
				try {
					out.println("<td>" + tag_local_org.item(i).getFirstChild().getTextContent() + " " + tag_local.item(i).getFirstChild().getTextContent() + "</td>");
				} catch (Exception e) {
					out.println("<td>" + tag_local_address.item(i).getFirstChild().getTextContent() + "</td>");
				}
				out.println("<td align=center>" + tag_lat.item(i).getFirstChild().getTextContent() + "</td>");
				out.println("<td align=center>" + tag_lng.item(i).getFirstChild().getTextContent() + "</td>");
				out.println("</tr>");
			}
		}
		out.println("</table>");
	%>
</body>
</html>
