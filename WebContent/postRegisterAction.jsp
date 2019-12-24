<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="post.PostDAO" %>
<%@ page import="post.PostDTO" %>
<%@ page import="user.UserDAO" %>
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
	String movieTitle = null;
	String postTitle = null;
	String postContent = null;
	int movieTotalScore = -1;
	boolean spoiler = false;

	if(request.getParameter("movieTitle") != null) {
		movieTitle = (String) request.getParameter("movieTitle");
	}
	if(request.getParameter("postTitle") != null) {
		postTitle = (String) request.getParameter("postTitle");
	}
	if(request.getParameter("postContent") != null) {
		postContent = (String) request.getParameter("postContent");
	}
	if(request.getParameter("movieTitle") != null) {
		movieTitle = (String) request.getParameter("movieTitle");
	}
	if(request.getParameter("movieTotalScore") != null) {
		movieTotalScore = Integer.parseInt(request.getParameter("movieTotalScore"));
	}
	if(request.getParameter("spoiler") != null) {
		spoiler = true;
	}

	if (movieTitle == null || movieTitle.equals("") || postTitle == null || postTitle.equals("") ||
			postContent == null || postContent.equals("") || movieTotalScore == -1) {
		out.println("<script>");
		out.println("alert('입력이 안 된 사항이 있습니다.');");
		out.println("history.back();");
		out.println("</script>");
		return;
	} else {
		PostDAO postDAO = new PostDAO();
		int result = postDAO.write(new PostDTO(0, userID, movieTitle, postTitle, postContent, movieTotalScore, spoiler, 0));
		if (result == -1) {
			out.println("<script>");
			out.println("alert('리뷰 등록이 실패했습니다.');");
			out.println("history.back();");
			out.println("</script>");
			return;
		} else {
			session.setAttribute("userID", userID);
			out.println("<script>");
			out.println("alert('리뷰가 등록되었습니다.');");
			out.println("location.href = 'post.jsp';");
			out.println("</script>");
			return;
		}
	}
%>