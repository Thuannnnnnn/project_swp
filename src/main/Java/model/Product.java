package model;

import java.util.Date;

public class Product {
    private int product_id;
    private int user_id;
    private String product_name;
    private double product_price;
    private String image_url;
    private int stock_quantity;
    private int category_id;
    private String product_branch;
    private Date dateAdded;
    private int product_count;

    public Product() {
    }

    public Product(int product_id, int user_id, String product_name, double product_price, String image_url, int stock_quantity, int category_id, String product_branch, Date dateAdded, int product_count) {
        this.product_id = product_id;
        this.user_id = user_id;
        this.product_name = product_name;
        this.product_price = product_price;
        this.image_url = image_url;
        this.stock_quantity = stock_quantity;
        this.category_id = category_id;
        this.product_branch = product_branch;
        this.dateAdded = dateAdded;
        this.product_count = product_count;
    }

    public int getProduct_id() {
        return product_id;
    }

    public void setProduct_id(int product_id) {
        this.product_id = product_id;
    }

    public int getUser_id() {
        return user_id;
    }

    public void setUser_id(int user_id) {
        this.user_id = user_id;
    }

    public String getProduct_name() {
        return product_name;
    }

    public void setProduct_name(String product_name) {
        this.product_name = product_name;
    }

    public double getProduct_price() {
        return product_price;
    }

    public void setProduct_price(double product_price) {
        this.product_price = product_price;
    }

    public String getImage_url() {
        return image_url;
    }

    public void setImage_url(String image_url) {
        this.image_url = image_url;
    }

    public int getStock_quantity() {
        return stock_quantity;
    }

    public void setStock_quantity(int stock_quantity) {
        this.stock_quantity = stock_quantity;
    }

    public int getCategory_id() {
        return category_id;
    }

    public void setCategory_id(int category_id) {
        this.category_id = category_id;
    }

    public String getProduct_branch() {
        return product_branch;
    }

    public void setProduct_branch(String product_branch) {
        this.product_branch = product_branch;
    }

    public Date getDateAdded() {
        return dateAdded;
    }

    public void setDateAdded(Date dateAdded) {
        this.dateAdded = dateAdded;
    }

    public int getProduct_count() {
        return product_count;
    }

    public void setProduct_count(int product_count) {
        this.product_count = product_count;
    }
}