<%-- 
    Document   : CreateEvent
    Created on : 03.07.2018, 2:47:46
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
        <h1>Create Event</h1>
        <form name="Create event" action="CreateEvent">
            <p>Введите название<input type="text" name="title" value="" /></p>
            <p>Введите описание<input type="text" name="discription" value="" /></p>
                <p>Введите дату в формате yyyy-mm-dd hh:mm:ss<input type="text" name="date" value="" /></p>
            <input type="submit" value="Добавить" />
            
        </form>
    </body>
</html>
