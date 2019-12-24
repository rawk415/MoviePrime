<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="post.PostDAO"%>
<%
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
	request.setCharacterEncoding("UTF-8");
	String postID = null;
	if(request.getParameter("postID") != null) {
		postID = (String) request.getParameter("postID");
	}
	PostDAO postDAO = new PostDAO();
	if(userID.equals(postDAO.getUserID(postID))) {
		int result = new PostDAO().delete(postID);
		if (result == 1) {
			session.setAttribute("userID", userID);
			out.println("<script>");
			out.println("alert('삭제가 완료되었습니다.');");
			out.println("location.href='post.jsp'");
			out.println("</script>");
			return;
		} else {
			out.println("<script>");
			out.println("alert('데이터베이스 오류가 발생했습니다.');");
			out.println("history.back();");
			out.println("</script>");
			return;
		}
	} else {
		out.println("<script>");
		out.println("alert('자신이 쓴 글만 삭제 가능합니다.');");
		out.println("history.back();");
		out.println("</script>");
		return;
	}
%>