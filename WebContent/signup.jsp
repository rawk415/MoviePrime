<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
<head>
	<title>회원가입</title>
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
		<!-- Main -->
		<section id="main" class="container medium">
			<header>
				<h2>Sign-Up</h2>
				<p>MoviePrime 계정만들기</p>
			</header>
			<div class="box">
				<form action="./userRegisterAction.jsp" method="post">
					<div class="row gtr-50 gtr-uniform">
						<div class="col-12">
							<input type="text" name="userID" placeholder="회원 ID" />
						</div>
						<div class="col-12">
							<input type="password" name="userPassword" placeholder="비밀번호" />
						</div>
						<div class="col-12">
							<input type="password" name="userPasswordCheck" placeholder="비밀번호 확인" />
						</div>
						<div class="col-12">
							<input type="email" name="userEmail" placeholder="이메일 주소" />
						</div>
						<ul class="actions special">
							<li><input type="submit" value="가입" /></li>
						</ul>
					</div>
				</form>
			</div>
		</section>
	</div>
	<!-- Scripts -->
	<%@ include file="./Fragment/Scripts.jspf" %>
</body>
</html>