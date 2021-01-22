<%@page import="member.MemberDAO"%>
<%@page import="member.MemberBean"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="org.apache.tomcat.util.http.fileupload.UploadContext"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
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
String id = (String)session.getAttribute("id");

int num = Integer.parseInt(request.getParameter("num"));
String name = request.getParameter("name");
// String uploadPath=request.getRealPath("/upload");
// System.out.println(uploadPath);
// int maxSize = 10 * 1024 * 1024;
// MultipartRequest multi = new MultipartRequest(request,uploadPath,maxSize,"utf-8",new DefaultFileRenamePolicy());

BoardDAO bdao = new BoardDAO();
BoardBean bb = bdao.getBoard(num);



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
<li><a href="../fcenter/fnotice.jsp">Driver Download</a></li>
<li><a href="../gcenter/gnotice.jsp">Gallery Notice</a></li>
</ul>
</nav>
<article>
<h1>Content</h1>
<form action="writePro.jsp" method="post">
<table id="notice">

<tr><td>글번호</td><td><%=bb.getNum()%></td> <td>글쓴날짜</td><td><%=bb.getDate() %></td></tr>
<tr><td>작성자</td><td><%=bb.getName()%></td><td>조회수</td><td><%=bb.getReadcount()%></td></tr>
<tr><td>제목</td><td colspan="3"><%=bb.getSubject() %></td></tr>
<%-- <tr><td>파일</td><td colspan="3"><a href="../upload/<%=bb.getFile() %>"><%=bb.getFile() %></a><img src="../upload/<%=bb.getFile() %>" width="50" height="50"></td></tr> --%>
<tr><td>내용</td><td colspan="3"><%=bb.getContent() %></td></tr>

<div id="table_search">
<%
if(id != null){
if(bb.getName().equals(id) ){
%><input type="button" value="글수정" onclick="location.href='updateForm.jsp?num=<%=bb.getNum()%>'">
<input type="button" value="글삭제" onclick="location.href='deleteForm.jsp?num=<%=bb.getNum()%>'">
<%	
} 
%>
<input type="button" value="답글쓰기" onclick="location.href='reWriteForm.jsp?num=<%=bb.getNum()%>&re_ref=<%=bb.getRe_ref()%>&re_lev=<%=bb.getRe_lev()%>&re_seq=<%=bb.getRe_seq()%>'">
<%
}

%>
<%

%>

<input type="button" value="글목록" onclick="location.href='notice.jsp'">
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