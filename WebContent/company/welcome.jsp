<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">

<!--[if lt IE 9]>
<script src="http://ie7-js.googlecode.com/svn/version/2.1(beta4)/IE9.js" type="text/javascript"></script>
<script src="http://ie7-js.googlecode.com/svn/version/2.1(beta4)/ie7-squish.js" type="text/javascript"></script>
<script src="http://html5shim.googlecode.com/svn/trunk/html5.js" type="text/javascript"></script>
<![endif]-->

<!--[if IE 6]>
 <script src="../script/DD_belatedPNG_0.0.8a.js"></script>
 <script>
   /* EXAMPLE */
   DD_belatedPNG.fix('#wrap');
   DD_belatedPNG.fix('#main_img');   

 </script>
 <![endif]-->
 
</head>
<body>
<div id="wrap">
<!-- 헤더가 들어가는 곳 -->
<jsp:include page="../inc/top.jsp"/>
<!-- 헤더가 들어가는 곳 -->

<!-- 본문 들어가는 곳 -->
<!-- 서브페이지 메인이미지 -->
<div id="sub_img"></div>
<!-- 서브페이지 메인이미지 -->
<!-- 왼쪽메뉴 -->
<nav id="sub_menu">
<ul>
<li><a href="#">Welcome</a></li>
<li><a href="#">History</a></li>
<li><a href="#">Newsroom</a></li>
<li><a href="#">Public Policy</a></li>
</ul>
</nav>
<!-- 왼쪽메뉴 -->
<!-- 내용 -->
<article>
<h1>Welcome</h1>
<figure class="ceo"><img src="../images/company/wm5.gif" width="200" height="226" 
alt="CEO"><figcaption>달</figcaption>
</figure>
<p>달(Moon)은 지구의 유일한 자연위성이다. 지구 중심에서 달 중심까지의 거리는 평균 384399 km(0.00257 AU)이며, 근지점과 원지점 거리는 각각 362600 km과 405400 km이다. 공전궤도의 이심률은 0.0549, 공전주기는 27.321661일이며, 공전궤도면은 황도면과 5.145° 기울어져 있다. 질량은  kg, 반지름은 1737.1 km 이다. 달은 태양계 위성 중에 5번째로 크지만, 행성에 대한 비율로 따지면 제일 크다. 평균 밀도는 3.344 gcm-3, 표면중력은 1.62 ms-2이다. 달의 자기장은 지구 자기장 세기의 1% 미만이라고 알려져 있다. 달은 국부적으로 지각이 자화되어 있을 뿐 지구에서처럼 다이나모가 작용하는 것으로 보이지는 않는다.

공전주기는 자전주기와 동일한 27.321661일이다. 이는 달과 지구 사이에 작용하는 기조력(tidal force) 때문에 생기는 자연스러운 현상이다. 이처럼 동주기자전(synchronous rotation)의 결과 원리적으로는 우리가 달의 50% 밖에 볼 수 없지만, 칭동(libration) 현상 때문에 59%까지 가능하다(그림 5 참조). 오랜 시간이 지나면 지구의 자전주기와 달의 공전주기도 같아져 지구 한쪽에서는 언제나 달을 볼 수 있고 그 반대쪽에서는 볼 수 없게 된다. 과학자들은 뉴호라이즌스호 (New Horizons)의 탐사자료를 분석해 명왕성 (Pluto)과 카론 (Charon)은 이런 식으로 궤도를 돈다는 사실을 알아냈다.
[네이버 지식백과] 달 [Moon] (천문학백과)</p>
</article>
<!-- 내용 -->
<!-- 본문 들어가는 곳 -->
<div class="clear"></div>
<!-- 푸터 들어가는 곳 -->
<jsp:include page="../inc/bottom.jsp"/>
<!-- 푸터 들어가는 곳 -->
</div>
</body>
</html>



    