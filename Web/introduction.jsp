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
	</style>

  <!-- Navigation -->
  <%
   String sessionId = (String) session.getAttribute("sessionId");
   %>
  
  <nav style="background-color:#545b62!important" class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
    <div class="container">
      <a class="navbar-brand" href="./home.jsp"><img src="images/logo.png" width="150px" heigt="80px"></a><button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
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
        <h2 class="my-4">프로젝트 소개</h2>
        <div class="list-group">
          <a href="#goal" class="list-group-item">개발 목표</a>
          <a href="#service" class="list-group-item">사용 방법</a>
          <a href="#app" class="list-group-item">어플 소개</a>
        </div>
      </div>
    
     <!-- goal-->
     <div style="margin-top:25px" class="col-lg-9">
        <section class="page-section bg-light" id="goal">
                        <h2 class="text-black mt-0">훈민정음의 목표</h2>
                        <hr class="divider light my-4" />
                        <p class="text-black-50 mb-4">우리 훈민점음은 시각장애인들이 전자책으로 보급되지 않은 책 또는 사진을 글 또는 음성으로 학습할 수 있게끔 도와주는 것을 목적으로 하고 있습니다. 또한 웹과 앱 내에서 모두 가능하여 시각장애인들의 접근성을 향상시키고, 점자로도 제공하여 다양한 방법으로 책 또는 사진을 접할 수 있게 도와주는 역할을 합니다. 즉 훈민점음은 다양한 형식의 파일을 변환하는 시각장애인용 학습기기로서, 시각장애인들의 편의성을 높이는 것에 목표를 두겠습니다.</p>
        				<hr class="divider light my-4" />
        </section>
        <!-- service-->
        <section class="page-section bg-light" id="service">
						<h2 class="text-black mt-0">훈민정음 사용 방법</h2>
                        <hr class="divider light my-4" />
                        <p class="text-black-50 mb-4">- 변환 사용법<br>1. 서비스 메뉴의 변환 버튼을 통해 사진 또는 문서를 선택합니다. <br>2. 출력된 변환 텍스트를 확대/ 축소 버튼을 통해 학습합니다. <br>3. 음성 재생 버튼을 통해 음성으로 학습합니다. <br>4. 로그인된 사용자라면 변환된 텍스트가 최근 기록에 자동으로 저장됩니다.<br>5. 최근 기록에서 본인이 다시 보고 싶은 변환 텍스트를 위의 방법으로 다시 학습할 수 있습니다.<br>6. 저장을 원하지 않는 기록은 삭제할 수 있습니다.<br>7. 점자변환을 원하는 이용자는 앱을 통해 기능을 이용할 수 있습니다(밑의 어플 소개 참고).<br><br>- 게시판 사용법<br>1. 로그인과 상관없이 모든 게시판에 접근할 수 있습니다.<br>2. 로그인한 회원은 직접 댓글 또는 게시글을 작성할 수 있습니다.<br>3. 자유게시판에서는 자유로운 대화를, 정보게시판에서는 앱을 비롯한 여러 정보들을 공유할 수 있습니다.<br>4. 훈민점음에 건의하고자 하는 내용은 건의게시판에 올릴 수 있고, 악성이용자를 신고게시판을 통해 고발할 수 있습니다.
                        <hr class="divider light my-4" />
        </section>
        
        <!-- app-->
        <section class="page-section bg-light" id="app">
                        <h2 class="text-black mt-0">어플리케이션</h2>
                        <hr class="text-black-50 mb-4"/>
                        <p class="text-black-50 mb-4">훈민점음은 웹뿐만 아니라, 앱으로도 같은 기능들을 제공하고 있다. 그리고, 앱같은 경우에는 웹에서 제공되는 기능 외에도 추가적으로 점자 변환 기능도 이용할 수 있다. 웹에서의 회원은 앱에서의 회원이므로 최근 기록 또한 공유되므로, 편안한 방법으로 훈민점음을 사용하면 된다.  
                        <hr class="divider light my-4" />
		 </section>
        </div>
    </div>
  </div>

  <!-- Bootstrap core JavaScript -->
  <script src="vendor/jquery/jquery.min.js"></script>
  <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

</body>

</html>
