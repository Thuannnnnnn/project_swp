package model;


import java.sql.Date;


public class Products {
    private String productId;
    private String productName;
    private double productPrice;
    private String imageUrl;
    private int stockQuantity;
    private int categoryId;
    private String productBranch;
    private Date dateAdded;

    public Products(String productId, String productName, double productPrice, String imageUrl, int stockQuantity, int categoryId, String productBranch, Date dateAdded) {
        this.productId = productId;
        this.productName = productName;
        this.productPrice = productPrice;
        this.imageUrl = imageUrl;
        this.stockQuantity = stockQuantity;
        this.categoryId = categoryId;
        this.productBranch = productBranch;
        this.dateAdded = dateAdded;
    }

    // Getters and Setters for all fields

    public String getProductId() {
        return productId;
    }

    public void setProductId(String productId) {
        this.productId = productId;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public double getProductPrice() {
        return productPrice;
    }

    public void setProductPrice(double productPrice) {
        this.productPrice = productPrice;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public int getStockQuantity() {
        return stockQuantity;
    }

    public void setStockQuantity(int stockQuantity) {
        this.stockQuantity = stockQuantity;
    }

    public int getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }

    public String getProductBranch() {
        return productBranch;
    }

    public void setProductBranch(String productBranch) {
        this.productBranch = productBranch;
    }

    public Date getDateAdded() {
        return dateAdded;
    }

    public void setDateAdded(Date dateAdded) {
        this.dateAdded = dateAdded;
    }
}
