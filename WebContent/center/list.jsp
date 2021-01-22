<%@page import="java.util.List"%>
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
BoardDAO bdao = new BoardDAO();
List boardList = bdao.getBoardList();

%>

<table border="1">
<tr>
 <td class = tableNum>번호</td>
      <td class = tableTitle>제목</td>
      <td class = tableUserName>작성자</td>
      <td class = tableReadCount>조회수</td>
      <td class = tableRegDate>작성일</td>
    
  </tr>
  
  <%
for(int i = 0; i < boardList.size(); i++){
	
	BoardBean bb=(BoardBean)boardList.get(i);
%>
<tr>
<td><%=bb.getNum()%></td> <td><a href="content.jsp?num=<%=bb.getNum()%>"><%=bb.getSubject() %></a></td>
<td><%=bb.getName()%></td><td><%=bb.getReadcount()%></td>
<td><%=bb.getDate()%></td>
</tr>
<%
   }
%>
  
  </table>
</body>
</html>