<%-- 
    Document   : adminSetting
    Created on : Mar 6, 2024, 9:40:21 PM
    Author     : Asus
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>

        <h1> Logo</h1>
        <br>
        <table border="1">
            <tr>
                <th>Image Preview</th>
                <th>Actions</th>
            </tr>
            <tr>
                
                <td>
                    <img src="data:image/jpeg;base64,${requestScope.imagelogo}" alt="Image" style="width: 100px; height: auto;">
                </td>
                <td>
                    <a href="editLogo.jsp?id=2">Edit</a>
                </td>
            </tr>
        </table>



        <h1> Slider</h1>
        <br>
        <table border="1">
            <tr>
                <th>Image Preview</th>
                <th>Actions</th>
            </tr>
            <c:forEach items="${images}" var="img">
                <tr>
                    <td>
                        <img src="data:image/jpeg;base64,${img.image_url}" alt="Image" style="width: 100px; height: auto;">
                    </td>
                    <td>
                        <form action="admin-setting" method="post">
                            <input type="hidden" name="image_id" value="${img.image_id}">
                            <input type="submit" value="Delete" onclick="return confirm('Are you sure?');">
                        </form>
                        <a href="EditSlider.jsp?id=${img.image_id}">Edit</a>
                    </td>
                </tr>
            </c:forEach>
        </table>



    </body>
</html>