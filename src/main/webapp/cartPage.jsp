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
        <table class="table">
            <h9 style="color:red; ">${requestScope.resultUpdate}</h9>
            <tr>

                <th scope="col">Tên Sản Phẩm</th>
                <th scope="col">Ảnh Sản Phẩm</th>
                <th scope="col">Giá Sản Phẩm</th>
                <th scope="col">Quantity</th>
                <th scope="col">Update</th>
                <th scope="col">Buy</th>
                <th scope="col">Delete</th>
                <th> Buy </th>
            </tr>
        </thead>

        <tbody>
            <c:forEach var="cart" items="${cartList}" >
                <tr>
                    <td> <c:forEach var="product" items="${ProductList}" varStatus="status">
                            <c:if test="${cart.product_id == product.product_id}">
                                ${product.product_name}
                            </c:if>
                        </c:forEach></td>
                    <td>  <c:forEach var="product" items="${ProductList}" varStatus="status">
                            <c:if test="${cart.product_id == product.product_id}">
                                <img src="data:image/png;base64,${product.image_url}"/>
                            </c:if>
                        </c:forEach></td>
                    <td>  <c:forEach var="product" items="${ProductList}" varStatus="status">
                            <c:if test="${cart.product_id == product.product_id}">
                                <span>
                                    <fmt:formatNumber value="${product.product_price * cart.quantity}"/> VNĐ
                                </span>
                            </c:if>
                        </c:forEach></td>

                    <td>${cart.quantity}</td>
                    <td>
                        <form action="addcart" method="post">
                            <input type="hidden" name="method" value="updateQuantity">
                            <input type="hidden" name="cartId" value="${cart.cart_id}">
                            <input type="number" name="newQuantity" min="0" value="${cart.quantity}">
                            <button type="submit" class="btn btn-primary">Update</button>
                        </form>
                    </td>
                    <td>
                        <form action="CRUDCart" method="post">
                            <input type="hidden" name="method" value="delete">
                            <input type="hidden" name="userId" value="${cart.user_id}">
                            <input type="hidden" name="productId" value="${cart.product_id}">
                            <input type="hidden" name="cartId" value="${cart.cart_id}">
                            <button type="submit" class="btn btn-danger">BUY</button>
                            <button type="submit" class="btn btn-danger">Delete</button>
                        </form>
                    </td>

                </tr>

            </c:forEach>
        <a href="orderPayment" class="btn btn-primary">Buy</a>
    </tbody>


    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js" integrity="sha384-IQsoLXl5PILFhosVNubq5LC7Qb9DXgDA9i+tQ8Zj3iwWAwPtgFTxbJ8NT4GN1R8p" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js" integrity="sha384-cVKIPhGWiC2Al4u+LWgxfKTRIcfu0JTxR+EQDz/bgldoEyl4H0zUF0QKbrJ0EcQF" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
</body>
</html>