<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="model.Cart" %>
<%@ page import="model.Product" %>
<%@ page import="java.util.List" %>
<%@page import="java.util.List"%>
<%@page import="java.util.*"%>
<%@page import="dao.cartDAO"%>
<%@page import="Controller.Cart.CRUDCart"%>

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
                <th scope="col">Quantity Cart</th>
                <th scope="col">User Id</th>
                <th scope="col">Product Id</th>
                <th scope="col">Quantity</th>
                <th scope="col">Update</th>
                <th scope="col">Delete</th>
            </tr>
        </thead>

        <tbody>
            <%
                cartDAO cDAO = new cartDAO();
                List<Cart> cartList = cDAO.getCartList();
            
                if (cartList == null || cartList.isEmpty()) {
                      out.println("<p>Hiện tại không có sản phẩm nào trong giỏ hàng.</p>");
                }else {
                for(Cart cart : cartList){
            %>
            <tr>
                <th scope="row"><%= cart.getCartId() %></th>
                <td><%= cart.getQuantityCart() %></td>
                <td><%= cart.getUserId() %></td>
                <td><%= cart.getProductId() %></td>
                <td><%= cart.getQuantity() %></td>
                <td>
                    <form action="cart" method="post">
                        <input type="hidden" name="method" value="updateQuantity">
                        <input type="hidden" name="cartId" value="<%= cart.getCartId() %>">
                        <input type="number" name="newQuantity" min="0" value="<%= cart.getQuantity() %>">
                        <button type="submit" class="btn btn-primary">Update</button>
                    </form>
    </td>

    <td>
        <form action="cart" method="post">
            <input type="hidden" name="method" value="delete">
            <input type="hidden" name="userId" value="<%= cart.getUserId() %>">
            <input type="hidden" name="productId" value="<%= cart.getProductId() %>">
            <input type="hidden" name="cartId" value="<%= cart.getCartId() %>">                       
            <button type="submit" class="btn btn-danger">Delete</button>
        </form>
    </td>
</tr>
<% }}%>


</tbody>


<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js" integrity="sha384-IQsoLXl5PILFhosVNubq5LC7Qb9DXgDA9i+tQ8Zj3iwWAwPtgFTxbJ8NT4GN1R8p" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js" integrity="sha384-cVKIPhGWiC2Al4u+LWgxfKTRIcfu0JTxR+EQDz/bgldoEyl4H0zUF0QKbrJ0EcQF" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
</body>
</html>