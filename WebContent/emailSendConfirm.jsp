<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import='user.UserDAO'%>    
<!DOCTYPE html>
<html>
<head>
	<title>Movie Prime</title>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
	<link rel="stylesheet" href="assets/css/main.css" />
</head>
<body>
<%
	String userID = null;
	if(session.getAttribute("userID") != null) {
		userID = (String)session.getAttribute("userID");
	}
	if(userID == null) {
		out.println("<script>");
		out.println("alert('로그인을 해주세요.');");
		out.println("location.href='index.jsp';");
		out.println("</script>");
		return;
	}
%>
	<h1><a href="index.jsp">M O V I E P R I M E</a>  </h1>
	<nav id="nav">
	    <ul>
	        <li><a href="index.jsp">Home</a></li>
	        <li>
	            <a href="#" class="icon solid fa-angle-down">Menu</a>
	            <ul>
	                <li>
	                    <a href="crawlingMovie.jsp">Movie</a>
	                    <ul>
	                        <li><a href="presentScreeningMovie.jsp">현재상영작</a></li>
	                        <li><a href="scheduledReleaseMovie.jsp">상영예정작</a></li>
	                    </ul>
	                </li>
	                <li>
	                    <a href="#">Community</a>
	                    <ul>
	                        <li><a href="post.jsp">리뷰게시판</a></li>
	                        <li><a href="freePost.jsp">자유게시판</a></li>
	                    </ul>
	                </li>
	                <li>
	                    <a href="#">Service</a>
	                    <ul>
	                        <li><a href="report.jsp">문의하기</a></li>
	                    </ul>
	                </li>
	            </ul>
	        </li>
	        <%
	            if(session.getAttribute("userID") != null) {
	                userID = (String)session.getAttribute("userID");
	            }
	            if(userID == null) {
	        %>
	        <li><a href="userLogin.jsp" class="button">Log-in</a></li>
	        <%
	        } else {
	        %>
	        <li><a href="userLogout.jsp" class="button">Log-out</a></li>
	        <%
	            }
	        %>
	    </ul>
	</nav>
	<section class="container mt-3" style="max-width: 560px;">
		<div class="alert alert-warning mt-4" role="alert">
			이메일 인증을 하셔야 이용 가능합니다. 인증 메일을 받지 못하셨나요?
		</div>	
		<a href="emailSendAction.jsp" class="btn btn-primary">인증 메일 다시 받기</a>
	</section>

<%@ include file="./Fragment/Footer.jspf" %>
</body>
</html>