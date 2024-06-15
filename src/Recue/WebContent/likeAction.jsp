<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="bbs.Bbs" %>
<%@ page import="user.UserDAO" %>
<%@ page import="bbs.BbsDAO" %>
<%@ page import="likey.LikeyDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Developer Project Board 💻</title>
</head>
<body>
<%
		String userID = null;
		if(session.getAttribute("userID")!=null){
			userID=(String)session.getAttribute("userID");
		}
		if(userID==null){
			PrintWriter script=response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 해주세요.')");
			script.println("location.href='login.jsp'");
			script.println("</script>");
		}
		int bbsID=0;
		if(request.getParameter("bbsID")!=null)
			bbsID=Integer.parseInt(request.getParameter("bbsID"));
		if(bbsID==0){
			PrintWriter script=response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다.')");
			script.println("location.href='bbs.jsp'");
			script.println("</script>");
		}
		BbsDAO bbsDAO = new BbsDAO();
		LikeyDAO likeyDAO = new LikeyDAO();
		int result = likeyDAO.like(userID,bbsID);
		
		if(result == 1){
			result = bbsDAO.like(bbsID);
			if(result == 1){
				PrintWriter script=response.getWriter();
				script.println("<script>");
				script.println("alert('추천이 완료되었습니다.')");
				script.println("location.href= \'view.jsp?bbsID="+bbsID+"\'");
				script.println("</script>");
			} else{
				PrintWriter script=response.getWriter();
				script.println("<script>");
				script.println("alert('데이터베이스 오류가 발생했습니다.')");
				script.println("location.href=document.referrer;");
				script.println("</script>");
			}
		} else{
			PrintWriter script=response.getWriter();
			script.println("<script>");
			script.println("alert('이미 추천을 누른 글입니다.')");
			script.println("location.href='bbs.jsp'");
			script.println("</script>");
		}
	%>
</body>
</html>