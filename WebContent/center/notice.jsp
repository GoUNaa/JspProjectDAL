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
BoardDAO bdao = new BoardDAO();
int count = bdao.getBoardCount();

int pageSize=10;
String pageNum = request.getParameter("pageNum");
if(pageNum == null){
	pageNum="1";
}
//시작하는 행번호 구하기
int currentPage=Integer.parseInt(pageNum);

int startRow = (currentPage - 1) * pageSize + 1 ;
// ? startRow -1 ? pageSize
		




SimpleDateFormat sdf = new SimpleDateFormat("yy.MM.dd");
%>

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
<li><a href="../center/notice.jsp">Notice</a></li>
<li><a href="../fcenter/fnotice.jsp">File Notice</a></li>
<li><a href="../gcenter/gnotice.jsp">Gallery Notice</a></li>
</ul>
</nav>
<!-- 왼쪽메뉴 -->

<!-- 게시판 -->
<article>
<h1>Notice</h1>
<%
String id = (String)session.getAttribute("id");
if(id != null){
    %><div id="table_search">
 <input type="button" value="글쓰기" class="btn" onclick="location.href='writeForm.jsp'">
 </div><%
	  
  }
%>
<table id="notice">
<tr>
 <td class = tableNum>번호</td>
      <td class = tableTitle>제목</td>
      <td class = tableUserName>작성자</td>
      <td class = tableReadCount>조회수</td>
      <td class = tableRegDate>작성일</td>
  </tr>
  <%
 
  List boardList = bdao.getBoardList1(startRow,pageSize);
for(int i = 0; i < boardList.size(); i++){
	BoardBean bb=(BoardBean)boardList.get(i);
	
	%>
<tr>
<td><%=bb.getNum()%></td> <td><a href="content.jsp?num=<%=bb.getNum()%>"><%
if(bb.getRe_lev() > 0){
	int wid = bb.getRe_lev() * 10;
	%>  
	<img src="../images/level.gif" width="<%=wid %>" height="15" />
	<img src="../images/re.gif" /><%
}
%><%=bb.getSubject() %></a></td>
<td><%=bb.getName()%></td><td><%=bb.getReadcount()%></td>
<td><%=sdf.format(bb.getDate()) %></td>
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
	%><a href="notice.jsp?pageNum<%=startPage-pageBlock%>">[이전]</a><%
}
for(int i = startPage; i <= endPage; i++){
	%><a href="notice.jsp?pageNum=<%=i%>"><%=i %> </a> <%
}

if(endPage < pageCount){
     %><a href="notice.jsp?pageNum=<%=startPage+pageBlock%>">[다음]</a><%
}
%>

</div>
<div id="table_search">
<form action="noticeSearch.jsp" method="post">
<input type="text" name="search" class="input_box"><br>
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