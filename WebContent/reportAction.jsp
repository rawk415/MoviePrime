<%@ page import="javax.mail.Transport"%>
<%@ page import="javax.mail.Message"%>
<%@ page import="javax.mail.Address"%>
<%@ page import="javax.mail.internet.InternetAddress"%>
<%@ page import="javax.mail.internet.MimeMessage"%>
<%@ page import="javax.mail.Session"%>
<%@ page import="javax.mail.Authenticator"%>
<%@ page import="java.util.Properties"%>
<%@ page import="util.Gmail"%>
<%@ page import="user.UserDAO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
<%
	request.setCharacterEncoding("UTF-8");
	String reportTitle = null;
	String reportContent = null;
	if (request.getParameter("reportTitle") != null) {
		reportTitle = request.getParameter("reportTitle");
	}
	if (request.getParameter("reportContent") != null) {
		reportContent = request.getParameter("reportContent");
	}
	if(reportTitle == null || reportContent == null) {
		out.println("<script>");
		out.println("alert('입력이 안 된 사항이 있습니다.');");
		out.println("history.back();");
		out.println("</script>");
		return;
	}
	UserDAO userDAO = new UserDAO();
	String host = "http://localhost:8087/MoviePrime/";
	String from = "이메일 주소";
	String to = userDAO.getUserEmail(userID);
	String subject = "Movie Prime 에서 문의한 메일입니다.";
	String content = "사용자: " + userID +
					 "<br>제목: " + reportTitle +
					 "<br>내용: " + reportContent;
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
	out.println("<script>");
	out.println("alert('정상적으로 신고되었습니다.');");
	out.println("location.href = 'index.jsp';");
	out.println("</script>");
%>

