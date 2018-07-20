/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sql;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;

/**
 *
 * @author Леван
 */
public class CodeGenerator {

    public ArrayList<String> generateEventsCodeByDayOfWeek(ArrayList<Event> events, int year, int weekOfYear, Date currentDate, int dayOfWeek) {
        ArrayList<String> code = new ArrayList<>();
        for (Event event : events) {
            Calendar cEvent = Calendar.getInstance();
            Date eventDate = event.getDate();
            cEvent.setTime(eventDate);
            SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            String dateStr = formatter.format(eventDate);
            String[] dateMass = dateStr.split(" ");
            String dateTime = dateMass[1];
            int dayOfWeekEvent = cEvent.get(Calendar.DAY_OF_WEEK);
            int weekOfYearEvent = cEvent.get(Calendar.WEEK_OF_YEAR);
            int yearEvent = cEvent.get(Calendar.YEAR);
            if (year == yearEvent) {//проверка года мероприятия
                if (weekOfYear == weekOfYearEvent) {//проверка недели Мероприятия
                    if (dayOfWeekEvent == dayOfWeek) {//проверка дня недели
                        code.add("<div class=\"container\">");
                        code.add("<div class=\"menu\">");
                        code.add("<div class=\"menu_header\">");
                        code.add("<big>" + event.getTitle() + "-" + dateTime);
                        if (event.isStatus()) {//проверка состояния
                            code.add("(Сделано)");
                        } else {
                            if (currentDate.after(eventDate)) {
                                code.add("(Просроченно)");
                            }

                            code.add("<form name=\"Done\" action=\"Done\" >");
                            code.add("<input type=\"hidden\" name=\"status\" value=\"1\" />");
                            code.add("<input type=\"hidden\" name=\"id\" value=\"" + event.getId() + "\" />");
                            code.add("<input type =\"submit\" value=\"Пометить как сделанное\" />");
                            code.add("</form>");

                        }
                        code.add("<form name=\"Delete\" action=\"Delete\">");
                        code.add("<input type =\"hidden\" name=\"id\" value=\"" + event.getId() + "\"/>");
                        code.add("<input  type = \"submit\" value = \"Удалить\" />");
                        code.add("</form>");

                        code.add("<form  name = \"Redact\" action = \"redact.jsp\" >");
                        code.add("<input type =\"hidden\" name=\"title\" value=\"" + event.getTitle() + "\"/>");
                        code.add("<input type =\"hidden\" name=\"discription\" value=\"" + event.getDiscription() + "\"/>");
                        code.add("<input type =\"hidden\" name=\"date\" value=\"" + dateStr + "\"/>");
                        code.add("<input type =\"hidden\" name=\"id\" value=\"" + event.getId() + "\"/>");
                        code.add("<input  type = \"submit\" value = \"Редактировать\" />");
                        code.add("</form>");
                        code.add("</big>");
                        code.add("<span id=\"tr\"></span>");
                        code.add("</div>");

                        code.add("<div class=\"menu_discription\">");
                        code.add("<h4>" + event.getDiscription() + "</h4>");
                        code.add("</div>");
                        code.add("</div>");
                        code.add("</div>");
                    }
                }
            }

        }
        return code;
    }
}
//<div class="conteiner">
//       <div class="menu">
//           <div class="menu_header">
//               <h1>Заголовок</h1>
//              <span id="tr"></span>
//          </div>
//          <div class="menu_soderzhanie">
//              Содержание
//          </div>
//      </div>
  //  </div>
