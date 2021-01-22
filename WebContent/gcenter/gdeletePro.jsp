<%@page import="gboard.GBoardBeen"%>
<%@page import="gboard.GBoardDAO"%>
<%@page import="fboard.fboardBean"%>
<%@page import="com.sun.corba.se.impl.io.FVDCodeBaseImpl"%>
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
</head>
<body>
<%
request.setCharacterEncoding("utf-8");
int num = Integer.parseInt(request.getParameter("num"));
String pass = request.getParameter("pass");

// BoardDAO bdao = new BoardDAO();
// BoardBean bb = new BoardBean();
// bb.setPass(pass);
// bb.setNum(num);
// int check = bdao.numcheck(bb);

GBoardDAO gbdao = new GBoardDAO();
GBoardBeen gb = new GBoardBeen();
gb.setPass(pass);
gb.setNum(num);
int check = gbdao.gnumcheck(gb);


switch(check){

case 1 :
	gbdao.gdeleteBoard(gb);
	
	%><script type="text/javascript">
	alert("삭제완료");
	</script><%
	response.sendRedirect("gnotice.jsp");
	break;
case 0 :
	%><script type="text/javascript">
	alert("비밀번호 틀림");
	history.back();
	</script><%
	break;
case -1 :
	%><script type="text/javascript">
	alert("아이디 없음");
	history.back();
	</script><%
	break;
	
}

%>
<%=check %>
<%=num %>
<%=pass %>
</body>
</html>