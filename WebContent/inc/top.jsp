<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<header>
<%
 String id = (String)session.getAttribute("id");
if(id == null){
	
%> <div id="login"><a href="../member/login.jsp">로그인</a> | <a href="../member/join.jsp">회원가입</a></div> <%
} 
	else if(id.equals("admin")) { %>
<div id="login"><%=session.getAttribute("id") %><a href="../member/login.jsp"></a> | 
<a href="../member/logout.jsp">로그아웃</a> | <a href="../member/updateForm.jsp">회원정보수정</a> | <a href="../member/memberList.jsp">회원목록</a></div>

<%
} else {
	%><div id="login"><%=session.getAttribute("id") %> | <a href="../member/logout.jsp">로그아웃</a> | <a href="../member/updateForm.jsp">회원정보수정</a></div> <%
}

%>








<div class="clear"></div>
<!-- 로고들어가는 곳 -->
<div id="logo"><a href="../main/main.jsp"><img src="../images/loggo1.png" width="265" height="62" alt="Fun Web"></a></div>
<!-- 로고들어가는 곳 -->
<nav id="top_menu">
<ul>
	<li><a href="../main/main.jsp">HOME</a></li>
	<li><a href="../company/welcome.jsp">COMPANY</a></li>
	<li><a href="#">SOLUTIONS</a></li>
	<li><a href="../center/notice.jsp">CUSTOMER CENTER</a></li>
	<li><a href="#">CONTACT US</a></li>
</ul>
</nav>
</header>