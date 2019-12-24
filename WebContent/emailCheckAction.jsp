<%@page import="util.SHA256"%>
<%@page import="user.UserDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String code = request.getParameter("code");
	UserDAO userDAO = new UserDAO();
	String userID = null;
	if(session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	}
	if(userID == null) {
		out.println("<script>");
		out.println("alert('로그인을 해주세요.');");
		out.println("location.href = 'userLogin.jsp'");
		out.println("</script>");
		return;
	}
	String userEmail = userDAO.getUserEmail(userID);
	boolean rightCode = (new SHA256().getSHA256(userEmail).equals(code)) ? true : false;
	if(rightCode == true) {
		userDAO.setUserEmailChecked(userID);
		out.println("<script>");
		out.println("alert('인증에 성공했습니다.');");
		out.println("location.href = 'index.jsp'");
		out.println("</script>");
		return;
	} else {
		out.println("<script>");
		out.println("alert('유효하지 않은 코드입니다.');");
		out.println("location.href = 'index.jsp'");
		out.println("</script>");
		return;
	}
%>