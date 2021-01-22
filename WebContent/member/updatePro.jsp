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
String name = request.getParameter("name");
String pass = request.getParameter("pass");
String address = request.getParameter("address");
String email = request.getParameter("email");
String mobile = request.getParameter("mobile");
String phone = request.getParameter("phone");
//멤버변수 <- 파라미터 값 저장
	MemberBean mb=new MemberBean();
	mb.setId(id);
	mb.setPass(pass);
	mb.setName(name);
	mb.setAddress(address);
	mb.setEmail(email);
	mb.setMobile(mobile);
	mb.setPhone(phone);


//MemberDAO 객체 생성
MemberDAO mdao = new MemberDAO();
//// int check=userCheck(id,pass) 메서드 생성
int check=mdao.userCheck(id, pass);

if(check == 1){
	mdao.updateMember(mb);
	response.sendRedirect("../main/main.jsp");
} else if(check == 0){
	%><script type="text/javascript">
	 alert("비밀번호 확인해주세요");
	 history.back();
	</script><%
} else {
	%><script type="text/javascript">
	alert("아이디없음");
	history.back();
	</script>
	<%
}%>

</body>
</html>