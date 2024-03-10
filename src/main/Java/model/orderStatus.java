package model;



/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */



/**
 *
 * @author TU ANH
 */
public class orderStatus {
    private int statusOrderId;
    private String statusOrderName;
    public orderStatus() {
    }

    public orderStatus(int statuOrderId, String statusOrderName) {
        this.statusOrderId = statusOrderId;
        this.statusOrderName = statusOrderName;
    }

    public int getStatuOrderId() {
        return statusOrderId;
    }

    public void setStatuOrderId(int statuOrderId) {
        this.statusOrderId = statuOrderId;
    }

    public String getStatusOrderName() {
        return statusOrderName;
    }

    public void setStatusOrderName(String statusOrderName) {
        this.statusOrderName = statusOrderName;
    }
}