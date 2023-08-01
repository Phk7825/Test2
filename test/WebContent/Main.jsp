<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<%
String driver = "oracle.jdbc.driver.OracleDriver";
String url = "jdbc:oracle:thin:@localhost:1521:xe";
String dbId = "hk";
String dbPw = "1234";

Class.forName(driver);   // JDBC 드라이버 로딩.
Connection conn = DriverManager.getConnection(url, dbId, dbPw);
%>
<head>
<meta charset="UTF-8">
<title>메인 페이지</title>
<style>
.middle2 div {
    display: inline-block;
    vertical-align: top; /* 옵션. div 요소의 상단 정렬을 위해 사용됩니다. */
}
.point1, .point2, .point3 {
    width: 150px;
    font-weight:600;
}
.point1{
    margin-left:100px;
}
.point2{
    margin-left:170px;
}
.point3{
    margin-left:230px;
}
</style>
</head>
<script>
	function login() {
		alert("로그아웃되었습니다.");
		window.location.href = "login.jsp";
	}
	function point() {
	    var randomPoint = Math.floor(Math.random() * 1000) + 1; // 1 이상 1000 이하의 정수 생성
	    alert(randomPoint + "점이 적립되었습니다.");
	}
</script>
<body>
	<div class="top" style="display: flex;">
		<h1 style="float: left;">메인 페이지</h1>
		<div class="right"
			style="float: right; margin-top: 30px; margin-left: 640px;">
			<%= session.getAttribute("userName") %>(<%= session.getAttribute("userId") %>)님 안녕하세요.
			<button type="button" onclick="login()">로그아웃</button>
			<br> 포인트:<%= session.getAttribute("userPoint") %>점!!
		</div>
	</div>
	<div class="middle">
		<h3>구입할 컨텐츠를 선택하세요.</h3>
    <img src="Image/Intro_350_408.png" onclick="purchase('intro')"> 
    <img src="Image/Java_350_408.png" onclick="purchase('java')"> 
    <img src="Image/Cpp_350_408.png" onclick="purchase('cpp')">
	</div>
	<script>
	function purchase(content) {
	    var point = <%= session.getAttribute("userPoint") %>; // 현재 사용자의 포인트를 가져옵니다.
	    var price; 
	    
	    if (content === 'intro') {
	        price = 100000;
	    } else if (content === 'java') {
	        price = 500000;
	    } else if (content === 'cpp') {
	        price = 300000;
	    }
	    
	    if (<%= session.getAttribute("userPoint") %> >= price) {
	        alert("컨텐츠(" + content + ")를 구입하였습니다.");
	        point -= price; // 구입한 컨텐츠의 가격만큼 포인트를 차감합니다.
	    } else {
	        alert("포인트 부족!");
	    }
	}
</script>
	<div class="middle2">
		<div class="point1">100000 포인트</div>
		<div class="point2">500000 포인트</div>
		<div class="point3">300000 포인트</div>
	</div>
		<br>
	<div class="footer" style="border:1px solid gray; width:230px; float:right; margin-right:850px;">
	<div class="ad">
	<광고>
	<br>
	 <a href="https://www.koreaisacademy.com" target="_blank" onclick="point()">
	<img src = "Image/korea_it.png">
	</a>
	</div>
	</div>
</body>
</html>