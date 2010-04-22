<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<jsp:useBean id="user" scope="session" class="beans.UserBean"></jsp:useBean>
<%
if (request.getMethod().equals("POST")) {
    java.util.Map<String, String[]> params = request.getParameterMap();
    user.login(params.get("email")[0], params.get("password")[0]);
}
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <c:out value="${!empty param.email ? user.email : ''}"></c:out>
        <c:if test="${user.loggedIn}">
            hello
        </c:if>
        <% if (user.isLoggedIn()) { %>
            Inloggad: <%= user.getFirstName() %>, <a href="logout.jsp">logout</a>.
        <% } else { %>
            <h1>Login</h1>
            <a href="register.jsp">Registrera</a>.
            <form method="POST" action="login.jsp">
                <label for="email">E-mail</label>
                <input type="text" name="email" id="email" />
                <br />
                <label for="password">Password</label>
                <input type="text" name="password" id="password" />
                <input type="submit" value="logg me in" />
            </form>
        <% } %>
    </body>
</html>
