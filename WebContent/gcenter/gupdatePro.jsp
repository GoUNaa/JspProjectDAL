<%@page import="gboard.GBoardDAO"%>
<%@page import="gboard.GBoardBeen"%>
<%@page import="fboard.fboardDAO"%>
<%@page import="fboard.fboardBean"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="board.BoardDAO"%>
<%@page import="board.BoardBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
request.setCharacterEncoding("utf-8");

String uploadPath=request.getRealPath("/gupload");

System.out.println(uploadPath);
//파일크기 10M
int maxSize = 10 * 1024 * 1024;

MultipartRequest multi = new MultipartRequest(request,uploadPath,maxSize,"utf-8",new DefaultFileRenamePolicy());

int num=Integer.parseInt(multi.getParameter("num"));
String name = multi.getParameter("name");	//작성자
String pass = multi.getParameter("pass");	//패스워드
String subject = multi.getParameter("subject"); //제목
String content = multi.getParameter("content"); //글내용
//file 새롭게 추가 파일
String file = multi.getFilesystemName("file");
//file 기존 파일이름
if(file == null){
	file = multi.getParameter("oldfile");
}



GBoardBeen gb = new GBoardBeen();
gb.setNum(num);
gb.setName(name);
gb.setPass(pass);
gb.setSubject(subject);
gb.setContent(content);
gb.setFile(file);
GBoardDAO gbdao = new GBoardDAO();
int check = gbdao.gnumcheck(gb);

if(check == 1){
	gbdao.gupdateBoard(gb);
	response.sendRedirect("gnotice.jsp");
} else if(check == 0){
	%>
	<script type="text/javascript">
		alert("비밀번호 틀림");
		history.back(); // 뒤로이동 
	</script>
	<%
} else {
	%>
	<script type="text/javascript">
			alert("아이디 없음");
			history.back(); // 뒤로이동 
	</script>
	<%
}

%>











</body>
</html>