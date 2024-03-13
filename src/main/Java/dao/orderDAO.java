package dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import model.Order;
import model.orderStatus;

public class orderDAO {

    private Connection connection;
    private Statement statement;
    private ResultSet rs;

    public List<Order> getOrderList() {
        String sql = "select * from Orders";
        List<Order> list = new ArrayList<>();
        try {
            connection = DBConnection.getConnection();
            statement = connection.createStatement();
            rs = statement.executeQuery(sql);
            while (rs.next()) {
                Order o = new Order(rs.getInt("order_id"), rs.getInt("user_id"), rs.getString("delivery_address"),
                        rs.getString("phone_number"),
                        rs.getString("recipient_name"),
                        rs.getString("payment_method"),
                        rs.getInt("status_order_id"),
                        rs.getDate("time_buy")
                );
                list.add(o);
            }
            connection.close();
        } catch (SQLException e) {
            try {
                connection.close();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            e.printStackTrace();
        }

        return list;
    }

    public List<Order> getOrderListById(int userID) {
        String sql = "select * from Orders WHERE user_id = ?";
        List<Order> list = new ArrayList<>();
        try {
            connection = DBConnection.getConnection();
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, userID);
             rs = st.executeQuery();
            while (rs.next()) {
                Order o = new Order(rs.getInt("order_id"), rs.getInt("user_id"), rs.getString("delivery_address"),
                        rs.getString("phone_number"),
                        rs.getString("recipient_name"),
                        rs.getString("payment_method"),
                        rs.getInt("status_order_id"),
                        rs.getDate("time_buy")
                );
                list.add(o);
            }
            connection.close();
        } catch (SQLException e) {
            try {
                connection.close();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            e.printStackTrace();
        }

        return list;
    }

    public List<orderStatus> getOrderStatus() {
        String sql = "select * from order_status";
        List<orderStatus> list = new ArrayList<>();
        try {
            connection = DBConnection.getConnection();
            statement = connection.createStatement();
            rs = statement.executeQuery(sql);
            while (rs.next()) {
                orderStatus o = new orderStatus(rs.getInt("status_order_id"), rs.getString("status_order_name")
                );
                list.add(o);
            }
            connection.close();
        } catch (SQLException e) {
            try {
                connection.close();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            e.printStackTrace();
        }

        return list;
    }

    public int insertOrder(Order order) {
        String sql = "INSERT INTO orders (user_id, delivery_address, phone_number, recipient_name, payment_method,status_order_id) VALUES (?,  ?, ?, ?, ?, ?)";
        // Sử dụng try-with-resources để đảm bảo các tài nguyên được đóng một cách an toàn.
        try (Connection conn = DBConnection.getConnection(); // Cập nhật statement để lấy khóa được tạo tự động.
                 PreparedStatement statement = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            statement.setInt(1, order.getUserID());
            statement.setString(2, order.getDeliveryAddress());
            statement.setString(3, order.getPhoneNumber());
            statement.setString(4, order.getRecipientName());
            statement.setString(5, order.getPaymentMethod());
            statement.setInt(6, order.getStatus_order_id());

            int affectedRows = statement.executeUpdate();

            // Kiểm tra xem có hàng nào được chèn vào hay không.
            if (affectedRows == 0) {
                throw new SQLException("Creating order failed, no rows affected.");
            }

            try (ResultSet generatedKeys = statement.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    // Trả về khóa (id) của bản ghi vừa được chèn vào.
                    return generatedKeys.getInt(1);
                } else {
                    throw new SQLException("Creating order failed, no ID obtained.");
                }
            }
        } catch (SQLException e) {
            System.err.println("Error occurred during the insertOrder operation: " + e.getMessage());
            // Trường hợp xảy ra lỗi, có thể trả về -1 hoặc xử lý theo cách khác phù hợp.
            return -1;
        }
    }

    public Order getOrderByID(int orderId) {
        Order order = null;
        String sql = "SELECT * FROM orders WHERE order_id = ?";
        try {
            connection = DBConnection.getConnection();
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, orderId);
            rs = st.executeQuery();
            if (rs.next()) {
                order = new Order(rs.getInt("order_id"), rs.getInt("user_id"), rs.getString("delivery_address"), rs.getString("phone_number"), rs.getString("recipient_name"), rs.getString("payment_method"), rs.getInt("status_order_id"), rs.getDate("time_buy"));
            }
        } catch (SQLException e) {
            System.out.println("SQL Error: " + e.getMessage());
        }
        return order;

    }

    /**
     *
     * @param orderId
     * @param userId
     * @param address
     * @param phoneNumber
     * @param receiver
     * @param paymentMethod
     * @param price
     * @param createOrderDay
     * @return
     */
    public boolean updateOrder(int orderId, int userId, String address, String phoneNumber, String receiver, String paymentMethod, Date createOrderDay) throws SQLException {
        boolean orderUpdated = false;
        String sql = "UPDATE Orders SET user_id = ?,  delivery_address = ?, phone_number = ?, recipient_name = ?, payment_method = ?, time_buy = ? WHERE order_id = ?;";
        connection = DBConnection.getConnection();
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, userId);
            st.setString(2, address);
            st.setString(3, phoneNumber);
            st.setString(4, receiver);
            st.setString(5, paymentMethod);
            java.sql.Date sqlCreateOrderDay = new java.sql.Date(createOrderDay.getTime());
            st.setDate(6, sqlCreateOrderDay);
            st.setInt(7, orderId);
            orderUpdated = st.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("SQL Error: " + e.getMessage());
            return false;
        }
        return orderUpdated;
    }

    public boolean createOrder(int userId, String address, String phoneNumber, String receiver, String paymentMethod, Date createOrderDay) throws SQLException {
        boolean orderCreated = false;
        String sql = "INSERT INTO Orders (userId, address, phoneNumber, receiver, paymentMethod,createOrderDay) VALUES (?, ?, ?, ?, ?, ?);";
        connection = DBConnection.getConnection();
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, userId);
            st.setString(2, address);
            st.setString(3, phoneNumber);
            st.setString(4, receiver);
            st.setString(5, paymentMethod);

            java.sql.Date sqlCreateOrderDay = new java.sql.Date(createOrderDay.getTime());
            st.setDate(6, sqlCreateOrderDay);
            orderCreated = st.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("SQL Error: " + e.getMessage());
            return false;
        }
        return orderCreated;
    }

    public boolean deleteOrder(int orderId) throws SQLException {
        boolean orderDeleted = false;
        String sql = "DELETE FROM Orders WHERE order_id = ?;";
        connection = DBConnection.getConnection();
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, orderId);

            orderDeleted = st.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("SQL Error: " + e.getMessage());
            return false;
        }
        return orderDeleted;
    }

    public static void main(String[] args) {
        
    }
}