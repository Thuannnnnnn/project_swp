<%@ page import="dao.imageDAO" %>
<%@ page import="model.image" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>

<!DOCTYPE html>
<html>
<head>
    <title>Uploaded Images</title>
</head>
<body>
    <h1>Uploaded Images</h1>
    <%
        imageDAO dao = new imageDAO();
        List<image> images = dao.getImgList();
        for (image img : images) {
            out.println("<div>");
            out.println("Product ID: " + img.getProduct_id() + "<br>");
            out.println("<img src=\"data:image/png;base64," + img.getImage_url() + "\" alt=\"Product Image\" style=\"width:200px;height:auto;\"/><br>");
            
            // Form for delete request
            out.println("<form action='DeleteServlet' method='post'>");
            out.println("<input type='hidden' name='image_id' value='" + img.getImage_id() + "'/>");
            out.println("<input type='submit' value='Delete'/>");
            out.println("</form>");

            out.println("</div><br>");
        }
    %>
    <a href="ImageUpload.jsp">Return to Upload Page</a>
</body>
</html>
