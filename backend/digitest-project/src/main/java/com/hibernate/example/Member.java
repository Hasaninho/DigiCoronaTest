package com.hibernate.example;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;

@Entity
public class Member {

    @Id
    @Column(columnDefinition="INT(9)")
    Integer id;

    @Column(columnDefinition="VARCHAR(512)")
    String data;

    @Column(columnDefinition="VARCHAR(20)")
    String password;

    @Column(columnDefinition="VARCHAR(20)")
    String status;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getData() {
        return data;
    }

    public void setData(String data) {
        this.data = data;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }



}
