<%@page import="java.text.SimpleDateFormat"%>
<%@page import="member.MemberBean"%>
<%@page import="java.util.List"%>
<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
</head>
<body>


<div id="wrap">
<!-- 헤더들어가는 곳 -->
<jsp:include page="../inc/top.jsp"/>
<!-- 헤더들어가는 곳 -->

<!-- 본문들어가는 곳 -->
<!-- 메인이미지 -->
<div id="sub_img_center"></div>
<!-- 메인이미지 -->

<!-- 왼쪽메뉴 -->
<!-- 왼쪽메뉴 -->



<%
MemberDAO mdao = new MemberDAO();
List memberList = mdao.getMemberList();
SimpleDateFormat sdf = new SimpleDateFormat("yy.MM.dd");
%>

<article>
<h1>회원목록</h1>
<table id="notice">
<tr><td class="tableNum"><b>Name</b></td>
    <td class="tableTitle"><b>Id</b></td>
    <td class="tableUserName"><b>Pass</b></td>
    <td class="tableReadCount"><b>Date</b></td>
    <td class="tableRegDate"><b>Email</b></td>
    <td class="tableRegDate"><b>Address</b></td></tr>

<%
for(int i = 0; i < memberList.size(); i++){
	MemberBean mb = (MemberBean)memberList.get(i);

%>
<tr>
<td><%=mb.getName() %></td> <td><%=mb.getId()%></td> <td><%=mb.getPass()%></td>
<td><%=sdf.format(mb.getDate()) %></td><td><%=mb.getEmail() %></td> 
<td><%=mb.getAddress() %><%=mb.getRoadAddress() %><%=mb.getJibunAddress() %><%=mb.getDetailAddress() %></td>
</tr>
<%
   }
%> 
 
 
 
 
 
 </table>
<div class="clear"></div>
<div id="page_control">

</div>
</article>
<!-- 게시판 -->
<!-- 본문들어가는 곳 -->
<div class="clear"></div>
<!-- 푸터들어가는 곳 -->
<jsp:include page="../inc/bottom.jsp"/>
<!-- 푸터들어가는 곳 -->
</div>
</body>
</html>