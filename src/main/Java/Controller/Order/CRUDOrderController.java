/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.Order;

import dao.ProductDAO;
import dao.orderDAO;
import dao.orderDetailDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.Instant;
import model.Order;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;
import model.orderDetail;

/**
 *
 * @author khaye
 */
@WebServlet(name = "editorder", urlPatterns = {"/CRUDOrderController"})
public class CRUDOrderController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet editorder</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet editorder at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String method = request.getParameter("method");
        orderDAO oDAO = new orderDAO();
        System.out.println("method :" + method);
        boolean result = false;
        if (method.equals("create")) {
            String userId = request.getParameter("userId");
            String address = request.getParameter("address");
            String phoneNumber = request.getParameter("phoneNumber");
            String receiver = request.getParameter("receiver");
            String paymentMethod = request.getParameter("paymentMethod");

            String createOrderDay = request.getParameter("createOrderDay");
            int userIdNumber = Integer.parseInt(userId);
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            java.util.Date utilBirthDate = null;

            try {
                utilBirthDate = dateFormat.parse(createOrderDay);
            } catch (ParseException e) {
                // Xử lý lỗi ở đây nếu không thể chuyển đổi ngày sinh từ chuỗi.

            }
            java.sql.Date birthDate = new java.sql.Date(utilBirthDate.getTime());

            try {
                result = oDAO.createOrder(userIdNumber, address, phoneNumber, receiver, paymentMethod, birthDate);
                System.out.println(result);
            } catch (SQLException ex) {
                System.out.println("Error :" + ex.toString());
                result = false;
            }
            System.out.println(result);
            if (result == false) {
                System.out.println("Error");

            } else {
                request.setAttribute("resultEdit", "Tạo đơn hàng thành công");
                request.getRequestDispatcher("orderPage.jsp").forward(request, response);
            }

        }
        if (method.equals("edit")) {
            String orderId = request.getParameter("orderId");
            String userId = request.getParameter("userId");
            String address = request.getParameter("address");
            String phoneNumber = request.getParameter("phoneNumber");
            String receiver = request.getParameter("receiver");
            String paymentMethod = request.getParameter("paymentMethod");

            String createOrderDay = request.getParameter("createOrderDay");
            int orderIdNumber = Integer.parseInt(orderId);
            int userIdNumber = Integer.parseInt(userId);
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            java.util.Date utilBirthDate = null;

            try {
                utilBirthDate = dateFormat.parse(createOrderDay);
            } catch (ParseException e) {
                // Xử lý lỗi ở đây nếu không thể chuyển đổi ngày sinh từ chuỗi.

            }
            java.sql.Date birthDate = new java.sql.Date(utilBirthDate.getTime());

            try {
                result = oDAO.updateOrder(orderIdNumber, userIdNumber, address, phoneNumber, receiver, paymentMethod, birthDate);
                System.out.println(result);
            } catch (SQLException ex) {
                System.out.println("Error :" + ex.toString());
                result = false;
            }
            System.out.println(result);
            if (result == false) {
                System.out.println("Error");

            } else {
                request.setAttribute("resultEdit", "Cập nhật đơn hàng thành công");
                request.getRequestDispatcher("orderPage.jsp").forward(request, response);

            }

        } else if (method.equals("delete")) {
            String orderId = request.getParameter("orderId");
            int orderIdNumber = Integer.parseInt(orderId);
            try {
                result = oDAO.deleteOrder(orderIdNumber);
            } catch (SQLException ex) {
                System.out.println("Error :" + ex.toString());
                result = false;
            }
            if (result == false) {
                System.out.println("Error");

            } else {
                request.setAttribute("resultDelete", "Xóa đơn hàng thành công");
                request.getRequestDispatcher("orderPage.jsp").forward(request, response);

            }
        } else {
            try {

                int userId = Integer.parseInt(request.getParameter("userIdNumber"));
                String deliveryAddress = request.getParameter("address");
                String phoneNumber = request.getParameter("phoneNumber");
                String recipientName = request.getParameter("receiver");
                String paymentMethod = request.getParameter("paymentMethod");
                java.util.Date utilDate = new java.util.Date();
                java.sql.Date sqlDate = new java.sql.Date(utilDate.getTime());

                orderDAO od = new orderDAO();
                int status = 1;
                if (paymentMethod.equals("COD")) {
                    status = 2;
                }
                String[] productIds = request.getParameterValues("productId");
                String[] quantities = request.getParameterValues("quantity");
                Order order = new Order(userId, deliveryAddress, phoneNumber, recipientName, paymentMethod, status, sqlDate);
                int order_id = od.insertOrder(order);
                if (order_id == -1) {
                    response.sendRedirect("cart?error=e");
                } else {

                    System.out.println("orderID = " + order_id);
                    orderDetailDAO d = new orderDetailDAO();
                    for (int i = 0; i < productIds.length; i++) {
                        int productId = Integer.parseInt(productIds[i]);
                        int quantity = Integer.parseInt(quantities[i]);
                        orderDetail oM = new orderDetail(quantity, order_id, productId);
                        if (d.insertOrderDetail(oM)) {
                            response.sendRedirect("/");
                        } else {
                            response.sendRedirect("cart?error=e");
                        }
                    }

                }
            } catch (NumberFormatException e) {
                response.sendRedirect("cart?error=e");
            }
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}