<%-- 
    Document   : index
    Created on : 29.06.2018, 20:12:18
    Author     : Леван
--%>
<style text="css">
html{
    font-family: arial, serif;
}
h1{
    display: inline;
    font-size: 16px;
    font-weight: normal;
}
.conteiner{
    background: linear-gradient(to bottom,rgba(97,203,179,0.8),rgba(92,165,149,0.8));
    border: 2px solid #004c3b;
    border-radius: 5px;
}
.menu{
    overflow: hidden;
    border-radius: 5px;
    margin: 7px;
    border: 1px solid #999;
}
.menu_header{
    background: linear-gradient(to bottom, #ffd800, #ffba00);
    padding: 10px 0 11px 11px;
}
#tr{
    width: 0;
    height: 0;
    border: 20px solid transparent;
    border-top: 20px solid #ffba00;
    position: relative;
    right: 95px;
    top:40px;
}
.menu_discription{
    padding: 10px 0 76px 11px;
    background-color: #edecde;
    font-size: 14px;
}
</style>
<%@page import="sql.CodeGenerator"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="sql.Event"%>
<%@page import="java.util.Date"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    ArrayList<Event> events = new ArrayList<>();
    Date currentDate = new Date();//текущая дата,проверяет мероприятие на просроченность
    Calendar c = Calendar.getInstance();
    int weekOfYear;
    int year;
    /*
    *Определение выводимой недели
     */
    if (request.getParameter("week") == null || request.getParameter("year") == null) {
        c.setTime(currentDate);
        weekOfYear = c.get(Calendar.WEEK_OF_YEAR);
        year = c.get(Calendar.YEAR);
    } else {
        weekOfYear = Integer.parseInt(request.getParameter("week"));
        year = Integer.parseInt(request.getParameter("year"));
        c.set(Calendar.YEAR, year);
        c.set(Calendar.WEEK_OF_YEAR, weekOfYear);
    }
    //Вывод мероприятий из БД
    SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    Connection conn = null;
    Class.forName("com.mysql.jdbc.Driver");
    try {
        conn = DriverManager.getConnection("jdbc:mysql://localhost/calendar?" + "user=root&password=1234");
        Statement statement = conn.createStatement();
        String sql = "SELECT id, title, discription, date, status FROM event order by(date)";
        ResultSet rs = statement.executeQuery(sql);
        while (rs.next()) {
            int id = rs.getInt("id");
            String title = rs.getString("title");
            String discription = rs.getString("discription");
            Date date = formatter.parse(rs.getString("date"));
            int statusInt = rs.getInt("status");
            boolean status;
            if (statusInt == 0) {
                status = false;
            } else {
                status = true;
            }
            Event event = new Event(id, title, discription, date, status);
            events.add(event);
        }
    } catch (SQLException ex) {
        System.out.println("SQLException: " + ex.getMessage());
        System.out.println("SQLState: " + ex.getSQLState());
        System.out.println("VendorError: " + ex.getErrorCode());
    } finally {
        conn.close();
    }

%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Ежедневник</title>
    </head>
    <body>
        <h1 align="center"> Ежедневник </h1>
        <p align="center">Год:<%=year%>  Неделя:<%=weekOfYear%></p>
        <form name="Create" action="CreateEvent.jsp">
            <input type="submit" value="Добавить мероприятие" />
        </form>
        <form name="AnotherWeek" action="AnotherWeek.jsp">
            <input type="submit" value="Посмотреть другую неледю">
        </form>
        <form name="NextWeek" action="/Calendar">
            <%
                int previousWeek = weekOfYear - 1;
                int nextYear = year + 1;
                int nextWeek = weekOfYear + 1;
                int previousYear = year - 1;
                if (weekOfYear == 52) {
                    out.println("<input type=\"hidden\" name=\"year\" value=\"" + nextYear + "\">");
                    out.println("<input type=\"hidden\" name=\"week\" value=\"" + 1 + "\">");
                } else {
                    out.println("<input type=\"hidden\" name=\"week\" value=\"" + nextWeek + "\">");
                    out.println("<input type=\"hidden\" name=\"year\" value=\"" + year + "\">");
                }
            %>
            <input type="submit" value="Посмотреть следующую неледю">
        </form>
        <form name="PreviousWeek" action="/Calendar">
            <%if (weekOfYear == 1) {
                    out.println("<input type=\"hidden\" name=\"year\" value=\"" + previousYear + "\">");
                    out.println("<input type=\"hidden\" name=\"week\" value=\"" + 52 + "\">");
                } else {
                    out.println("<input type=\"hidden\" name=\"week\" value=\"" + previousWeek + "\">");
                    out.println("<input type=\"hidden\" name=\"year\" value=\"" + year + "\">");
                }
            %>
            <input type="submit" value="Посмотреть предыдущую неледю">
        </form>
        <%
            c.set(Calendar.DAY_OF_WEEK, 2);
            int dayOfMonth = c.get(Calendar.DATE) - 1;
            int month = c.get(Calendar.MONTH) + 1;
            int maxDateInMonth = c.getActualMaximum(Calendar.DAY_OF_MONTH);
            c.set(Calendar.DAY_OF_WEEK, 2);
        %>
        <h2 align="center">Понедельник<%
            if (dayOfMonth < maxDateInMonth) {
                dayOfMonth++;
            } else {
                dayOfMonth = 1;
                if (month < 12) {
                    month++;
                } else {
                    month = 1;
                }
            }
            out.print("(" + dayOfMonth + "-" + month + ")");
            %> </h2>
            <%      
                CodeGenerator cd=new CodeGenerator();
                ArrayList<String> codeMon=cd.generateEventsCodeByDayOfWeek(events, year, weekOfYear, currentDate, 2);
                for(String code:codeMon){
                    out.println(code);
                }
            %>
        <h2 align="center">Вторник:<%
            if (dayOfMonth < maxDateInMonth) {
                dayOfMonth++;
            } else {
                dayOfMonth = 1;
                if (month < 12) {
                    month++;
                } else {
                    month = 1;
                }
            }
            out.print("(" + dayOfMonth + "-" + month + ")");
            %></h2>
            <%
                ArrayList<String> codeThue=cd.generateEventsCodeByDayOfWeek(events, year, weekOfYear, currentDate, 3);
                for(String code:codeThue){
                    out.println(code);
                }
            %>
        <h2 align="center">Среда:<%
            if (dayOfMonth < maxDateInMonth) {
                dayOfMonth++;
            } else {
                dayOfMonth = 1;
                if (month < 12) {
                    month++;
                } else {
                    month = 1;
                }
            }
            out.print("(" + dayOfMonth + "-" + month + ")");
            %></h2>
            <%
                ArrayList<String> codeWed=cd.generateEventsCodeByDayOfWeek(events, year, weekOfYear, currentDate, 4);
                for(String code:codeWed){
                    out.println(code);
                }
            %>    
        <h2 align="center">Четверг:<%
            if (dayOfMonth < maxDateInMonth) {
                dayOfMonth++;
            } else {
                dayOfMonth = 1;
                if (month < 12) {
                    month++;
                } else {
                    month = 1;
                }
            }
            out.print("(" + dayOfMonth + "-" + month + ")");
            %></h2>
            <%
                ArrayList<String> codeThur=cd.generateEventsCodeByDayOfWeek(events, year, weekOfYear, currentDate, 5);
                for(String code:codeThur){
                    out.println(code);
                }
            %>
        <h2 align="center">Пятница:<%
            if (dayOfMonth < maxDateInMonth) {
                dayOfMonth++;
            } else {
                dayOfMonth = 1;
                if (month < 12) {
                    month++;
                } else {
                    month = 1;
                }
            }
            out.print("(" + dayOfMonth + "-" + month + ")");
            %></h2>
            <%
                ArrayList<String> codeFri=cd.generateEventsCodeByDayOfWeek(events, year, weekOfYear, currentDate, 6);
                for(String code:codeFri){
                    out.println(code);
                }
            %>
        <h2 align="center">Суббота:<%
            if (dayOfMonth < maxDateInMonth) {
                dayOfMonth++;
            } else {
                dayOfMonth = 1;
                if (month < 12) {
                    month++;
                } else {
                    month = 1;
                }
            }
            out.print("(" + dayOfMonth + "-" + month + ")");
            %></h2>
            <%
               ArrayList<String> codeSat=cd.generateEventsCodeByDayOfWeek(events, year, weekOfYear, currentDate, 7);
                for(String code:codeSat){
                    out.println(code);
                }
            %>
        <h2 align="center">Воскресенье:<%
            if (dayOfMonth < maxDateInMonth) {
                dayOfMonth++;
            } else {
                dayOfMonth = 1;
                if (month < 12) {
                    month++;
                } else {
                    month = 1;
                }
            }
            out.print("(" + dayOfMonth + "-" + month + ")");
            %></h2>
            <%
                ArrayList<String> codeSun=cd.generateEventsCodeByDayOfWeek(events, year, weekOfYear, currentDate, 1);
                for(String code:codeSun){
                    out.println(code);
                }            
            %>
    </body>
</html>
