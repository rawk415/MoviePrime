<%@ page import="freepost.FreePostDTO" %>
<%@ page import="freepost.FreePostDAO" %>
<%@ page import="user.UserDAO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import='java.net.URLEncoder'%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
<head>
	<title>자유게시판</title>
	<meta charset="UTF-8">
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
<%
	/* 검색창 설정*/
	request.setCharacterEncoding("UTF-8");
	String search = "";
	if(request.getParameter("search") != null) {
		search = request.getParameter("search");
	}
%>
		<section id="main" class="container">
			<header>
				<h3><p>자유게시판</p></h3>
				<p>　　　　　　　　</p>
			</header>
			<section class="box">
				<form action="./freePost.jsp" method="get">
					<div class="row gtr-uniform gtr-50">
						<div class="col-9 col-12-mobilep">
							<input type="text" name="search" placeholder="내용을 입력하세요" />
						</div>
						<div class="col-3 col-12-mobilep">
							<input type="submit" value="검색" class="fit" />
						</div>
						<div style = "padding:30px ; float:right;"></div>
					</div>
				</form>
				<div class="table-wrapper">
					<table class='scrolltable' border='1px' cellspacing='0 '>
						<thead>
							<tr>
								<th width="80%">제목</th>
								<th width="20%">작성자</th>
							</tr>
						</thead>
						<tbody>
						<%
							ArrayList<FreePostDTO> freePostList = new FreePostDAO().getList(search);
							int i = 0;
							for (FreePostDTO freePostDTO : freePostList) {
								if(i == 10) break;
								i++;
						%>
						<tr>
							<td><a href="freePostDetail.jsp?postID=<%=freePostDTO.getPostID()%>"><%= freePostDTO.getPostTitle() %></a></td>
							<td><%= freePostDTO.getUserID() %></td>
						</tr>
						<%
							}
						%>
						</tbody>
						<tfoot>
						</tfoot>
					</table>
				</div>
			</section>
			<div style = "padding:10px ; float:right;">
				<ul class="actions">
					<li><a href="freePostRegister.jsp" class="button alt icon solid fa-check ">게시글 작성</a></li>
				</ul>
			</div>
		</section>
	</div>
	<!-- Scripts -->
	<%@ include file="./Fragment/Scripts.jspf" %>
</body>
</html>