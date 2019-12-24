<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="freepost.FreePostDTO" %>
<%@ page import="freepost.FreePostDAO" %>
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
	String postTitle = null;
	String postContent = null;
	if(request.getParameter("postTitle") != null) {
		postTitle = (String) request.getParameter("postTitle");
	}
	if(request.getParameter("postContent") != null) {
		postContent = (String) request.getParameter("postContent");
	}
	if (postTitle == null || postTitle.equals("") || postContent == null || postContent.equals("")) {
		out.println("<script>");
		out.println("alert('입력이 안 된 사항이 있습니다.');");
		out.println("history.back();");
		out.println("</script>");
		return;
	} else {
		FreePostDAO freePostDAO = new FreePostDAO();
		int result = freePostDAO.write(new FreePostDTO(0, userID, postTitle, postContent));
		if (result == -1) {
			out.println("<script>");
			out.println("alert('리뷰 등록이 실패했습니다.');");
			out.println("history.back();");
			out.println("</script>");
			return;
		} else {
			session.setAttribute("userID", userID);
			out.println("<script>");
			out.println("alert('게시글이 등록되었습니다.');");
			out.println("location.href = 'freePost.jsp';");
			out.println("</script>");
			return;
		}
	}
%>