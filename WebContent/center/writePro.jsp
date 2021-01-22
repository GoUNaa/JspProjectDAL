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
request.setCharacterEncoding("utf-8");
//파라미터 가져오기
String name = request.getParameter("name");	//작성자
String pass = request.getParameter("pass");	//패스워드
String subject = request.getParameter("subject"); //제목
String content = request.getParameter("content"); //글내용
int readcount = 0; //조회수
Timestamp date = new Timestamp(System.currentTimeMillis()); //글쓴날짜




//패키지 board 파일이름 BoardBean
//멤버변수 set() get()
// BoardBean bb 객체 생성
BoardBean bb = new BoardBean();
//bb set메서드 호출 <=  파라미터값 저장
bb.setName(name);
bb.setPass(pass);
bb.setSubject(subject);
bb.setContent(content);
bb.setReadcount(readcount);
bb.setDate(date);
//file 추가 

BoardDAO bdao =  new BoardDAO();
bdao.insertBoard(bb);


response.sendRedirect("notice.jsp");
%>


</body>
</html>