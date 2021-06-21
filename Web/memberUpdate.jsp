<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="domain.MemberVO, persistence.MemberDAO"%>
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

  <!-- Custom styles for this template -->
  <link href="css/the-big-picture.css" rel="stylesheet">
  <link rel="stylesheet" href="css/style.css">
  <link rel="stylesheet" href="fonts/material-icon/css/material-design-iconic-font.min.css">

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
   MemberDAO dao = new MemberDAO();
   MemberVO vo = (MemberVO)dao.read(sessionId);
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

<!-- 회원가입 -->
	        <div align="center"  class="container ">
            <div class="page-header">
                <div style="padding-top:25px" align="left" class="col-md-6 col-md-offset-3">
                <h2>회원수정</h2><hr>
                </div>
            </div>
            <div class="col-sm-6 col-md-offset-3">
                <form action="MemberServlet?cmd=update" method="post">
                    <div align="left" class="form-group">
                        <label for="InputID">아이디</label>
                        <input type="text" class="form-control" name="id" value= <%=vo.getID() %> readonly>
                    </div>
                    <div align="left" class="form-group">
                        <label for="inputName">성명</label>
                        <input type="text" class="form-control" name="name" value=<%=vo.getName() %> >
                        
                    </div>

                    <div align="left" class="form-group">
                        <label for="inputPassword">비밀번호</label>
                        <input type="password" class="form-control" name="passwd" value=<%=vo.getPasswd() %>>
                    </div>
                    <div align="left" class="form-group">
                        <label for="inputEmail">이메일</label>
                        <input type="tel" class="form-control" name="email" value=<%=vo.getEmail() %>>
                    </div>

                    <div class="form-group text-center">
                       <input type="submit" name="submit" value="회원수정">
                    </div>
                </form>
                <button onclick = "location.href = 'MemberServlet?cmd=delete&id=<%=sessionId%>'" class="btn btn-primary float-right">회원 탈퇴</button>
            </div>

        </div>
  	<script src="vendor/jquery/jquery.min.js"></script>
  	<script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
  
  
</body>
</html>