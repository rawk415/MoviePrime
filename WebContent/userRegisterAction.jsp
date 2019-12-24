<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="user.UserDTO"%>
<%@ page import="user.UserDAO"%>
<%@ page import="util.SHA256"%>
<%
	request.setCharacterEncoding("UTF-8");
	String userID = null;
	if(session.getAttribute("userID") != null) {
		userID = (String)session.getAttribute("userID");
	}
	if(userID != null) {
		out.println("<script>");
		out.println("alert('로그인이 된 상태입니다.');");
		out.println("location.href='index.jsp';");
		out.println("</script>");
		return;
	}
	String userPassword = null;
	String userPasswordCheck = null;
	String userEmail = null;
	if(request.getParameter("userID") != null) {
		userID = (String) request.getParameter("userID");
	}
	if(request.getParameter("userPassword") != null) {
		userPassword = (String) request.getParameter("userPassword");
	}
	if(request.getParameter("userPasswordCheck") != null) {
		userPasswordCheck = (String) request.getParameter("userPasswordCheck");
	}
	if(request.getParameter("userEmail") != null) {
		userEmail = (String) request.getParameter("userEmail");
	}
	if (userID == null || userPassword == null || userEmail == null) {
		out.println("<script>");
		out.println("alert('입력이 안 된 사항이 있습니다.');");
		out.println("history.back();");
		out.println("</script>");
		return;
	} else if (!userPassword.equals(userPasswordCheck)) {
		out.println("<script>");
		out.println("alert('비밀번호가 일치하지 않습니다.');");
		out.println("history.back();");
		out.println("</script>");
	}else {
		UserDAO userDAO = new UserDAO();
		int result = userDAO.join(new UserDTO(userID, SHA256.getSHA256(userPassword), userEmail, SHA256.getSHA256(userEmail), false));
		if (result == -1) {
			out.println("<script>");
			out.println("alert('이미 존재하는 아이디입니다.');");
			out.println("history.back();");
			out.println("</script>");
			return;
		} else {
			session.setAttribute("userID", userID);
			out.println("<script>");
			out.println("location.href = 'emailSendAction.jsp';");
			out.println("</script>");
			return;
		}
	}
%>