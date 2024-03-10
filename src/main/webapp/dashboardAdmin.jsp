<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%
String role = (String) session.getAttribute("UserRole");
if(role == null || !role.trim().equals("admin")){
    response.sendRedirect("loginPage.jsp");
    return;}    
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
        <link href="./styles/toolbarAdmin.css" rel="stylesheet"/>
        <link href="./styles/dashboardCSS.css" rel="stylesheet"/>
          <meta content="width=device-width, initial-scale=1" name="viewport" />
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

    </head>
    <body>
        <div class="wrap-content">
            <div class="left-content">
                <h2 class="title-admin">EndureTale S</h2>
                <ul class="list-controller">
                    <% if(  session.getAttribute("UserRole").equals("admin")) { %>
                    <li class="item-controller active"> Bảng điều khiển</li>
                        <%}%>
                    <a href="/order" class="none-decoration"> <li class="item-controller">Quản lí đơn hàng</li></a>
                    <a href="/CrudProduct" class="none-decoration"> <li class="item-controller">Quản lí sản phẩm</li></a>
                            <% if(session.getAttribute("UserRole").equals("admin")) { %>
                    <a href="/AdminUser" class="none-decoration"><li class="item-controller">Quản lí người dùng</li></a>
                            <%}%>
                </ul>
            </div>
            <div class="right-content">
                <h2 class="title">Bảng điều khiển</h2>
                <div class="content">
                    <div class="content-detail">
                        <div class="box-content yellow">  <h1 class="text-content yellow-text">Tổng số lượng đơn hàng <span>${totalNumberOfOrders}</span> </h1></div>
                        <div class="box-content red"> <h1 class="text-content red-text">Tổng số lượng sản phẩm <span>${totalNumberOfProducts}</span></h1></div>
                    </div>
                    <div class="content-detail">
                        <div class="box-content green"> <h1 class="text-content green-text">Tổng số lượng tổng stock<span>${totalStockQuantityOfProducts}</span> </h1></div>
                        <div class="box-content blue"><h1 class="text-content blue-text">Tổng số lượng người dùng<span>${totalUsersNumber}</span></h1></div>
                    </div>
                </div>

            </div>
        </div>
    </body>
</html>
