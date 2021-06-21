<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html lang="en">
    
<!DOCTYPE html>
<html>

<head>

  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="">
  <meta name="author" content="">

  <title>훈민점음</title>

  <!-- Bootstrap core CSS -->
  <link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="fonts/material-icon/css/material-design-iconic-font.min.css">
  <link rel="stylesheet" href="css/style.css">

</head>

<body>

<style>
h2{
font-family: "Nanum Gothic", sans-serif;
}
#back{
position: absolute;
z-index: 100;
background-color: #000000;
display:none;
left:0;
top:0;
}
#loadingBar{
position:absolute;
left:50%;
top: 40%;
display:none;
z-index:200;
}
	</style>

  <!-- Navigation -->
  <%
   String sessionId = (String) session.getAttribute("sessionId");
   %>
  
  <nav style="background-color:#545b62!important" class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
    <div class="container">
      <a class="navbar-brand" href="./home.jsp"><img src="images/logo.png" width="150px" height="80px"></a><button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse" id="navbarResponsive">
        <ul class="navbar-nav ml-auto">
           <c:choose>
               <c:when test="${empty sessionId}">
               	<li class="nav-item">
            		<a style="color:white" class="nav-link" href="<c:url value="/loginform.jsp"/>"> 로그인</a>
         		</li>
               </c:when>
               <c:when test="${sessionId eq 'admin'}">
				<li class="nav-item">
            		<a style="color:white" class="nav-link" href="<c:url value="/adminPage.jsp"/>">회원관리</a>
         		</li>
         		<li class="nav-item">
            		<a style="color:white" class="nav-link" href="MemberServlet?cmd=logout"target="_self">로그아웃</a>
         		</li>
               </c:when>
               <c:otherwise>
                 <li class="nav-item">
            		<a style="color:white" class="nav-link" href="MemberServlet?cmd=logout"target="_self">로그아웃</a>
         		</li>
         		 <li class="nav-item">
            		<a style="color:white" class="nav-link" href="<c:url value ="/memberUpdate.jsp"/>">회원수정</a>
         		</li>
               </c:otherwise>
            </c:choose>
          <li class="nav-item">
            <a style="color:white" class="nav-link" href="<c:url value ="/introduction.jsp"/>">프로젝트 소개</a>
          </li>
          <li class="nav-item">
            <a style="color:white" class="nav-link" href="<c:url value ="/service.jsp"/>">서비스</a>
          </li>
          <li class="nav-item">
            <a style="color:white" class="nav-link" href="<c:url value ="/freeBoard.jsp"/>">커뮤니티</a>
          </li>
        </ul>
      </div>
    </div>
  </nav>
  
  <!-- 내용 -->
    
   <div class="container">

    <div class="row">

      <div class="col-lg-3 fixed">
        <h2 class="my-4">서비스</h2>
        <div class="list-group">
          <a href="<c:url value ="/service.jsp"/>" class="list-group-item active">변환</a>
           <c:choose>
               <c:when test="${empty sessionId}">
					<a href="<c:url value ="/loginform.jsp"/>" class="list-group-item">최근 목록 보기</a>
               </c:when>
               <c:otherwise>
              	    <a href="<c:url value ="/recentList.jsp"/>" class="list-group-item">최근 목록 보기</a>
               </c:otherwise>
            </c:choose>
        </div>
      </div>
      <form id="submit_form" action="<c:url value ="/showOcr.jsp"/>" method="post" enctype="multipart/form-data">
      <div class="col-lg-9" style="margin-top:100px">
      		<input type="file" name="file" id="imageFileOpenInput">
      		<button type="submit" id="submit" class="btn  btn-dark  float-right" onclick="FunLoadingBarStart()">변환</button>
		</div>    

   </form>
    </div>

  </div>

  <!-- Bootstrap core JavaScript -->
  <script src="vendor/jquery/jquery.min.js"></script>
  <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
  <script src='js/recieve.js'></script>
</body>
<script type="text/javascript"> 
	function FunLoadingBarStart() {
		var backHeight = $(document).height(); //뒷 배경의 상하 폭
		var backWidth = window.document.body.clientWidth; //뒷 배경의 좌우 폭
		var backGroundCover = "<div id='back'></div>"; //뒷 배경을 감쌀 커버
		var loadingBarImage = ''; //가운데 띄워 줄 이미지
		loadingBarImage += "<div id='loadingBar'>";
		loadingBarImage += " <img src='images/loading.gif' class='rotate270'>"; //로딩 바 이미지
		loadingBarImage += "<br>LOADING...";
		loadingBarImage += "</div>";
		$('body').append(backGroundCover).append(loadingBarImage);
		$('#back').css({ 'width': backWidth, 'height': backHeight, 'opacity': '0.3' });
		$('#back').show();
		$('#loadingBar').show();
	}
</script>
</html>
