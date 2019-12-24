<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Log-in</title>
    <meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
	<link rel="stylesheet" href="assets/css/main.css" />
    <link rel='stylesheet' href='http://codepen.io/assets/libs/fullpage/jquery-ui.css'/>
    <link rel="stylesheet" href="css/style.css" media="screen" type="text/css" />
</head>
<body class="is-preload">
    <div id="page-wrapper">
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
        <section id="main" class="container">
            <section class="box">
                <div class="login-card">
                    <h1>Log-in</h1><br>
                    <form action="./userLoginAction.jsp" method="post">
                        <input type="text" name="userID" placeholder="Username">
                        <input type="password" name="userPassword" placeholder="Password">
                        <input type="submit" name="login" class="login login-submit" value="login">
                    </form>
                    <div class="login-help">
                        <a href="signup.jsp">SignUp</a> 　|  　<a href="#">Forgot Password or ID?</a>
                    </div>
                </div>
            </section>
        </section>
    </div>
	<!-- Scripts -->
    <%@ include file="./Fragment/Scripts.jspf" %>
</body>
</html>