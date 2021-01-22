<%@page import="member.MemberBean"%>
<%@page import="member.MemberDAO"%>
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

String id = request.getParameter("id");
String pass = request.getParameter("pass");

MemberDAO mdao = new MemberDAO();
int check = mdao.userCheck(id, pass);

if(check == 1){
	MemberBean mb = new MemberBean();
	
	mb.setId(id);
	mb.setPass(pass);
	session.invalidate();
	mdao.delete(mb);
	%>
	<script type="text/javascript">
	window.opener.location.href = "../main/main.jsp";
	window.close();
	</script>
	<%
} else if(check == 0){
	%>
	<script type="text/javascript">
	out.println("비밀번호 확인해주세요");
	</script><%
}
%>
</body>
</html>