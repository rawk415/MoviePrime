<%@page import="freepost.FreePostDAO"%>
<%@page import="freepost.FreePostDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %>
<!DOCTYPE HTML>
<html>
<head>
	<title>자유게시판</title>
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
			<h3><p>자유게시판</p></h3>
			<p>　　　　　　　　</p>
		</header>
		<%
			String postID = request.getParameter("postID");
			FreePostDTO freePostDTO= new FreePostDAO().getFreePost(postID);
		%>
		<section class="box">
			<table>
				<thead>
					<tr>
						<td align=left><%=freePostDTO.getPostTitle()%></td>
						<td align=right><%=freePostDTO.getPostID()%></td>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>작성자: <%=freePostDTO.getUserID()%></td>
						<td></td>
					</tr>												
				</tbody>
				<thead>
				</thead>
				<thead>
				</thead>
				<div class="table-wrapper">
					<table class='scrolltable' border='1px' cellspacing='0'>
						<pre><%=freePostDTO.getPostContent()%></pre>
				</div>
			</table>
		</section>
	</div>
	<!-- Scripts -->
	<%@ include file="./Fragment/Scripts.jspf" %>
	</body>
</html>