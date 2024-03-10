package dao;



/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import model.orderStatus;
import model.Order;

/**
 *
 * @author TU ANH
 */
public class orderStatusDAO {
    private Connection connection;
    private Statement statement;
    private ResultSet rs;
    public orderStatus getOrderStatusByID(int statusOrderId) {
        orderStatus orderSt = null;
        String sql = "SELECT * FROM order_status WHERE status_order_id = ?";
        try {
            connection = DBConnection.getConnection();
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, statusOrderId);
            rs = st.executeQuery();
            if (rs.next()) {
                orderSt = new orderStatus(rs.getInt("status_order_id"),rs.getString("status_order_name"));
            }
        } catch (SQLException e) {
            System.out.println("SQL Error: " + e.getMessage());
        }
        return orderSt;

    }
    
    public boolean updateOrderStatus(int orderID, String newStatus) throws SQLException {
    boolean statusUpdated = false;
    String sql = "UPDATE Orders JOIN order_status ON Orders.status_order_id = order_status.status_order_id SET status_order_name = ? WHERE Orders.order_id = ?";
    try (Connection connection = DBConnection.getConnection();
         PreparedStatement statement = connection.prepareStatement(sql)) {
        statement.setString(1, newStatus);
        statement.setInt(2, orderID);
        statusUpdated = statement.executeUpdate() > 0;
    } catch (SQLException e) {
        System.out.println("SQL Error: " + e.getMessage());
        throw e;
    }
    return statusUpdated;
}


}




