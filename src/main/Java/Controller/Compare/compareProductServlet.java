/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.Compare;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class compareProductServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String id1 = request.getParameter("id1");
        String id2 = request.getParameter("id2");
        String id3 = request.getParameter("id3");

        request.setAttribute("id1", id1);
        request.setAttribute("id2", id2);
        request.setAttribute("id3", id3);
        request.getRequestDispatcher("compareProducts.jsp").forward(request, response);
    }

}
