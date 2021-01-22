<%@page import="board.BoardDAO"%>
<%@page import="board.BoardBean"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>WebContent/board/reWritePro.jsp</h1>
<%
// request 한글처리
request.setCharacterEncoding("utf-8");
// name, pass, subject, content 파라미터 가져오기
String name=request.getParameter("name");
String pass=request.getParameter("pass");
String subject=request.getParameter("subject");
String content=request.getParameter("content");
// int readcount = 0 //조회수
int readcount = 0;
// 글쓴날짜 <= 현시스템에 날짜시간을 가져오기
Timestamp date=new Timestamp(System.currentTimeMillis());
//num re_ref  re_lev  re_seq 파라미터 가져오기
int num=Integer.parseInt(request.getParameter("num"));
int re_ref=Integer.parseInt(request.getParameter("re_ref"));
int re_lev=Integer.parseInt(request.getParameter("re_lev"));
int re_seq=Integer.parseInt(request.getParameter("re_seq"));

// 게시판글을 하나의 바구니(자바빈)에 저장
// 패키지 board 파일이름 BoardBean  
// 멤버변수 num name, pass, subject, content,readcount,date 정의
// BoardBean bb 객체생성
BoardBean bb=new BoardBean();
// bb set메서드 호출 <= 파라미터 값 저장
bb.setName(name);
bb.setPass(pass);
bb.setSubject(subject);
bb.setContent(content);
bb.setReadcount(readcount);
bb.setDate(date);
//num re_ref  re_lev  re_seq 자바빈 파라미터 값 저장
bb.setNum(num);
bb.setRe_ref(re_ref);
bb.setRe_lev(re_lev);
bb.setRe_seq(re_seq);

// 게시판 데이터베이스 작업 
// 패키지 board 파일이름 BoardDAO
// 리턴값없음 insertBoard(bb바구니주소값) 메서드 만들기
// BoardDAO bdao 객체생성
BoardDAO bdao=new BoardDAO();
// reInsertBoard(bb) 메서드 호출
bdao.reInsertBoard(bb);

// 글목록 이동 
response.sendRedirect("notice.jsp");
%>
</body>
</html>










