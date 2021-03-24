Z<%@page import="gboard.GBoardBeen"%>
<%@page import="gboard.GBoardDAO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
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
<Style type="text/css">
#did {text-align : center; font-size:12px;}
</Style>
<%
request.setCharacterEncoding("utf-8");
GBoardDAO gbdao = new GBoardDAO();
int count = gbdao.getgBoardCount();

int pageSize=12;
String pageNum = request.getParameter("pageNum");
if(pageNum == null){
	pageNum="1";
}
//시작하는 행번호 구하기
int currentPage=Integer.parseInt(pageNum);

int startRow = (currentPage - 1) * pageSize + 1 ;
		



List gboardList = gbdao.getgBoardList1(startRow, pageSize);
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
<li><a href="../center/notice.jsp">Notice </a></li>
<li><a href="../fcenter/fnotice.jsp">File Notice</a></li>
<li><a href="../gcenter/gnotice.jsp">Gallery Notice</a></li>
</ul>
</nav>
<!-- 왼쪽메뉴 -->

<!-- 게시판 -->
<article>
<h1>Gallery Notice</h1>
<%
String id = (String)session.getAttribute("id");

if(id != null){
	%><div id="table_search">
<input type="button" value="글쓰기" class="btn" onclick="location.href='gwriteForm.jsp'">
</div><%
}
%>  
<table >
<tr><td style="border-bottom:2px solid #DBDBDB" colspan="4"></td></tr>
<%
int newLine = 0;
int articleCount=0;
int cnt = 0;
for(int i = 0; i < gboardList.size(); i++) {
	GBoardBeen gb = (GBoardBeen)gboardList.get(i);	
 if(newLine == 0){
	 out.print("<tr>");
 }
 newLine++;
 articleCount++;
%>
	<td>
 	<input type="hidden" value="<%=gb.getNum()%>" name="num" >
 	<a href="gcontent.jsp?num=<%=gb.getNum() %>" ><img src="../gupload/<%=gb.getFile() %>"  width = "150" height="150"><br></a>
 	<Div id="did"><%=gb.getName()%><Br><a href="gcontent.jsp?num=<%=gb.getNum() %>" ><%=gb.getSubject() %></a><Br>
  <%=sdf.format(gb.getDate()) %></div>
 	
	<Br>
 	</td>
 	
<%
if(newLine == 4){
	out.print("</tr>");
	newLine = 0;
}
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
	%><a href="gnotice.jsp?pageNum<%=startPage-pageBlock%>">[이전]</a><%
}
for(int i = startPage; i <= endPage; i++){
	%><a href="gnotice.jsp?pageNum=<%=i%>"><%=i %> </a> <%
}

if(endPage < pageCount){
     %><a href="gnotice.jsp?pageNum=<%=startPage+pageBlock%>">[다음]</a><%
}
%>
</div>
<div id="table_search">
<form action="gnoticeSearch.jsp" method="post">
<input type="text" name="search" class="input_box"><br>
<input type="submit" value="search" class="btn" >
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