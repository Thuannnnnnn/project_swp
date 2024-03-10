package Controller.Order;


/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
import dao.orderDAO;
import dao.orderStatusDAO;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Order;
import model.orderStatus;

/**
 *
 * @author TU ANH
 */
@WebServlet(name = "orderHistory", urlPatterns = {"/orderHistory"})
public class orderHistory extends HttpServlet {

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
            out.println("<title>Servlet orderHistory</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet orderHistory at " + request.getContextPath() + "</h1>");
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
        HttpSession session = request.getSession();
        int id = -1;
        try {
            id = (int) session.getAttribute("userId");
        } catch (Exception e) {
            response.sendRedirect("LoginPage.jsp");
            return;
        }
        orderDAO od = new orderDAO();
        List<Order> o = od.getOrderByUserID(id);
        request.setAttribute("orderHistory", o);
        orderStatusDAO osDAO = new orderStatusDAO();

        RequestDispatcher r = request.getRequestDispatcher("/orderHistory.jsp");
        r.forward(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String orderIDStr = request.getParameter("orderID");

        if (orderIDStr != null) {
            int orderID = Integer.parseInt(orderIDStr);
            orderStatusDAO osDAO = new orderStatusDAO();

            try {
                boolean updated = osDAO.updateOrderStatus(orderID, "cancel");

                if (updated) {
    response.sendRedirect(request.getContextPath() + "/orderHistory");
                } else {
                    request.setAttribute("error", "C?p nh?t tr?ng thái không thành công.");
                    RequestDispatcher dispatcher = request.getRequestDispatcher("/orderHistory.jsp");
                    dispatcher.forward(request, response);
                }
            } catch (SQLException e) {
                e.printStackTrace();
                request.setAttribute("error", "C?p nh?t tr?ng thái không thành công.");
                RequestDispatcher dispatcher = request.getRequestDispatcher("/orderHistory.jsp");
                dispatcher.forward(request, response);
            }
        } else {
            response.sendRedirect(request.getContextPath() + "/orderHistory");

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
