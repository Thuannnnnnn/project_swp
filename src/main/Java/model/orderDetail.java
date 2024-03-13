/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author tranq
 */
public class orderDetail {
    private int record_id;
    private int quantity;
    private int order_id;
    private int product_id;

    public orderDetail() {
    }

    public orderDetail(int record_id, int quantity, int order_id, int product_id) {
        this.record_id = record_id;
        this.quantity = quantity;
        this.order_id = order_id;
        this.product_id = product_id;
    }

    public orderDetail(int quantity, int order_id, int product_id) {
        this.quantity = quantity;
        this.order_id = order_id;
        this.product_id = product_id;
    }

    public int getRecord_id() {
        return record_id;
    }

    public void setRecord_id(int record_id) {
        this.record_id = record_id;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public int getOrder_id() {
        return order_id;
    }

    public void setOrder_id(int order_id) {
        this.order_id = order_id;
    }

    public int getProduct_id() {
        return product_id;
    }

    public void setProduct_id(int product_id) {
        this.product_id = product_id;
    }
    
}