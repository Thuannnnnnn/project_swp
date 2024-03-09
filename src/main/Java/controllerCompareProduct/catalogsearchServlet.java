/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllerCompareProduct;

import dao.productDescriptionDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.Product;

/**
 *
 * @author THANHVINH
 */
@WebServlet(name = "catalogsearchServlet", urlPatterns = {"/catalogsearchServlet"})
public class catalogsearchServlet extends HttpServlet {
   
    
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
      String resutl = request.getParameter("search");
      String pageString = request.getParameter("page");
      productDescriptionDAO pdModel = new productDescriptionDAO();
      int page = 1;
      if(pageString != null) {
          page = Integer.parseInt(pageString);
      }
      int quantity = pdModel.coutSearch(resutl);
      int pageSize = 12;
      int endPage =  0;
      endPage = (quantity / pageSize);
      if(quantity % pageSize != 0) {
          endPage ++;
      }
      List<Product> p = pdModel.getTop12(resutl, page, pageSize);
      request.setAttribute("result", resutl);
      request.setAttribute("noOfPages", endPage);
      request.setAttribute("products", p);
      request.setAttribute("quantity", quantity);
      request.getRequestDispatcher("catalogsearch.jsp").forward(request, response);
    }

    
   

  
}
