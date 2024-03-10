<%-- 
    Document   : oderPayment
    Created on : Mar 10, 2024, 7:48:17 PM
    Author     : Asus
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="java.lang.Boolean" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta content="width=device-width, initial-scale=1" name="viewport" />
        <title>JSP Page</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js" integrity="sha384-IQsoLXl5PILFhosVNubq5LC7Qb9DXgDA9i+tQ8Zj3iwWAwPtgFTxbJ8NT4GN1R8p" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js" integrity="sha384-cVKIPhGWiC2Al4u+LWgxfKTRIcfu0JTxR+EQDz/bgldoEyl4H0zUF0QKbrJ0EcQF" crossorigin="anonymous"></script>
        <link href="./styles/headerCSS.css" rel="stylesheet"/>
        <link href="./styles/home2.css" rel="stylesheet"/>
        <script
            type="module"
            src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"
        ></script>
        <script
            nomodule
            src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"
        ></script>
    </head>
    <body>
        <form action="CRUDOrderController" class="row g-3" method="post">
            <input type="hidden" name="method" value="create">
            <input type="hidden" name="userId" value="<%= session.getAttribute("userId")%>">
            <input type="hidden" name="method" value="create">
            <div class="col-md-6">
                <label name="receiver"" class="form-label">họ và tên</label>
                <input type="text" class="form-control" id="inputEmail4">
            </div>
            <div class="col-md-6">
                <label name="phoneNumber" class="form-label">số điện thoại</label>
                <input type="number" class="form-control" id="inputPassword4">
            </div>
            <div class="col-12">
                <label name="address" class="form-label">địa chỉ</label>
                <input type="text" class="form-control" id="inputAddress" placeholder="1234 Main St">
            </div>

            <div class="col-md-4">
                <label name="paymentMethod" class="form-label">phương thức thanh toán</label>
                <select id="inputState" class="form-select">
                    <option selected>COD</option>
                    <option>Credit Card</option>
                </select>
            </div>

            <div class="col-12">
                <button id="pay" type="submit" class="btn btn-primary">Thanh toán</button>
            </div>


            <!-- Button trigger modal -->
            <div class="col-12"> 
                <button id="modal" type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#exampleModal">
                    Thanh toán
                </button>
            </div>
            <!-- Modal -->
            <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="exampleModalLabel">Modal title</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="container">
                            <div class="modal-body">
                                <img src="./img/QR.jpg" alt="alt" class="img-fluid"/>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                        </div>
                    </div>
                </div>
            </div>

        </form>
        <c:forEach var="product" items="${ProductList}" varStatus="status">
            <form action="creatOrder">
                <h1>${product.product_id}</h1>
                <img src="data:image/png;base64,${product.image_url}"/>
                <span><fmt:formatNumber value="${product.product_price}"/> VNĐ</span>

                <c:forEach var="cartItem" items="${cartItems}" varStatus="status2">
                    <c:if test="${cartItem.product_id == product.product_id}">

                        <h4>Số lượng: ${cartItem.quantity}</h4>
                    </c:if>
                </c:forEach>
            </form>
        </c:forEach>

        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
        <script>
            $(document).ready(function () {
                // Function to update button visibility based on the payment method
                function updateButtonVisibility() {
                    var paymentMethod = $('#inputState').val();
                    if (paymentMethod == 'Credit Card') {
                        // Hide the "Sign in" submit button and show only the modal button for "Credit Card"
                        $('form button[id="pay"]').hide();
                        $('form button[id="modal"]').show();
                    } else {
                        // Show the "Sign in" submit button and hide the modal button for other payment methods
                        $('form button[id="pay"]').show();
                        $('form button[id="modal"]').hide();
                    }
                }

                // Call updateButtonVisibility on page load to set the correct button visibility
                updateButtonVisibility();

                // Event when the payment method selection changes
                $('#inputState').change(function () {
                    updateButtonVisibility();
                });

                // Event when submitting the form
                $('form').on('submit', function (e) {
                    var paymentMethod = $('#inputState').val();
                    if (paymentMethod != 'Credit Card') {
                        // Submit the form if the payment method is not "Credit Card"
                        alert("Form is being submitted");
                    } else {
                        // Show the modal if the payment method is "Credit Card"
                        e.preventDefault(); // Prevent the form from auto-submitting
                        $('#exampleModal').modal('show');
                    }
                });

                // Event when clicking the submit button inside the modal
                $('#exampleModal .btn-primary').click(function () {
                    // Submit the form after clicking submit in the modal
                    $('form').submit();
                });
            });

        </script>

    </body>
</html>
