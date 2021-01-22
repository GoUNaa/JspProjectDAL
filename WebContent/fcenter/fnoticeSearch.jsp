<%@page import="fboard.fboardBean"%>
<%@page import="fboard.fboardDAO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@page import="board.BoardDAO"%>
<%@page import="board.BoardBean"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
<%
request.setCharacterEncoding("utf-8");
// BoardDAO bdao = new BoardDAO();
// ResultSet rs = bdao.list();
String search = request.getParameter("search");
fboardDAO fbdao = new fboardDAO();
int count = fbdao.getFBoardCount(search);

int pageSize=10;
String pageNum = request.getParameter("pageNum");
if(pageNum == null){
	pageNum="1";
}
//시작하는 행번호 구하기
int currentPage=Integer.parseInt(pageNum);

int startRow = (currentPage - 1) * pageSize + 1 ;
// ? startRow -1 ? pageSize
		



// List boardList = fboardDAO.getFBoardList1(startRow,pageSize);
List fboardList = fbdao.getFBoardList1(startRow, pageSize, search);
SimpleDateFormat sdf = new SimpleDateFormat("yy.MM.dd");
%>
<!--[if lt IE 9]>
<script src="http://ie7-js.googlecode.com/svn/version/2.1(beta4)/IE9.js" type="text/javascript"></script>
<script src="http://ie7-js.googlecode.com/svn/version/2.1(beta4)/ie7-squish.js" type="text/javascript"></script>
<script src="http://html5shim.googlecode.com/svn/trunk/html5.js" type="text/javascript"></script>
<![endif]-->
<!--[if IE 6]>
 <script src="../script/DD_belatedPNG_0.0.8a.js"></script>
 <script>
   /* EXAMPLE */
   DD_belatedPNG.fix('#wrap');
   DD_belatedPNG.fix('#main_img');   

 </script>
 <![endif]-->
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
<nav id="sub_menu">
<ul>
<li><a href="../center/notice.jsp">Notice </a></li>
<li><a href="#">Public News</a></li>
<li><a href="../fcenter/fnotice.jsp">File Notice</a></li>
<li><a href="../gcenter/gnotice.jsp">Gallery Notice</a></li>
</ul>
</nav>
<!-- 왼쪽메뉴 -->

<!-- 게시판 -->
<article>
<h1>File Notice</h1>
<table id="notice">
<tr>
 <td class = tableNum>번호</td>
      <td class = tableTitle>제목</td>
      <td class = tableUserName>작성자</td>
      <td class = tableReadCount>조회수</td>
      <td class = tableRegDate>작성일</td>
    
  </tr>
<%
String id = (String)session.getAttribute("id");

if(id != null){
	%><div id="table_search">
<input type="button" value="글쓰기" class="btn" onclick="location.href='fwriteForm.jsp'">
</div><%
}
%>  


<%
for(int i = 0; i < fboardList.size(); i++){
	fboardBean fb = (fboardBean)fboardList.get(i);

%>
<tr>
<td><%=fb.getNum()%></td> <td><a href="fcontent.jsp?num=<%=fb.getNum()%>"><%=fb.getSubject() %> 
	<img src="../fupload/<%=fb.getFile()%>" width="150" height="150"></a></td>

<td><%=fb.getName()%></td><td><%=fb.getReadcount()%></td>
<td><%=sdf.format(fb.getDate()) %></td>
</tr>
<%
   }
%>

</table>
<%
int pageBlock = 10;
int startPage=(currentPage-1)/pageBlock*pageBlock+1;
int endPage = startPage+pageBlock-1;
int pageCount = count/pageSize + (count%pageSize == 0 ? 0:1);

if(endPage > pageCount){
	endPage = pageCount;
}
%>
<div id="a">

<%
if(startPage > pageBlock){
	%><a href="fnotice.jsp?pageNum<%=startPage-pageBlock%>&searcu=<%=search%>">[이전]</a><%
}
for(int i = startPage; i <= endPage; i++){
	%><a href="fnotice.jsp?pageNum=<%=i%>"><%=i %> </a> <%
}

if(endPage < pageCount){
     %><a href="fnotice.jsp?pageNum=<%=startPage+pageBlock%>&search=<%=search%>">[다음]</a><%
}
%>
</div>
<div id="table_search">
<form action="fnoticeSearch.jsp" method="post">
<input type="text" name="search" class="input_box" value="<%=search %>"><br>
<input type="submit" value="search" class="btn">
</form>
</div>


<div class="clear"></div>
<div id="page_control">
전체 글 - <%=count%>
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