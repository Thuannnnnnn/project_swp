/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author tranq
 */
public class orderStatus {
    private int  status_order_id;
    private String status_order_name;

    public orderStatus() {
    }

    public orderStatus(int status_order_id, String status_order_name) {
        this.status_order_id = status_order_id;
        this.status_order_name = status_order_name;
    }

    public int getStatus_order_id() {
        return status_order_id;
    }

    public void setStatus_order_id(int status_order_id) {
        this.status_order_id = status_order_id;
    }

    public String getStatus_order_name() {
        return status_order_name;
    }

    public void setStatus_order_name(String status_order_name) {
        this.status_order_name = status_order_name;
    }
    
    
}