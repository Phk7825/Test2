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

    // member 테이블에서 특정 데이터를 삭제하는 SQL 쿼리
    String sql = "DELETE FROM member WHERE id=?";
    PreparedStatement pstmt = conn.prepareStatement(sql);
    pstmt.setString(1, id);
    int deleted = pstmt.executeUpdate();

    if(deleted > 0){
      out.print("<script>");
      out.print("alert(\"성공적으로 삭제되었습니다.\");");
      out.print("location.href=\"admin1.jsp\";");
      out.print("</script>");
    } else {
      out.print("<script>");
      out.print("alert(\"삭제 실패\");");
      out.print("location.href=\"admin1.jsp\";");
      out.print("</script>");
    }

    pstmt.close();
    conn.close();
}
%>
