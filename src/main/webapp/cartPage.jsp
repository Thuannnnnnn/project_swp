<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
                <th scope="col">Cart Id</th>
                <th scope="col">User Id</th>
                <th scope="col">Product Id</th>
                <th scope="col">Quantity</th>
                <th scope="col">Update</th>
                <th scope="col">Buy</th>
                <th scope="col">Delete</th>
            </tr>
        </thead>

        <tbody>
           <c:forEach var="cart" items="${cartList}" >
                <tr>
                    <th scope="row">${cart.cart_id}</th>
                    <td>${cart.user_id}</td>
                    <td>${cart.product_id}</td>
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
        </tbody>


        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js" integrity="sha384-IQsoLXl5PILFhosVNubq5LC7Qb9DXgDA9i+tQ8Zj3iwWAwPtgFTxbJ8NT4GN1R8p" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js" integrity="sha384-cVKIPhGWiC2Al4u+LWgxfKTRIcfu0JTxR+EQDz/bgldoEyl4H0zUF0QKbrJ0EcQF" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
</body>
</html>