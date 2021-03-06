<%@page import="gboard.GBoardBeen"%>
<%@page import="gboard.GBoardDAO"%>
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
<% 
request.setCharacterEncoding("utf-8");

int num = Integer.parseInt(request.getParameter("num"));

GBoardDAO gbdao = new GBoardDAO();
GBoardBeen gb = gbdao.getgBoard(num);


%>
<div id="wrap">
<!-- 헤더들어가는 곳 -->
<jsp:include page="../inc/top.jsp"/>
<!-- 헤더들어가는 곳 -->

<!-- 본문들어가는 곳 -->
<!-- 메인이미지 -->
<div id="sub_img_center"></div>
<!-- 왼쪽메뉴 -->
<nav id="sub_menu">
<ul>
<li><a href="../center/notice.jsp">Notice </a></li>
<li><a href="../fcenter/fnotice.jsp">File Notice</a></li>
<li><a href="../gcenter/gnotice.jsp">Gallery Notice</a></li>
</ul>
</nav>
<article>
<h1>갤러리 게시물 삭제</h1>
<form action="gdeletePro.jsp" method="post">
<input type="hidden" name="num" value="<%=num%>">
<table id="notice">

<tr><td>글번호</td><td><%=gb.getNum()%></td> <td>글쓴날짜</td><td><%=gb.getDate() %></td></tr>
<tr><td>작성자</td><td><%=gb.getName()%></td><td>조회수</td><td><%=gb.getReadcount()%></td></tr>
<tr><td>제목</td><td colspan="3"><%=gb.getSubject() %></td></tr>
<tr><td>내용</td><td colspan="3"> <br>
	<img src="../gupload/<%=gb.getFile() %>" width="100" height="100"><Br><%=gb.getContent() %></td></tr>
<tr><td>비밀번호</td><td colspan="3"><input type="password" name="pass"></td></tr>



<div id="table_search">
<input type="submit" value="삭제">
</div>

</table>
</form>
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
</body>
</html>