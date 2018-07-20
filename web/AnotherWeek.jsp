<%-- 
    Document   : AnotherWeek
    Created on : 04.07.2018, 19:09:35
    Author     : Леван
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Another Week</title>
    </head>
    <body>
        <form action="/Calendar">
            <p>Введите год <input type="number" name="year"/></p>
            <p>Введите неделю <input type="number" name="week"/> </p>
            <input type="submit" value="Отправить" />
        </form>
    </body>
</html>
