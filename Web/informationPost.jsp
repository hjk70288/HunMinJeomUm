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
  <link href="css/the-big-picture.css" rel="stylesheet">
  <link rel="stylesheet" href="css/style.css">
  <link rel="stylesheet" href="fonts/material-icon/css/material-design-iconic-font.min.css">

</head>

<body>
<style>
h2{
font-family: "Nanum Gothic", sans-serif;
}
td{
font-weight:"bold";
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
          <a href="<c:url value ="/freeBoard.jsp"/>" class="list-group-item ">자유 게시판</a>
          <a href="<c:url value ="/informationBoard.jsp"/>" class="list-group-item active">정보 게시판</a>
          <a href="<c:url value ="/declarationBoard.jsp"/>" class="list-group-item">신고 게시판</a>
          <a href="<c:url value ="/suggestionBoard.jsp"/>" class="list-group-item">건의 게시판</a>
      </div>
   </div>
   <!-- Post-->
    <%
    	PostVO vo = (PostVO)request.getAttribute("postVO");
  	 %>
     <div style="margin-top:25px" class="col-lg-9">
     	<h2 class="text-black mt-0">정보 게시판</h2>
     	<br>
     	<table class="table table-bordered" id="detailBoard" height="440" border="3" style="background-color::#545b62">
        
            <tr height="30" >
                <td style="background-color:#545b62; color:#FFFFFF; text-align:center; font-weight: bold" id="date">작성일</td>
                <td><%=vo.getDate() %></td>
                <td style="background-color:#545b62; color:#FFFFFF; text-align:center; font-weight: bold" id="title">작성자</td>
                <td><%=vo.getId() %></td>
                <td style="background-color:#545b62; color:#FFFFFF; text-align:center; font-weight: bold" id="view">조회수</td>
                <td><%=vo.getView() %></td>
            </tr>
            <tr height="30">
                <td style="background-color:#545b62; color:#FFFFFF; text-align:center; font-weight: bold" id="title">제 목</td>
                <td colspan = "5">
                    <%=vo.getTitle() %>
          		</td>        
            </tr>
            <tr height="350">
                <td style="background-color:#545b62; color:#FFFFFF; text-align:center; font-weight: bold" id="content">
                    내 용
                </td>
                <td colspan="5">
                    <%=vo.getContent() %>
                </td>        
            </tr>
            </table>
            <c:set var="writer" value="<%=vo.getId()%>"/>
               <c:choose>
               	<c:when test="${empty sessionId}">
               	</c:when>
               	<c:when test="${sessionId eq writer}">
                        	<button class="btn  btn-dark float-right" onclick="location.href='PostServlet?cmd=info_delete&num=<%=vo.getPostNum()%>&date=<%=vo.getDate() %>'">삭제</button>
                        	<button class="btn  btn-dark float-right" onclick="location.href='PostServlet?cmd=info_update&num=<%=vo.getPostNum()%>&date=<%=vo.getDate() %>'">수정</button>       
               				<br><br>
               </c:when>
               	<c:when test="${sessionId eq 'admin'}">
                        	<button class="btn  btn-dark float-right" onclick="location.href='PostServlet?cmd=info_delete&num=<%=vo.getPostNum()%>&date=<%=vo.getDate() %>'">삭제</button>    
               				<br><br>
               	</c:when>
               	<c:otherwise>     
               	</c:otherwise>
        	   </c:choose>
        <br>
        <!-- 댓글 부분 -->
        <form action="PostServlet?cmd=info_comment_add&id=<%=sessionId%>&num=<%=vo.getPostNum() %>" method="post">
    	<div id="comment">
        <table border="1" bordercolor="lightgray">
   		 <!-- 댓글 목록 -->   
   		 <%
   			CommentDAO commentDAO = new CommentDAO();
			List<CommentVO> commentList = commentDAO.getInfoCommentList(vo.getId(), vo.getPostNum());
			for(CommentVO commentVO : commentList){

   	 	%>
            <tr height="50">
                <!-- 아이디, 작성날짜 -->
                <td width="150">
                    <div align="center">
                        <%=commentVO.getId() %><br>
                        <font size="2" color="lightgray"><%=commentVO.getDate() %></font>
                    </div>
                </td>
                <!-- 본문내용 -->
                <td width="550">
                    <div class="text_wrapper">
                        <%=commentVO.getContent() %>
                    </div>
                </td>
                <!-- 버튼 -->
               <c:set var="writer" value="<%=commentVO.getId()%>"/>
               <c:choose>
               	<c:when test="${empty sessionId}">
               		<td width="100">        
               		</td>
               	</c:when>

               	<c:when test="${sessionId eq writer}">
					<td width="100" align="center">  
						<button type="button" class="btn  btn-dark" onclick="location.href='PostServlet?cmd=info_comment_delete&id=<%=sessionId%>&num=<%=vo.getPostNum()%>&date=<%=commentVO.getDate()%>'">삭제</button>
                	</td>
               </c:when>
               	<c:when test="${sessionId eq 'admin'}">
                	<td width="100" align="center">
                		<button type="button" class="btn  btn-dark" onclick="location.href='PostServlet?cmd=info_comment_delete&id=<%=commentVO.getId()%>&num=<%=vo.getPostNum()%>&date=<%=commentVO.getDate()%>'">삭제</button>
               		 </td>
               	</c:when>
               	<c:otherwise>
               		<td width="100">        
               		</td>
               	</c:otherwise>
        	   </c:choose>
            </tr>
            <%} %>
             
            
            <tr bgcolor="#F5F5F5">
                <!-- 아이디-->
                <td width="150">
                    <div align="center" style="font-weight:bold">
                        	댓글 작성
                    </div>
                </td>
                <!-- 본문 작성-->
                <td width="550">
                    <div>
                        <textarea name="comment_content" rows="4" cols="90" ></textarea>
                    </div>
                </td>
                <!-- 댓글 등록 버튼 -->
                <td width="100">
                    <div id="btn" style="text-align:center;">
                    <c:choose>
              		 <c:when test="${empty sessionId}">
               			<button type="button" class="btn btn-dark" onclick="location.href = '<c:url value ="/loginform.jsp"/>'">완료</button>
               		 </c:when>           
            	 	 <c:otherwise>
                		<button type="submit" class="btn  btn-dark" onclick="writeCmt()">완료</button>
               		 </c:otherwise>
            		</c:choose>
    
                    </div>
                </td>
            </tr>
    
        </table>
   		</div>
</form>
        
        
     </div>
     </div>
  </div>
    

  <!-- Bootstrap core JavaScript -->
  <script src="vendor/jquery/jquery.min.js"></script>
  <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

</body>

</html>