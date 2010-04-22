<jsp:useBean id="user" scope="session" class="beans.UserBean"></jsp:useBean>
<%
user.logout();
response.sendRedirect("login.jsp");
%>
