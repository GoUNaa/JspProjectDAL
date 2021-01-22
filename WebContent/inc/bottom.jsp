<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<footer>
<script>
function mail(){
	window.open("../mail/mailForm.jsp","","width=500,height=500");
}

function map() {
	window.open("../map/mapForm.jsp","","width=500,height=500");
}

</Script>
<hr>
<div id="copy">All contents Copyright 2011 FunWeb 2011 FunWeb 
Inc. all rights reserved<br>
Contact mail :  zzaaqqqaz@naver.com   Tel +82 64 123 4315
Fax +82 64 123 4321 <br>
<a onclick="map()" style="cursor: pointer">부산광역시 부산진구 동천로 109 삼한골든게이트 7층</a></div>
<div id="social"><img src="../images/facebook.gif" width="33" 
height="33" alt="Facebook">
<img src="../images/twitter.gif" width="34" height="34"
alt="Twitter">
<%
String id = (String)session.getAttribute("id");
if(id != null){
%><img src="../images/mail.png" width="34" height="34" alt="mail" onclick="mail()" style="cursor: pointer">
	<%
}
%>
</div>

</footer>

<!-- //<a href="../mail/mailForm.jsp">  </a>-->