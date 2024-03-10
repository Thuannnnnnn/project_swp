/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author khaye
 */
public class DashboardDAO {

    public int getNumberOfUsers() {
        int count = 0;
        String sql = "SELECT COUNT(*) AS total FROM users";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql); ResultSet rs = pstmt.executeQuery()) {

            if (rs.next()) {
                count = rs.getInt("total");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return count;
    }

    public int getNumberOfProducts() {
        int count = 0;
        String sql = "SELECT COUNT(*) AS total FROM products";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql); ResultSet rs = pstmt.executeQuery()) {

            if (rs.next()) {
                count = rs.getInt("total");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return count;
    }

    public int getNumberOfOrders() {
        int count = 0;
        String sql = "SELECT COUNT(*) AS total FROM orders";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql); ResultSet rs = pstmt.executeQuery()) {

            if (rs.next()) {
                count = rs.getInt("total");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return count;
    }

    public int getTotalStockQuantityOfProducts() {
        int totalStockQuantity = 0;
        String sql = "SELECT SUM(stock_quantity) AS total_stock_quantity FROM products";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql); ResultSet rs = pstmt.executeQuery()) {

            if (rs.next()) {
                totalStockQuantity = rs.getInt("total_stock_quantity");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return totalStockQuantity;
    }

}
