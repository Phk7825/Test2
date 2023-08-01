<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%
String driver = "oracle.jdbc.driver.OracleDriver";
String url = "jdbc:oracle:thin:@localhost:1521:xe";
String dbId = "hk";
String dbPw = "1234";

String id = request.getParameter("id");
String pw = request.getParameter("pw");
String name = request.getParameter("name");
String point = request.getParameter("point");

if (id != null && !id.isEmpty()) {
    Class.forName(driver);   // JDBC 드라이버 로딩.
    Connection conn = DriverManager.getConnection(url, dbId, dbPw);

    // member 테이블에서 특정 데이터를 수정하는 SQL 쿼리
    String updateSql = "UPDATE member SET pw=?, name=?, point=? WHERE id=?";
    PreparedStatement pstmt = conn.prepareStatement(updateSql);
    pstmt.setString(1, pw);
    pstmt.setString(2, name);
    pstmt.setInt(3, Integer.parseInt(point));
    pstmt.setString(4, id);
    int updated = pstmt.executeUpdate();

    if(updated > 0){
      out.print("<script>");
      out.print("alert(\"성공적으로 수정되었습니다.\");");
      out.print("location.href=\"admin1.jsp\";");
      out.print("</script>");
    } else {
      out.print("<script>");
      out.print("alert(\"회원 정보 수정 실패\");");
      out.print("location.href=\"admin1.jsp\";");
      out.print("</script>");
    }

    pstmt.close();
    conn.close();
}
%>