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

//BoardDAO bdao = new BoardDAO();
fboardDAO fbdao = new fboardDAO();
//BoardBean bb = bdao.getBoard(num);
fboardBean fb = fbdao.getFBoard(num);


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
<h1>파일 게시물 삭제</h1>
<form action="fdeletePro.jsp" method="post">
<input type="hidden" name="num" value="<%=num%>">
<table id="notice">

<tr><td>글번호</td><td><%=fb.getNum()%></td> <td>글쓴날짜</td><td><%=fb.getDate() %></td></tr>
<tr><td>작성자</td><td><%=fb.getName()%></td><td>조회수</td><td><%=fb.getReadcount()%></td></tr>
<tr><td>제목</td><td colspan="3"><%=fb.getSubject() %></td></tr>
<tr><td>내용</td><td colspan="3"><%=fb.getContent() %></td></tr>
<tr><td>비밀번호</td><td colspan="3"><input type="password" name="pass"></td></tr>



<div id="table_search">
<input type="submit" value="삭제">
<%-- <input type="button" value="글수정" onclick="location.href='updateForm.jsp?num=<%=bb.getNum()%>'"> --%>
<%-- <input type="button" value="글삭제" onclick="location.href='deleteForm.jsp?num=<%=bb.getNum()%>'"> --%>
<!-- <input type="button" value="글목록" onclick="location.href='notice.jsp'"> -->
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