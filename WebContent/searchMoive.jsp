<%@ page import="movie.MovieDTO" %>
<%@ page import="movie.MovieDAO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
<head>
	<title>검색 결과</title>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
	<link rel="stylesheet" href="assets/css/main.css" />
</head>
<%
request.setCharacterEncoding("UTF-8");
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
	<!-- Portfolio -->
	<section id="main" class="container">
		<header>
			<h2><p>검색 결과</p></h2>
			<p>　　　　　　　　　　　</p>
		</header>
		<section class="box">
			<div class="row">
				<%
				String search = request.getParameter("search");
				ArrayList<MovieDTO> movieList = new ArrayList<MovieDTO>();
				movieList = new MovieDAO().getList(search);
				if(movieList != null)
					for (MovieDTO movie : movieList) {
				%>
					<div style="padding:50px">
						<section class="box">
							<img src="<%=movie.getMoviePoster()%>" alt="<%=movie.getMoviePoster()%>" style="max-width:200px; max-height:300px; min-width:200px; min-height:300px"/>
							<header>
								<h3><%=movie.getMovieTitle()%>
								</h3>
							</header>
							<p><%=movie.getComeoutDate()%>></p>
						</section>
					</div>
				<%
						}
				%>
			</div>
		</section>
	</section>
</div>
<!-- Scripts -->
<%@ include file="./Fragment/Scripts.jspf" %>
</body>
</html>