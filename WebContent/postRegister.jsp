<%@ page import="movie.MovieDTO" %>
<%@ page import="movie.MovieDAO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
<head>
	<title>게시글 작성</title>
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
		<!-- Form -->
		<section id="main" class="container">
			<section class="box">
				<h3>게시글 작성</h3>
				<p>　　　　　　　　　　　</p>
				<form method="post" action="postRegisterAction.jsp">
					<div class="row gtr-uniform gtr-50">
						<div class="col-12">
							<input type="text" name="postTitle" placeholder="제목" />
						</div>
						<div class="col-12">
							<select name="movieTitle" >
								<option value="">- 영화를 선택해주세요 -</option>
								<%
									ArrayList<MovieDTO> movieList = new ArrayList<MovieDTO>();
									movieList = new MovieDAO().getList("=");
									if(movieList != null)
										for(int i = 0; i < movieList.size(); i++) {
											MovieDTO movie = movieList.get(i);
								%>
								<option value="<%=movie.getMovieTitle()%>"><%=movie.getMovieTitle()%></option>
								<%
										}
								%>
							</select>
						</div>
						<div class="col-12">
							<select name="movieTotalScore" id="movieTotalScore">
								<option value="5">★★★★★</option>
								<option value="4">★★★★</option>
								<option value="3">★★★</option>
								<option value="2">★★</option>
								<option value="1">★</option>
							</select>
						</div>
						<div class="col-6 col-12-narrower">
							<input type="checkbox" id="copy" name="spoiler" value="1">
							<label for="copy">스포일러 포함</label>
						</div>
						<div class="col-12">
							<textarea name="postContent" placeholder="내용을 입력해주세요" rows="6"></textarea>
						</div>
						<div class="col-12">
<%--							<ul class="actions">--%>
							<ul class="actions">
								<li><input type="submit" value="완료"></li>
								<li><input type="reset" value="초기화" class="alt" /></li>
							</ul>
						</div>
					</div>
				</form>
			</section>
		</section>
	</div>
	<!-- Scripts -->
	<%@ include file="./Fragment/Scripts.jspf" %>
</body>
</html>