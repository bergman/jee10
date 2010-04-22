<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<jsp:useBean id="user" scope="request" class="beans.UserBean"></jsp:useBean>
<%
if (request.getMethod().equals("POST")) {
    java.util.Map<String, String[]> params = request.getParameterMap();
    user.setEmail(params.get("email")[0]);
    user.setFirstName(params.get("first_name")[0]);
    user.setLastName(params.get("last_name")[0]);
    user.setBalance(0);
    user.setPassword(params.get("password")[0]);
    if (user.db_insert()) {
        response.sendRedirect("login.jsp");
    }
}
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Register</h1>
        <form method="POST" action="register.jsp">
            <label for="email">E-mail</label>
            <input type="text" name="email" id="email" />
            <br />
            <label for="password">Password</label>
            <input type="text" name="password" id="password" />
            <br />
            <label for="first_name">First name</label>
            <input type="text" name="first_name" id="first_name" />
            <br />
            <label for="last_name">Last name</label>
            <input type="text" name="last_name" id="last_name" />
            <br />
            <input type="submit" value="register" />

        </form>
    </body>
</html>
