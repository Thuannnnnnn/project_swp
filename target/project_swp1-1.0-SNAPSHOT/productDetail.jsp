<%-- 
    Document   : Description
    Created on : Jan 31, 2024, 7:19:08 AM
    Author     : THANHVINH
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Products"%>  
<%@page import="java.sql.ResultSet"%>
<%@page import="dao.productDescriptionDAO"%>  
<%@page import="java.util.List"%> 
<%@page import="model.productDescription"%>  
<%
if(session.getAttribute("UserRole") == null){
    response.sendRedirect("login");
    return; 
}
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Description page</title>
    </head>
    <style>
        /*accordion*/
        .accordion {
            background-color: #eee;
            color: #444;
            cursor: pointer;
            padding: 18px;
            width: 100%;
            border: none;
            text-align: left;
            outline: none;
            font-size: 15px;
            transition: 0.4s;
        }

        .active, .accordion:hover {
            background-color: #ccc;
        }

        .panel {
            padding: 0 18px;
            background-color: white;
            max-height: 0;
            overflow: hidden;
            transition: max-height 0.2s ease-out;
        }
        /* modal*/
        .modal {
            display: none;
            position: fixed;
            z-index: 1;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgb(0,0,0);
            background-color: rgba(0,0,0,0.4);
        }


        .modal-content {
            background-color: #fefefe;
            margin: 15% auto;
            padding: 20px;
            border: 1px solid #888;
            width: 80%;
        }


        .close {
            color: #aaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
        }

        .close:hover,
        .close:focus {
            color: black;
            text-decoration: none;
            cursor: pointer;
        }
    </style>
    <body>
        <%
            String productId = request.getParameter("id");
            productDescriptionDAO pdModel = new productDescriptionDAO();

            List<productDescription> pd = pdModel.getAllProductDescription();
            List<Products> p = pdModel.getProduct();
        %>  
        <button id="myBtn">So sánh</button>
        <div id="myModal" class="modal">
            <div class="modal-content">
                <span class="close">&times;</span>
                <%
                    for (int i = 0; i < p.size(); i++) {
                        if (!p.get(i).getProductId().equals(productId)) {
                %>

                <a>
                    <img src="<%= p.get(i).getImageUrl()%>" style="width: 200px; height: 200px;">
                </a>

                <form id="productForm" action="compareProductServlet" method="get">
                    <input type="hidden"  name="id1" value="<%= p.get(i).getProductId()%>">
                    <input type="hidden"  name="id2" value="<%=productId%>">
                    <button type="submit">So sánh sản phẩm</button>
                </form>
                <%
                        }
                    }%>

            </div>

        </div>




        <%
            for (Products product : p) {
                if (product.getProductId().equals(productId)) {
        %>
        <img  id="thirdProductImage" src="<%= product.getImageUrl()%>" style="width: 200px; height: 200px  ;">
        <%
                }
            }
        %>


    </div>

</body>
<script>
    var modal = document.getElementById("myModal");

    var btn = document.getElementById("myBtn");

    var span = document.getElementsByClassName("close")[0];

    btn.onclick = function () {
        modal.style.display = "block";
    };

    span.onclick = function () {
        modal.style.display = "none";
    };

    window.onclick = function (event) {
        if (event.target === modal) {
            modal.style.display = "none";
        }
    };

    var acc = document.getElementsByClassName("accordion");
    var i;

    for (i = 0; i < acc.length; i++) {
        acc[i].addEventListener("click", function () {
            this.classList.toggle("active");
            var panel = this.nextElementSibling;
            if (panel.style.maxHeight) {
                panel.style.maxHeight = null;
            } else {
                panel.style.maxHeight = panel.scrollHeight + "px";
            }
        });
    }


</script>
</html>
