package Controller.Dashboard;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
import dao.DashboardDAO;
import dao.ProductDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.Product;

/**
 *
 * @author khaye
 */
@WebServlet(urlPatterns = {"/dashboard"})
public class dashboardController extends HttpServlet {

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
            out.println("<title>Servlet dashboardController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet dashboardController at " + request.getContextPath() + "</h1>");
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
        ProductDAO productDAO = new ProductDAO();
        List<Product> productList = productDAO.getAll();
        request.setAttribute("productList", productList);
        DashboardDAO dashboard = new DashboardDAO();
        int totalUsersNumber = dashboard.getNumberOfUsers();
        int totalNumberOfProducts = dashboard.getNumberOfProducts();
        int totalNumberOfOrders = dashboard.getNumberOfOrders();
        int totalStockQuantityOfProducts = dashboard.getTotalStockQuantityOfProducts();
        int totalProductCount = dashboard.getTotalCountOfAllProducts();
        request.setAttribute("totalUsersNumber", totalUsersNumber);
        request.setAttribute("totalNumberOfProducts", totalNumberOfProducts);
        request.setAttribute("totalNumberOfOrders", totalNumberOfOrders);
        request.setAttribute("totalStockQuantityOfProducts", totalStockQuantityOfProducts);
        request.setAttribute("totalProductCount", totalProductCount);
        int page = 1;
        int pageSize = 8;
        if (request.getParameter("page") != null) {
            page = Integer.parseInt(request.getParameter("page"));
        }
        List<Product> listProduct = productDAO.getAll(page, pageSize);
        int totalProducts = productDAO.getTotalProductsCount();
        int noOfPages = (int) Math.ceil(totalProducts * 1.0 / pageSize);
        request.setAttribute("listProduct", listProduct);
        request.setAttribute("noOfPages", noOfPages);
        request.setAttribute("currentPage", page);
        request.getRequestDispatcher("/dashboardAdmin.jsp").forward(request, response);
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
        processRequest(request, response);
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