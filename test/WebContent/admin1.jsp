<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%
String driver = "oracle.jdbc.driver.OracleDriver";
String url = "jdbc:oracle:thin:@localhost:1521:xe";
String dbId = "hk";
String dbPw = "1234";

Class.forName(driver);   // JDBC 드라이버 로딩.
Connection conn = DriverManager.getConnection(url, dbId, dbPw);

// member 테이블의 전체 데이터를 조회하는 SQL 쿼리
String sql = "SELECT * FROM member";
PreparedStatement pstmt = conn.prepareStatement(sql);
ResultSet rs = pstmt.executeQuery();
%>
<style>
    table {
        border-collapse: collapse;  /* 한 줄의 경계선으로 만듦. */
    }
    th,td {
        border: 1px solid grey;
        padding: 8px;
    }
    .header-container {
        display: flex;
        align-items: center;
        justify-content: space-between;
    }
</style>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Member List</title>
        <script>
        function login() {
            window.location.href = "login.jsp";
        }
        function change(itemId) {
        	 window.location.href = "update.jsp?id=" + itemId;
        }
        function deleteItem(itemId) {
            if (confirm("정말로 삭제하시겠습니까?")) {
                // 서버와 통신하지 않기 때문에 페이지 새로고침이 필요
                location.href = "deleteInPage.jsp?id=" + itemId;
            }
        }
        </script>
    </head>
    <body>
        <div class="header-container">
        <h1>회원 관리</h1>
        <button type="button" onclick="login()" style="margin-right:1300px;">로그인</button>
        </div>
        <table border="1">
            <thead>
                <tr>
                    <th>id</th>
                    <th>pw</th>
                    <th>name</th>
                    <th>point</th>
                    <th>수정</th>
                    <th>삭제</th>
                </tr>
            </thead>
            <tbody>
                <% while (rs.next()) { 
                	   String itemId = rs.getString("id");
                %>
                <tr>
                    <td><%= rs.getString("id") %></td>
                    <td><%= rs.getString("pw") %></td>
                    <td><%= rs.getString("name") %></td>
                    <td><%= rs.getInt("point") %></td>
                    <td><button onclick="change('<%=itemId%>')">수정</button></td>
                    <td><button onclick="deleteItem('<%=itemId%>')">삭제</button></td>
                </tr>
                <% } %>
            </tbody>
        </table>
        <h1>스케줄러관리</h1>
        <button>스케줄러(20초마다 포인트1 증가)실행  시작</button>
        <button>스케줄러 실행 종료</button>
    </body>
</html>

<%
rs.close();
pstmt.close();
conn.close();
%>