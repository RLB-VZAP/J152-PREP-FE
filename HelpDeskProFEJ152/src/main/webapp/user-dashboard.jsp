<%-- 
    Document   : user-dashboard.jsp
    Created on : Nov 6, 2026, 1:56:50 PM
    Author     : rossb
--%>

<%@page import="com.vzap.helpdeskprofe.model.user.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>User Dashboard</title>
    </head>
    <body>
        <%
            User loggedIn = (User) request.getSession().getAttribute("loggedIn");
            if(loggedIn == null){
        %>
        <h1>Hello World!</h1>
        <%}else{%>
        <h1>Hello <%=loggedIn.getFullName()%>!</h1>
        <form method="post" action="AuthServlet">
            <button type="submit" name="submit" value="logout">Logout</button>
        </form>
        <%}%>
        
    </body>
</html>
