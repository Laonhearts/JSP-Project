<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="comment.CommentDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="comment" class="comment.Comment" scope="page"/>
<jsp:setProperty name="comment" property="commentContent" />
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
         script.println("alert('로그인을 하세요')");
         script.println("location.href='login.jsp'");
         script.println("</script>");
      }
          else{
             int bbsID = 0; 
             if (request.getParameter("bbsID") != null){
                bbsID = Integer.parseInt(request.getParameter("bbsID"));
             }
             
             if (bbsID == 0){
                PrintWriter script = response.getWriter();
                script.println("<script>");
                script.println("alert('유효하지 않은 글입니다.')");
                script.println("location.href = 'login.jsp'");
                script.println("</script>");
             }
             if (comment.getCommentContent() == null){
                PrintWriter script = response.getWriter();
                script.println("<script>");
                script.println("alert('입력이 안된 사항이 있습니다.')");
                script.println("history.back()");
                script.println("</script>");
             } else {
                CommentDAO commentDAO = new CommentDAO();
                int result = commentDAO.write(comment.getCommentContent(),userID, bbsID);
                if (result == -1){
                   PrintWriter script = response.getWriter();
                   script.println("<script>");
                   script.println("alert('댓글 쓰기에 실패했습니다.')");
                   script.println("history.back()");
                   script.println("</script>");
                }
                else{
                   PrintWriter script = response.getWriter();
                   script.println("<script>");
                   script.println("location.href=document.referrer;");
                   script.println("</script>");
                }
                
             }
          }
       %>
</body>
</html>