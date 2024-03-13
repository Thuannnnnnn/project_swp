<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="java.lang.Boolean" %>
<%
if(session.getAttribute("UserRole") == null){
    response.sendRedirect("login");
    return; 
}
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    </head>
    <body>
        <h1>Your Cart</h1>
        <form action="orderPayment" method="post">
            <table class="table">
                <thead>
                    <tr>
                        <th scope="col">#</th>
                        <th scope="col">Tên Sản Phẩm</th>
                        <th scope="col">Ảnh Sản Phẩm</th>
                        <th scope="col">Giá Sản Phẩm</th>
                        <th scope="col">Quantity</th>
                        <th scope="col">Update</th>
                        <th scope="col">Delete</th>
                        <th scope="col">Select to Buy</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="cart" items="${cartList}" varStatus="i">
                        <tr>
                                 <input type="hidden" name="method" value="cart">
                            <td>${i.count}</td>
                            <td>
                                <c:forEach var="product" items="${ProductList}" varStatus="status">
                                    <c:if test="${cart.product_id == product.product_id}">
                                        ${product.product_name}
                                    </c:if>
                                </c:forEach>
                            </td>
                            <td>
                                <c:forEach var="product" items="${ProductList}" varStatus="status">
                                    <c:if test="${cart.product_id == product.product_id}">
                                        <img src="data:image/png;base64,${product.image_url}" style="width:100px; height:auto;"/>
                                    </c:if>
                                </c:forEach>
                            </td>
                            <td>
                                <c:forEach var="product" items="${ProductList}" varStatus="status">
                                    <c:if test="${cart.product_id == product.product_id}">
                                        <span><fmt:formatNumber value="${product.product_price}"/> VNĐ</span>
                                    </c:if>
                                </c:forEach>
                            </td>
                            <td>${cart.quantity}</td>
                            <td>
                                <form action="cart" method="post">
                                    <input type="hidden" name="method" value="updateQuantity">
                                    <input type="hidden" name="cartId" value="${cart.cart_id}">
                                    <input type="number" name="newQuantity" min="0" value="${cart.quantity}">
                                    <button type="submit" class="btn btn-primary">Update</button>
                                </form>
                            </td>
                            <td>
                                <form action="cart" method="post">
                                    <input type="hidden" name="method" value="delete">
                                    <input type="hidden" name="userId" value="${cart.user_id}">
                                    <input type="hidden" name="productId" value="${cart.product_id}">
                                    <input type="hidden" name="cartId" value="${cart.cart_id}">
                                    <button type="submit" class="btn btn-danger">BUY</button>
                                    <button type="submit" class="btn btn-danger">Delete</button>
                                </form>
                            </td>
                            <td>
                                <input type="checkbox" name="selectedProducts" value="${cart.product_id}">
                            </td>
                        </tr>
                    </c:forEach>


                </tbody>

            </table>
            <span> <input type="checkbox" id="selectAll" onclick="toggleSelectAll(this)"> Chọn Tất Cả </span><br>
            <button type="submit" class="btn btn-primary">Buy Selected Products</button>
        </form>
        <script>
            function toggleSelectAll(source) {
                checkboxes = document.getElementsByName('selectedProducts');
                for (var i = 0, n = checkboxes.length; i < n; i++) {
                    checkboxes[i].checked = source.checked;
                }
            }
        </script>

    </body>
</html>