/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.Cart;

import dao.ProductDAO;
import dao.cartDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Cart;
import model.Product;

/**
 *
 * @author Asus
 */
@WebServlet(name = "addCart", urlPatterns = {"/addCart"})
public class addCart extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String productId = request.getParameter("productId");
        String quantityStr = request.getParameter("quantity");

        System.out.println(quantityStr);

        int quantity = 0;
        try {
            quantity = Integer.parseInt(quantityStr);
            System.out.println(quantity);
        } catch (NumberFormatException e) {
            e.printStackTrace();
            return;
        }

        cartDAO cart = new cartDAO();

        HttpSession session = request.getSession();
        int userId = (int) session.getAttribute("userId");
        System.out.println(userId);

        Cart existingCart = cart.findCartByUserIdAndProductId(userId, Integer.parseInt(productId));

        if (existingCart != null) {

            int newQuantity = existingCart.getQuantity() + quantity;
            existingCart.setQuantity(newQuantity);
            Cart cart1 = cart.findCartByUserIdAndProductId(userId, Integer.parseInt(productId));
            int cartId = cart1.getCart_id();
            try {
                cart.updateCartQuantity(cartId, newQuantity);
                response.sendRedirect("cart"); 
            } catch (SQLException ex) {

                Logger.getLogger(addCart.class.getName()).log(Level.SEVERE, null, ex);
                response.sendRedirect("cart?e=erorr");
            }

        } else {
            // Product is not in the cart, add a new entry
            Cart newCart = new Cart(userId, Integer.parseInt(productId), Integer.parseInt(quantityStr));

            try {
                if (cart.insertCart(newCart)) {
                    response.sendRedirect("cart");
                } else {
                    System.out.println("errorr");
                    response.sendRedirect("cart?e=erorr");
                }
            } catch (SQLException ex) {
                Logger.getLogger(addCart.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
