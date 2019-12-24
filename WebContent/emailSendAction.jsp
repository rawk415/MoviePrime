<%@ page import = "javax.mail.Transport"%>
<%@ page import = "javax.mail.Message"%>
<%@ page import = "javax.mail.Address"%>
<%@ page import = "javax.mail.internet.InternetAddress"%>
<%@ page import = "javax.mail.internet.MimeMessage"%>
<%@ page import = "javax.mail.Session"%>
<%@ page import = "javax.mail.Authenticator"%>
<%@ page import = "java.util.Properties"%>
<%@ page import = "user.UserDAO"%>
<%@ page import = "util.SHA256"%>
<%@ page import = "util.Gmail"%>
<%@ page language = "java" contentType = "text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	UserDAO userDAO = new UserDAO();
	String userID = null;
	if (session.getAttribute("userID") != null) {
		userID = (String)session.getAttribute("userID");
	}
	if (userID == null) {
		out.println("<script>");
		out.println("alert('로그인을 해주세요.');");
		out.println("location.href='userLogin.jsp';");
		out.println("history.back();");
		out.println("</script>");
		return;
	}
	boolean emailChecked = userDAO.getUserEmailChecked(userID);
	if (emailChecked == true) {
		out.println("<script>");
		out.println("alert('이미 인증 된 회원입니다.');");
		out.println("location.href='index.jsp';");
		out.println("</script>");
		return;
	}
	String host = "http://localhost:8090/MoviePrime/";
	String from = "이메일 주소";
	String to = userDAO.getUserEmail(userID);
	String subject = "Movie Prime 가입을 위한 이메일 확인 메일입니다.";
	String content = "다음 링크에 접속하여 이메일 확인을 진행하세요.<p>" + "<a href='" + host + "emailCheckAction.jsp?code="
			+ new SHA256().getSHA256(to) + "'>이메일 인증하기</a>";

	Properties p = new Properties();
	p.put("mail.smtp.user", from);
	p.put("mail.smtp.host", "smtp.googlemail.com");
	p.put("mail.smtp.port", "465");
	p.put("mail.smtp.starttls.enable", "true");
	p.put("mail.smtp.auth", "true");
	p.put("mail.smtp.debug", "true");
	p.put("mail.smtp.socketFactory.port", "465");
	p.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
	p.put("mail.smtp.socketFactory.fallback", "false");
	try {
		Authenticator auth = new Gmail();
		Session ses = Session.getInstance(p, auth);
		ses.setDebug(true);
		MimeMessage msg = new MimeMessage(ses);
		msg.setSubject(subject);
		Address fromAddr = new InternetAddress(from);
		msg.setFrom(fromAddr);
		Address toAddr = new InternetAddress(to);
		msg.addRecipient(Message.RecipientType.TO, toAddr);
		msg.setContent(content, "text/html;charset=UTF-8");
		Transport.send(msg);
		
	} catch (Exception e) {
		e.printStackTrace();
		out.println("<script>");
		out.println("alert('오류가 발생했습니다.');");
		out.println("history.back();");
		out.println("</script>");
		return;
	}
%>
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
	<section id="banner">
		<h4>
			이메일 주소 인증 메일이 전송되었습니다. <p>
			회원가입 시 입력했던 이메일에 들어가셔서 인증해주세요.
		</h4>
	</section>
<%@ include file="./Fragment/Footer.jspf" %>
</body>
</html>

