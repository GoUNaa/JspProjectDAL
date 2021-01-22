<%@page import="member.MemberDAO"%>
<%@page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<script type="text/javascript">
	function idok(){
		//join.jsp id상자 value <= dupCheck.jsp 찾은 아이디
	window.opener.fr.id.value = document.wfr.wid.value;
	
	window.close();
	
	}
</script>
<%
// "dupCheck.jsp?wid="+wid
// wid 파라미터 가져오기
String wid = request.getParameter("wid");

//MemberDAO 객체생성
MemberDAO mdao = new MemberDAO();

//int check = dupCheck(wid);
// check == 1  "아이디중복"
// check == 0  "아이디 사용 가능"
int check = mdao.dupCheck(wid);
if(check == 1){
	out.println("아이디 중복");
} else{
  	out.println("사용 가능한 아이디");
	%><input type="button" value="아이디 사용" onclick="idok()">
 <%
}
%>


<form action="dupCheck.jsp" method="post" name="wfr">
아이디 : <input type="text" name="wid" value="<%=wid %>">
<input type="submit" value="아이디 중복체크">
</form>
</body>
</html>