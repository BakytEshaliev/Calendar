/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sql;

import java.util.Date;

/**
 *
 * @author Леван
 */
public class Event {
    private final int id;
    private final String title;
    private final String discription;
    private final Date date;
    private final boolean status;

    public boolean isStatus() {
        return status;
    }

    public String getTitle() {
        return title;
    }

    public String getDiscription() {
        return discription;
    }

    public Date getDate() {
        return date;
    }

    public Event(int id,String title, String discription, Date date,boolean status) {
        this.id=id;
        this.title = title;
        this.discription = discription;
        this.date = date;
        this.status=status;
    }

    public int getId() {
        return id;
    }
}
