<%-- 
    Document   : orderHistory
    Created on : Feb 28, 2024, 7:48:43 AM
    Author     : TU ANH
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<%@page import="dao.orderStatusDAO"%>
<%@page import="dao.orderDAO"%>
<%@ page import="model.orderStatus" %>
<%@ page import="model.Order" %>

<%
if(session.getAttribute("UserRole") == null){
    response.sendRedirect("login");
    return; 
}
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=0">        <title>JSP Page</title>
        <link href="styles/orderHis.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
    </head>
    <body>
        <table class="table table-hover">
            <h3>Order History</h3>

            <% 
        String fullname = (String) session.getAttribute("fullName");%>

            <tr>
                <th class="tablet-none">Họ và tên</th>
                <th class="tablet-none">Địa chỉ giao hàng</th>
                <th class="tablet-none">Số điện thoại</th>
                <th class="tablet-none">Tên người nhận</th>
                <th class="tablet-none">Phương thức thanh toán</th>
                <th class="tablet-none">Tổng giá</th>
                <th class="tablet-none">Trạng thái</th>
                <th class="tablet-none">Thời gian đặt hàng</th>
            </tr>

            <c:forEach var="order" items="${orderHistory}" varStatus="status">
                <tr>
                    <td class="tablet-none"><%=fullname%></td>
                    <td class="tablet-none">${order.deliveryAddress}</td>
                    <td class="tablet-none">${order.phoneNumber}</td>
                    <td class="recipient-name"><span class="header-details">Tên người nhận: </span>${order.recipientName}</td>
                    <td class="tablet-none">${order.paymentMethod}</td>
                    <td class="tablet-none">${order.totalPrice}</td>
                    <td class="status-name"><span class="header-details">Trạng thái: </span><span style="text-align: center; padding: 4px;" class="<c:out value="${order.statusOrderName.toLowerCase()}"/>">${order.statusOrderName}</span></td>
                    <td class="tablet-none">${order.timeBuy}</td> 
                    <td class="but-show">
                        <button style="border: none; margin-left: 20px; margin-right: 25px;" class="expand-btn" data-order-id="${order.orderID}">
                            <img style="width: 21px; align-items: center;" src="./img-module/arrow-down.png" alt="alt"/>
                        </button>
                    </td>
                    <td style="border: none;">
                        <c:choose>
                            <c:when test="${order.statusOrderName == 'processing'}">
                                <!-- Thêm một form để gửi yêu cầu POST khi nhấn vào nút -->
                                <form id="cancel-form-${order.orderID}" action="orderHistory" method="post">
                                    <input type="hidden" name="orderID" value="${order.orderID}" />
                                    <button type="submit" class="btn btn-outline-danger cancel-btn" data-order-id="${order.orderID}">
                                        Hủy đơn hàng
                                    </button>
                                </form>
                            </c:when>
                        </c:choose>
                    </td>

                </tr>



                <tr style="margin-bottom: 20px;" id="detail-row-${order.orderID}" class="details-row">
                    <td><span class="header-details">Họ và tên: </span><%=fullname%></td>
                    <td><span class="header-details">Địa chỉ giao hàng: </span>${order.deliveryAddress}</td>
                    <td><span class="header-details">Số điện thoại: </span>${order.phoneNumber}</td>
                    <td><span class="header-details">Phương thức thanh toán: </span>${order.paymentMethod}</td>
                    <td><span class="header-details">Tổng giá: </span>${order.totalPrice}</span></td>
                    <td><span class="header-details">Thời gian đặt hàng: </span>${order.timeBuy}</td> 

                </tr>


            </c:forEach>
        </table>
    </body>
    <script>
        document.addEventListener('DOMContentLoaded', function () {
            var expandBtns = document.querySelectorAll('.expand-btn');
            expandBtns.forEach(function (btn) {
                btn.addEventListener('click', function () {
                    var orderId = this.getAttribute('data-order-id');
                    var detailRow = document.getElementById('detail-row-' + orderId);
                    if (detailRow) {
                        detailRow.classList.toggle('show-details');
                        // Toggle the arrow icon
                        var icon = this.querySelector('img');
                        if (icon) {
                            icon.src = detailRow.classList.contains('show-details') ? './img-module/arrow-up.png' : './img-module/arrow-down.png';
                        }
                    }
                });
            });
        });


    </script>
</html>