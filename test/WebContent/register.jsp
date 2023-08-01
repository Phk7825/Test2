<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
label[for="id"] {
    margin-right: 26px;
}
label[for="password"] {
    margin-right: 18px;
}
</style>
<script>
function submitForm() {
    alert("가입되었습니다. 로그인 해주세요.");
    window.location.href = "login.jsp";
}
</script>
</head>
<body>
    <h1>회원가입</h1>
    <form>
        <label for="id">id:</label>
        <input type="text" id="id" name="id">
        <br>
        <label for="password">pw:</label>
        <input type="password" id="password" name="password">
        <br>
        <label for="name">name:</label>
        <input type="text" id="name" name="name">
        <br>
    </form>
    <button type="button" onclick="submitForm()" style="width: 226px;">작성완료</button>
</body>
</html>