<%@page import="post.PostDAO"%>
<%@page import="post.PostDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %>
<!DOCTYPE HTML>
<html>
<head>
	<title>리뷰게시판</title>
	<meta charset="UTF-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
	<link rel="stylesheet" href="assets/css/main.css" />
</head>
<%
    String userID = null;
    if(session.getAttribute("userID") != null) {
        userID = (String)session.getAttribute("userID");
    }
    if(userID == null) {
        out.println("<script>");
        out.println("alert('로그인을 해주세요.');");
        out.println("location.href='userLogin.jsp';");
        out.println("</script>");
        return;
    }
    boolean emailChecked = new UserDAO().getUserEmailChecked(userID);
    if(!emailChecked) {
        out.println("<script>");
        out.println("location.href='emailSendConfirm.jsp';");
        out.println("</script>");
        return;
    }
%>
<body class="is-preload">
	<div id="page-wrapper">
	<!-- Header -->
		<header id="header">
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
		</header>
		<!-- main -->
		<section id="main" class="container">
		<header>
			<h3><p>리뷰게시판</p></h3>
			<p>　　　　　　　　</p>
		</header>
		<%
			String postID = request.getParameter("postID");
			PostDTO postDTO= new PostDAO().getPost(postID);
			String stars="";
			for(int i=0; i <= postDTO.getMovieTotalScore(); i++) {
				stars += "★";
			}
		%>
		<section class="box">
			<table>
				<thead>
					<tr>
						<td align=left><%=postDTO.getPostTitle()%></td>
						<td align=right>영화: <%=postDTO.getMovieTitle()%></td>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>작성자: <%=postDTO.getUserID()%></td>
						<td>별점: <%=stars%></td>
						<td><a onclick="return confirm('추천하시겠습니까?')" href="./likeAction.jsp?postID=<%=postDTO.getPostID() %>">좋아요: <%=postDTO.getLikeCount()%></a></td>
						<td><a onclick="return confirm('삭제하시겠습니까?')" href="./deleteAction.jsp?postID=<%=postDTO.getPostID() %>">삭제</a></td>
					</tr>												
				</tbody>
				<thead>
				</thead>
				<thead>
				</thead>
				<div class="table-wrapper">
					<table class='scrolltable' border='1px' cellspacing='0'>
						<pre><%=postDTO.getPostContent()%></pre>
				</div>
			</table>
		</section>
	</div>
	<!-- Scripts -->
	<%@ include file="./Fragment/Scripts.jspf" %>
	</body>
</html>