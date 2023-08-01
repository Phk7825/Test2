<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%
String driver = "oracle.jdbc.driver.OracleDriver";
String url = "jdbc:oracle:thin:@localhost:1521:xe";
String dbId = "hk";
String dbPw = "1234";
String id = request.getParameter("id"); // 로그인 폼에서 입력한 id 값
String pw = request.getParameter("password"); // 로그인 폼에서 입력한 password 값

if (id != null && pw != null) {
    Class.forName(driver);
    Connection conn = DriverManager.getConnection(url, dbId, dbPw);

    PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM member WHERE id=? AND pw=?");
    pstmt.setString(1, id);
    pstmt.setString(2, pw);

    ResultSet rs = pstmt.executeQuery();
    if (rs.next()) {
        HttpSession session1 = request.getSession();
        session1.setAttribute("userId", rs.getString("id"));
        session1.setAttribute("userName", rs.getString("name"));
        int point = rs.getInt("point");
        session.setAttribute("userPoint", point);
        
        if (id.equals("admin")) {
            response.sendRedirect("admin1.jsp");
        } else {
            response.sendRedirect("Main.jsp");
        }
    }
    else {
        response.sendRedirect("login.jsp?failed=true");
    }
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<style>
label[for="id"] {
    margin-right: 8px;
}
</style>
<script>
    function showAlertIfFailed() {
        const urlParams = new URLSearchParams(window.location.search);
        const failed = urlParams.get('failed');
        
        if (failed === "true") {
            alert("아이디/비밀번호를 다시 확인하세요");
        }
        
    }
</script>
</head>
<body onload="showAlertIfFailed()">
    <h1>로그인</h1>
    <form action="login.jsp">
        <label for="id">id:</label>
        <input type="text" id="id" name="id">
        <br>
        <label for="password">pw:</label>
        <input type="password" id="password" name="password">
        <br>
        <input type="submit" value="로그인" style="width: 210px;">
    </form>
    <form action="Signup.jsp">
        <input type="submit" value="회원가입" style="width: 210px;">
    </form>
</body>
</html>