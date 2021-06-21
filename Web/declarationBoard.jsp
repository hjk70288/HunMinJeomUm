<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="domain.*, java.util.List, persistence.*,java.util.Collections"%>
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
        <h2 class="my-4">커뮤니티</h2>
        <div class="list-group">
          <a href="<c:url value ="/freeBoard.jsp"/>" class="list-group-item">자유 게시판</a>
          <a href="<c:url value ="/informationBoard.jsp"/>" class="list-group-item">정보 게시판</a>
          <a href="<c:url value ="/declarationBoard.jsp"/>" class="list-group-item active">신고 게시판</a>
          <a href="<c:url value ="/suggestionBoard.jsp"/>" class="list-group-item">건의 게시판</a>
      </div>
   </div>
   <!-- Board-->
     <div style="margin-top:25px" class="col-lg-9">
     	<h2 class="text-black mt-0">신고게시판</h2>
     	<table class="table table-bordered table-hover">
     		<thead>
     			<tr>
     				<th width="10px">번호</th>
     				<th width="100px">제목</th>
     				<th width="60px">작성자</th>
     				<th width="40px">날짜</th>
     				<th width="10px">조회수</th>
     			</tr>
     		</thead>
     		<tbody>
     			<%
     				PostDAO dao = new PostDAO();
     				List<PostVO> postList = dao.getDeclarePostList();
     				Collections.reverse(postList);
					for(PostVO vo : postList){
   	 			%>
   	 	
        		 <tr onClick="location.href='PostServlet?cmd=declare&num=<%=vo.getPostNum()%>'">
         			<td width="10px"><%=vo.getPostNum()%></td>
         			<td width="100px"><%=vo.getTitle() %></td>
     				<td width="60px"><%=vo.getId() %></td>
     				<td width="40px"><%=vo.getDate() %></td>
     				<td width="10px"><%=vo.getView() %></td>
		 		</tr>
		 		<%
   	 				}
		 		%>
     		</tbody>
     	</table>
     	<hr>
     	<c:choose>
               <c:when test="${empty sessionId}">
               <a class="btn btn-dark float-right" href="<c:url value ="/loginform.jsp"/>">글쓰기</a>
               </c:when>
               <c:when test="${sessionId eq 'admin'}">
				<a class="btn btn-dark float-right" href="<c:url value ="/writing.jsp"/>">글쓰기</a>
               </c:when>
               <c:otherwise>
                 <a class="btn btn-dark float-right" href="<c:url value ="/writing.jsp"/>">글쓰기</a>
               </c:otherwise>
        </c:choose>
     </div>
     </div>
  </div>

  <!-- Bootstrap core JavaScript -->
  <script src="vendor/jquery/jquery.min.js"></script>
  <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

</body>

</html>
