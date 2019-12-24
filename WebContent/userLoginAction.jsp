
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO"%>
<%@ page import="util.SHA256"%>
<%
	request.setCharacterEncoding("UTF-8");
	String userID = null;
	String userPassword = null;
	if(request.getParameter("userID") != null) {
		userID = (String) request.getParameter("userID");
	}
	if(request.getParameter("userPassword") != null) {
		userPassword = (String) request.getParameter("userPassword");
	}
	if (userID == null || userPassword == null) {
		out.println("<script>");
		out.println("alert('입력이 안 된 사항이 있습니다.');");
		out.println("history.back();");
		out.println("</script>");
		out.close();
		return;
	}
	UserDAO userDAO = new UserDAO();
	int result = userDAO.login(userID, SHA256.getSHA256(userPassword));
	if (result == 1) {
		session.setAttribute("userID", userID);
		out.println("<script>");
		out.println("location.href = 'index.jsp';");
		out.println("</script>");
		return;
	} else if (result == 0) {
		out.println("<script>");
		out.println("alert('비밀번호가 일치하지 않습니다.');");
		out.println("history.back();");
		out.println("</script>");
	}else if (result == -1){
		out.println("<script>");
		out.println("alert('존재하지 않는 아이디입니다.');");
		out.println("history.back();");
		out.println("</script>");
		return;
	} else if (result == -2){
		out.println("<script>");
		out.println("alert('데이터베이스 오류가 발생했습니다.');");
		out.println("history.back();");
		out.println("</script>");
		return;
	}
%>