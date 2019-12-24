<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="post.PostDAO"%>
<%@ page import="likey.LikeyDAO"%>
<%!
public static String getClientIP(HttpServletRequest request) {
    String ip = request.getHeader("X-FORWARDED-FOR"); 
    if (ip == null || ip.length() == 0) {
        ip = request.getHeader("Proxy-Client-IP");
    }
    if (ip == null || ip.length() == 0) {
        ip = request.getHeader("WL-Proxy-Client-IP");
    }
    if (ip == null || ip.length() == 0) {
        ip = request.getRemoteAddr() ;
    }
    return ip;
}
%>
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
		postID = (String)request.getParameter("postID");
	}
	PostDAO postDAO = new PostDAO();
	
	if(userID.equals(postDAO.getUserID(postID))){
		out.println("<script>");
		out.println("alert('자신의 글은 추천할 수 없습니다.');");
		out.println("history.back();");
		out.println("</script>");
	}else {
		LikeyDAO likeyDAO = new LikeyDAO();
		int result = likeyDAO.like(userID, postID, getClientIP(request));
		if (result == 1) {
			result = postDAO.like(postID);
			if (result == 1) {
				out.println("<script>");
				out.println("alert('추천이 완료되었습니다.');");
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
			out.println("alert('이미 추천을 누른 글입니다.');");
			out.println("history.back();");
			out.println("</script>");
			return;
		}
	}
%>