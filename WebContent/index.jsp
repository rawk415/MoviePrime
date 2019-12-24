<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<title>MOVIE_PRIME</title>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
	<link rel="stylesheet" href="assets/css/main.css" />
</head>
<body class="landing is-preload">
	<div id="page-wrapper">
		<!-- Navigator -->
		<header id="header" class="alt">
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
			            String userID = null;
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
		<!-- Banner -->
		<section id="banner">
			<h2>MOVIE PRIME</h2>
			<ul class="actions special">
				<form method="get" action="searchMoive.jsp">
					<div class="col-12">
						<div class="row gtr-uniform gtr-50">
							<div class="col-9 col-15-mobilep">
								<input type="text" name="search" style="color:#000000" placeholder="어떤 영화를 찾고 계시나요?"/>
							</div>
							<div class="col-3 col-4-mobilep">
								<li><button type="submit" class="button special icon solid fa-search">검색</button></li>
							</div>
						</div>
					</div>
				</form>
			</ul>
		</section>
		<!-- Footer -->
		<%@ include file="./Fragment/Footer.jspf" %>
		<!-- Scripts -->
		<%@ include file="./Fragment/Scripts.jspf" %>
	</div>
</body>
</html>