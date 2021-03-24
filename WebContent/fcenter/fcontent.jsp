<%@page import="fboard.fboardBean"%>
<%@page import="fboard.fboardDAO"%>
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
String id = (String)session.getAttribute("id");

request.setCharacterEncoding("utf-8");
int num = Integer.parseInt(request.getParameter("num"));
fboardDAO fbdao = new fboardDAO();
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
<h1>File Content</h1>
<form action="fwritePro.jsp" method="post">
<table id="notice">

<tr><td>글번호</td><td><%=fb.getNum()%></td> <td>글쓴날짜</td><td><%=fb.getDate() %></td></tr>
<tr><td>작성자</td><td><%=fb.getName()%></td><td>조회수</td><td><%=fb.getReadcount()%></td></tr>
<tr><td>제목</td><td colspan="3"><%=fb.getSubject() %></td></tr>
<tr><td>파일</td><td colspan="3"><a href="../fupload/<%=fb.getFile() %>">
								<img src="../fupload/<%=fb.getFile() %>" width="100" height="100"></a><%=fb.getFile() %></td></tr>
<tr><td>내용</td><td colspan="3"><%=fb.getContent() %></td></tr>
<%
if(id != null){
	%>
<tr><td>다운로드</td><td colspan="3"><a href="file_down.jsp?file_name=<%=fb.getFile() %>">download:<%=fb.getFile() %></a></td></tr>
	
	<%
}
%>










<div id="table_search">
<%
if(id != null){
	if(fb.getName().equals(id)){
%><input type="button" value="글수정" onclick="location.href='fupdateForm.jsp?num=<%=fb.getNum()%>'">
<input type="button" value="글삭제" onclick="location.href='fdeleteForm.jsp?num=<%=fb.getNum()%>'">
<%		
}
	}


%>
<input type="button" value="글목록" onclick="location.href='fnotice.jsp'">
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