<%@page import="gboard.GBoardBeen"%>
<%@page import="gboard.GBoardDAO"%>
<%@page import="fboard.fboardBean"%>
<%@page import="fboard.fboardDAO"%>
<%@page import="board.BoardBean"%>
<%@page import="board.BoardDAO"%>
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
<!-- 메인이미지 -->

<!-- 왼쪽메뉴 -->
<nav id="sub_menu">
<ul>
<li><a href="../center/notice.jsp">Notice </a></li>
<li><a href="../fcenter/fnotice.jsp">File Notice</a></li>
<li><a href="../gcenter/gnotice.jsp">Gallery Notice</a></li>
</ul>
</nav>
<!-- 왼쪽메뉴 -->

<!-- 게시판 -->
<article>
<h1>갤러리 게시물 수정</h1>
<form action="gupdatePro.jsp" method="post" enctype="multipart/form-data">
<input type="hidden" name="num" value="<%=num%>">
<table id="notice">

<tr><td>글쓴이</td><td><%=gb.getName() %></td></tr>
<tr><td>비밀번호</td><td><input type="password" name="pass"></td></tr>
<tr><td>제목</td> <td><input type="text" name="subject" value=" <%=gb.getSubject() %>"></td></tr>
<tr><td>파일</td> <td><input type="file" name="file">
  <input type="hidden" name="oldfile" value="<%=gb.getFile() %>"><%=gb.getFile() %></td></tr>
<tr><td>글내용</td>
    <td><textarea name="content" rows="10" cols="20"><%=gb.getContent() %></textarea></td></tr>

</table>
<div id="table_search">
<input type="submit" value="글수정" class="btn">
</div>
</form>


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