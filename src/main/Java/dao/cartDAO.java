//package dao;
//
//import java.sql.Connection;
//import java.sql.PreparedStatement;
//import java.sql.ResultSet;
//import java.sql.SQLException;
//import java.sql.Statement;
//import java.util.ArrayList;
//import java.util.List;
//import model.Cart;
//import model.Products;
//
//public class cartDAO {
//
//    private Connection connection;
//    private Statement statement;
//    private ResultSet rs;
//
//    public List<Cart> getCartList() {
//        String sql = "select * from Cart";
//        List<Cart> list = new ArrayList<>();
//        try {
//            connection = DBConnection.getConnection();
//            statement = connection.createStatement();
//            rs = statement.executeQuery(sql);
//            while (rs.next()) {
//                Cart c = new Cart(rs.getInt("cart_id"), rs.getInt("quantity_cart"), rs.getInt("user_id"), rs.getString("product_id"), rs.getInt("quantity"));
//                list.add(c);
//            }
//            connection.close();
//        } catch (SQLException e) {
//            try {
//                connection.close();
//            } catch (SQLException e1) {
//                e1.printStackTrace();
//            }
//            e.printStackTrace();
//        }
//
//        return list;
//    }
//
//    public Cart getCartByID(int userId) {
//        Cart cart = null;
//        String sql = "SELECT * FROM Cart WHERE user_id = ?";
//        try {
//            connection = DBConnection.getConnection();
//            PreparedStatement st = connection.prepareStatement(sql);
//            st.setInt(1, userId);
//            rs = st.executeQuery();
//            if (rs.next()) {
//                cart = new Cart(rs.getInt("cart_id"), rs.getInt("quantity_cart"), rs.getInt("user_id"), rs.getString("product_id"), rs.getInt("quantity"));
//            }
//        } catch (SQLException e) {
//            System.out.println("SQL Error: " + e.getMessage());
//        }
//        return cart;
//    }
//
//    public boolean deleteCart(int cartId, int userId, String productId) throws SQLException {
//        boolean cartDeleted = false;
//        String sql = "DELETE FROM Cart WHERE cart_id = ? AND user_id = ? AND product_id = ?";
//        connection = DBConnection.getConnection();
//        try {
//            PreparedStatement st = connection.prepareStatement(sql);
//            st.setInt(1, cartId);
//            st.setInt(2, userId);
//            st.setString(3, productId);
//
//            cartDeleted = st.executeUpdate() > 0;
//        } catch (SQLException e) {
//            System.out.println("SQL Error: " + e.getMessage());
//            return false;
//        } finally {
//            connection.close();
//        }
//        return cartDeleted;
//    }
//
//    public boolean updateCartQuantity(int cartId, int newQuantity) throws SQLException {
//    boolean updated = false;
//    String deleteCartSql = "DELETE FROM Cart WHERE cart_id = ?";
//    String updateCartSql = "UPDATE Cart SET quantity = ? WHERE cart_id = ?";
//    String getStockQuantitySql = "SELECT stock_quantity FROM products WHERE product_id = ?";
//
//    connection = DBConnection.getConnection();
//    try {
//        connection.setAutoCommit(false);
//
//        // Get current quantity in the cart
//        PreparedStatement getCartStatement = connection.prepareStatement("SELECT * FROM Cart WHERE cart_id = ?");
//        getCartStatement.setInt(1, cartId);
//        rs = getCartStatement.executeQuery();
//
//        if (rs.next()) {
//            int userId = rs.getInt("user_id");
//            String productId = rs.getString("product_id");
//
//            // Get stock quantity of the product
//            PreparedStatement getStockQuantityStatement = connection.prepareStatement(getStockQuantitySql);
//            getStockQuantityStatement.setString(1, productId);
//            ResultSet stockQuantityResultSet = getStockQuantityStatement.executeQuery();
//
//            if (stockQuantityResultSet.next()) {
//                int stockQuantity = stockQuantityResultSet.getInt("stock_quantity");
//
//                // Check if the new quantity is within the stock quantity limit
//                if (newQuantity > 0 && newQuantity <= stockQuantity) {
//                    // Update cart quantity
//                    PreparedStatement updateCartStatement = connection.prepareStatement(updateCartSql);
//                    updateCartStatement.setInt(1, newQuantity);
//                    updateCartStatement.setInt(2, cartId);
//
//                    updated = updateCartStatement.executeUpdate() > 0;
//
//                    if (updated) {
//                        connection.commit();
//                    } else {
//                        connection.rollback();
//                    }
//                } else if (newQuantity <= 0) {
//                    // If new quantity is 0 or less, delete the cart
//                    PreparedStatement deleteCartStatement = connection.prepareStatement(deleteCartSql);
//                    deleteCartStatement.setInt(1, cartId);
//
//                    updated = deleteCartStatement.executeUpdate() > 0;
//
//                    if (updated) {
//                        connection.commit();
//                    } else {
//                        connection.rollback();
//                    }
//                }
//            }
//        }
//    } catch (SQLException e) {
//        connection.rollback();
//        e.printStackTrace();
//    } finally {
//        connection.setAutoCommit(true);
//        connection.close();
//    }
//
//    return updated;
//}
//
//}
