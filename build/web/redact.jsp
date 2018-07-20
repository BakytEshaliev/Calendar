<%-- 
    Document   : redact
    Created on : 03.07.2018, 2:55:32
    Author     : Леван
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Redact</h1>
        <form action="Redact">
            <input type="text" name="title" value="<%= request.getParameter("title") %>" />
            <input type="text" name="discription" value="<%= request.getParameter("discription") %>" />
            <input type="text" name="date" value="<%= request.getParameter("date") %>" />
            <input type="hidden" name="id" value="<%= request.getParameter("id")%>"/>
            <input type="submit" value="Редактировать" />
        </form>
    </body>
</html>
