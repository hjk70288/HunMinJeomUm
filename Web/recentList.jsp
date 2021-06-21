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
 <script type="text/javascript">

// 1.모두 체크
  function allChk(obj){
      var chkObj = document.getElementsByName("RowCheck");
      var rowCnt = chkObj.length - 1;
      var check = obj.checked;
      if (check) {﻿
          for (var i=0; i<=rowCnt; i++){
           if(chkObj[i].type == "checkbox")
               chkObj[i].checked = true;
          }
      } else {
          for (var i=0; i<=rowCnt; i++) {
           if(chkObj[i].type == "checkbox"){
               chkObj[i].checked = false;
           }
          }
      }
  } 
//2. 선택했는지 확인
  function chk(){
	  var userid = "";
	  var memberChk = document.getElementsByName("RowCheck");
	  var chked = false;
	  var indexid = false;
	  for(i=0; i < memberChk.length; i++){
	   if(memberChk[i].checked){
	    if(indexid){
	      userid = userid + '-';
	    }
	    userid = userid + memberChk[i].value;
	    indexid = true;
	   }
	  }
	  if(!indexid){
	   alert("삭제할 리스트를 체크해 주세요");
	   return false;
	  }
}


</script> 

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
        <h2 class="my-4">서비스</h2>
        <div class="list-group">
          <a href="<c:url value ="/service.jsp"/>" class="list-group-item">변환</a>
           <c:choose>
               <c:when test="${empty sessionId}">
					<a href="<c:url value ="/loginform.jsp"/>" class="list-group-item active">최근 목록 보기</a>
               </c:when>
               <c:otherwise>
              	    <a href="<c:url value ="/recentList.jsp"/>" class="list-group-item active">최근 목록 보기</a>
               </c:otherwise>
            </c:choose>
        </div>
      </div>

   <!-- Board-->
	<div class="col-lg-9" style="margin-top:30px">
       <form action="OcrServlet?cmd=ocr_delete" name= ocrForm method="post" onsubmit="return chk();">
     	<h2 class="text-black mt-0">최근 변환 목록</h2>
     	<table style="table-layout: fixed" class="table table-bordered">
     		<thead>
     			<tr>
     				<th width="30px"><input id="allCheck" style="display:inline" type="checkbox" onclick="allChk(this);"/></th>
     				<th width="200px">내용</th>
     			</tr>
     		</thead>
     		<tbody>
     			<%
     				OcrDAO dao = new OcrDAO();
     				List<OcrVO> ocrList = dao.getMemberList(sessionId);
					for(OcrVO vo : ocrList){
   	 			%>
   	 	
        		 <tr>
 		<c:set var="data" value="<%=vo.getContent() %>" />
 		<c:if test="${not empty data}">


        		 	<td width="30px"><input style="display:inline" type="checkbox" name="RowCheck" value="<%=vo.getNum()%>"/></td>
         			<td onClick="location.href='OcrServlet?cmd=ocr&num=<%=vo.getNum()%>'" width="200px" style="text-overflow: ellipsis; overflow: hidden; white-space: nowrap"><nobr><c:out value="${data}" /></nobr></td>
					 		</c:if>
		 		</tr>
		 		<%
   	 				}
		 		%>
     		</tbody>
     	</table>
     	<hr>
     	<input type="submit" value="삭제" >
     	</form>
     </div>
  </div>
    </div>

  

  <!-- Bootstrap core JavaScript -->
  <script src="vendor/jquery/jquery.min.js"></script>
  <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

</body>

</html>
