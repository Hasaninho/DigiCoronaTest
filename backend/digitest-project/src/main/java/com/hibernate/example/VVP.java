package com.hibernate.example;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;

@Entity
public class VVP {

    @Id
    @Column(columnDefinition="CHAR(20)")
    String doknr;
    @Column(columnDefinition="CHAR(8)")
    String ptart;
    @Column(columnDefinition="CHAR(20)")
    String schl;

    public String getPtart() {
        return ptart;
    }

    public void setPtart(String ptart) {
        this.ptart = ptart;
    }

    public String getDoknr() {
        return doknr;
    }

    public void setDoknr(String doknr) {
        this.doknr = doknr;
    }

    public String getSchl() {
        return schl;
    }

    public void setSchl(String schl) {
        this.schl = schl;
    }

}
