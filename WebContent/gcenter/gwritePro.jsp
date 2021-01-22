<%@page import="gboard.GBoardDAO"%>
<%@page import="gboard.GBoardBeen"%>
<%@page import="fboard.fboardDAO"%>
<%@page import="fboard.fboardBean"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="board.BoardDAO"%>
<%@page import="java.sql.Timestamp"%>
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
//한글처리
// request.setCharacterEncoding("utf-8");
//파라미터 가져오기

//파일업로드폴더
//MultipartRequest multi = new MultipartRequest(request,파일업로드폴더,파일크기,한글처리,동일파일이름처리);

// 파일업로드폴더(물리적인경로)
String uploadPath=request.getRealPath("/gupload");

System.out.println(uploadPath);
//파일크기 10M
int maxSize = 10 * 1024 * 1024;

MultipartRequest multi = new MultipartRequest(request,uploadPath,maxSize,"utf-8",new DefaultFileRenamePolicy());



// request - >multi 

String name = multi.getParameter("name");	//작성자
String pass = multi.getParameter("pass");	//패스워드
String subject = multi.getParameter("subject"); //제목
String content = multi.getParameter("content"); //글내용
int readcount = 0; //조회수
Timestamp date = new Timestamp(System.currentTimeMillis()); //글쓴날짜

// 업로드된 파일 이름 가져와서 file 변수에 저장
String file = multi.getFilesystemName("file");



//패키지 board 파일이름 BoardBean
//멤버변수 set() get()
// BoardBean bb 객체 생성
GBoardBeen gb = new GBoardBeen();
//bb set메서드 호출 <=  파라미터값 저장
gb.setName(name);
gb.setPass(pass);
gb.setSubject(subject);
gb.setContent(content);
gb.setReadcount(readcount);
gb.setDate(date);
//file 추가 
gb.setFile(file);

GBoardDAO gbdao = new GBoardDAO();
gbdao.insertgBoard(gb);

response.sendRedirect("gnotice.jsp");
%>


</body>
</html>