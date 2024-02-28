/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.User;

import dao.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import model.User;
import org.apache.commons.codec.binary.Hex;

/**
 *
 * @author tranq
 */
@WebServlet(name="login", urlPatterns={"/login"})
public class login extends HttpServlet {


    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet login</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet login at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/LoginPage.jsp").forward(request, response);
    }

    public static boolean verifySHA256(String input, String hashedValueToCompare) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            byte[] digest = md.digest(input.getBytes());
            String hashedValue;
            hashedValue = Hex.encodeHexString(digest);
            System.out.println(hashedValue);
            return hashedValue.equals(hashedValueToCompare);
        } catch (NoSuchAlgorithmException e) {
            return false;
        }
    }

 
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String rememberMe = request.getParameter("rememberMe");
        HttpSession session = request.getSession();
        Cookie Ce = new Cookie("Ce", email);
        Cookie Cp = new Cookie("Cp", password);
        Cookie Cr = new Cookie("Cr", rememberMe);
        System.out.println("remember " + rememberMe);
        
        UserDAO uD = new UserDAO();
        try {
            User u = uD.getUserByEmail(email);

            if (verifySHA256(password, u.getPassword())) {
                System.out.println("Login Success");
               
                session.setAttribute("fullName", u.getFullName());
                session.setAttribute("userId", u.getUserId());
                session.setAttribute("email", u.getEmail());
                session.setAttribute("Address", u.getAddress());
                session.setAttribute("BirthDate", u.getBirthDate());
                session.setAttribute("PhoneNumber", u.getPhoneNumber());
                session.setAttribute("UserRole", u.getUserRole());
                session.setAttribute("Date_Added", u.getDateAdded());
                if (rememberMe != null) {
                    System.out.println("remember not null");
                    Ce.setMaxAge(60 * 60 * 365);
                    Cp.setMaxAge(60 * 60 * 365);
                    Cr.setMaxAge(60 * 60 * 365);
                } else {
                    Ce.setMaxAge(0);
                    Cp.setMaxAge(0);
                    Cr.setMaxAge(0);
                }

                response.addCookie(Ce);
                response.addCookie(Cp);
                response.addCookie(Cr); 
                response.sendRedirect("login?status=ss");
            } else {
                System.out.println("Thông tin đăng nhập không chính xác");
                response.sendRedirect("login?error=invalid");
            }
        } catch (NullPointerException e) {
            // Handle the NullPointerException here
            System.out.println("User with the given email not found or user's password is null.");
            response.sendRedirect("login?error=invalid");
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

}