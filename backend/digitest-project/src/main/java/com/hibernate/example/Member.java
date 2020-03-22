package com.hibernate.example;

import javax.persistence.*;

@Entity
public class Member {

    @Id
    @GeneratedValue(strategy= GenerationType.AUTO)
    @Column(columnDefinition="INT")
    Integer id;

    @Column(columnDefinition="TEXT")
    String data;

    @Column(columnDefinition="VARCHAR(256)")
    String password;

    @Column(columnDefinition="VARCHAR(20)")
    String status;

    @Column(columnDefinition = "VARCHAR(256)")
    String fcmToken;

    public String getFcmToken() {
        return fcmToken;
    }

    public void setFcmToken(String fcmToken) {
        this.fcmToken = fcmToken;
    }

    public Integer getId() {
        return id;
    }

    public void setId(int id) {
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
