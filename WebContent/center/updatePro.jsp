<%@page import="board.BoardDAO"%>
<%@page import="board.BoardBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
request.setCharacterEncoding("utf-8");
int num=Integer.parseInt(request.getParameter("num"));
String name = request.getParameter("name");	//작성자
String pass = request.getParameter("pass");	//패스워드
String subject = request.getParameter("subject"); //제목
String content = request.getParameter("content"); //글내용

BoardBean bb = new BoardBean();
bb.setNum(num);
bb.setName(name);
bb.setPass(pass);
bb.setSubject(subject);
bb.setContent(content);
BoardDAO bdao = new BoardDAO();
int check = bdao.numcheck(bb);

if(check == 1){
	bdao.updateBoard(bb);
	response.sendRedirect("notice.jsp");
} else if(check == 0){
	%>
	<script type="text/javascript">
		alert("비밀번호 틀림");
		history.back(); // 뒤로이동 
	</script>
	<%
} else {
	%>
	<script type="text/javascript">
			alert("아이디 없음");
			history.back(); // 뒤로이동 
	</script>
	<%
}

%>











</body>
</html>