<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
    <head>
        <title>Danh sách người dùng</title>
    </head>
    <body>
        <h2>Danh sách người dùng</h2>
        <table border="1">
            <tr>
                <th>ID</th>
                <th>Họ và tên</th>
                <th>Email</th>
                <th>phone</th>
                <!-- Thêm các cột khác nếu cần -->
            </tr>
            <c:forEach var="user" items="${users}">
                <tr>
                    <td>${user.userId}</td>
                    <td>${user.fullName}</td>
                    <td>${user.email}</td>
                    <td>${user.phoneNumber}</td>
                    <!-- Hiển thị các trường khác của người dùng nếu cần -->
                </tr>
            </c:forEach>
        </table>
    </body>
</html>
