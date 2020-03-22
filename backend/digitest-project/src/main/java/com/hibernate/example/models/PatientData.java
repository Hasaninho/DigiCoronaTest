package com.hibernate.example.models;

import org.springframework.data.relational.core.sql.In;

public class PatientData {
    private int userId;
    private String status;

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}
