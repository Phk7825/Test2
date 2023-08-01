<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%
String driver = "oracle.jdbc.driver.OracleDriver";
String url = "jdbc:oracle:thin:@localhost:1521:xe";
String dbId = "hk";
String dbPw = "1234";

String id = request.getParameter("id");

if (id != null && !id.isEmpty()) {
    Class.forName(driver);   // JDBC 드라이버 로딩.
    Connection conn = DriverManager.getConnection(url, dbId, dbPw);

    // member 테이블에서 특정 데이터를 가져오는 SQL 쿼리
    String getSql = "SELECT * FROM member WHERE id=?";
    PreparedStatement pstmt = conn.prepareStatement(getSql);
    pstmt.setString(1, id);
    ResultSet rs = pstmt.executeQuery();

    if (rs.next()) {
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Update Member</title>
</head>
<body>
    <h1>회원 정보 수정</h1>
    <form action="updateProcess.jsp" method="post">
        <input type="hidden" name="id" value="<%= id %>">
        <table>
            <tr>
                <td>ID:</td>
                <td><%= rs.getString("id") %></td>
            </tr>
            <tr>
                <td>PW:</td>
                <td><input type="text" name="pw" value="<%= rs.getString("pw") %>"></td>
            </tr>
            <tr>
                <td>NAME:</td>
                <td><input type="text" name="name" value="<%= rs.getString("name") %>"></td>
            </tr>
            <tr>
                <td>POINT:</td>
                <td><input type="text" name="point" value="<%= rs.getInt("point") %>"></td>
            </tr>
            <tr>
                <td></td>
                <td><input type="submit" value="수정하기"></td>
            </tr>
        </table>
    </form>
</body>
</html>
<%
        rs.close();
        pstmt.close();
    }
    conn.close();
}
%>