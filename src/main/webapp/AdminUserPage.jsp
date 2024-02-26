<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="java.lang.Boolean" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Danh sách người dùng</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    </head>
    <body>
        <h2>Danh sách người dùng</h2>
        <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addUser">
            Add
        </button>


        <div class="modal fade" id="addUser" tabindex="-1" aria-labelledby="addUser" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="addUser">Add User</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                         <h5 id="errorMessages" class="text-danger"></h5>
                        <form id="userInformationForm" action="SendOtpServlet" method="get" class="container mt-3">
                            
                            <div class="mb-3">
                                <input type="hidden" class="form-control" name="id" placeholder="Please Enter Full Name" value="" required />
                            </div>
                            <div class="mb-3">
                                <input type="text" class="form-control" name="fullName" placeholder="Please Enter Full Name" value="" required />
                            </div>
                            <div class="mb-3">
                                <input type="date" class="form-control" name="birthdate" id="datePicker" placeholder="Please Enter Birthdate" value=""  required />
                            </div>
                            <div class="mb-3">
                                <input type="text" class="form-control" name="address" required placeholder="Please Enter Address" value="" />
                            </div>
                            <div class="mb-3">
                                <input type="number" class="form-control" name="phoneNumber" required placeholder="Please Enter Phone Number" value="}" />
                            </div>
                            <div class="mb-3">
                                <input type="email" class="form-control" name="email" required placeholder="Please Enter Email" value="" />
                            </div>
                            <div class="mb-3">
                                <input type="password" class="form-control" name="password" required placeholder="Please Enter Password" value="" />
                            </div>
                            <input type="hidden" value="add" name="feature"/>


                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                                <input type="submit" class="btn btn-primary" value="SAVE" />
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Enter Otp</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form action="VerifyOtpServlet" method="POST">

                            <input class="form-control" placeholder="Please Check Your Email" name="otp" type="number" value="" required=""/>          
                            <input name="feature" type="hidden" value="add" required=""/>       


                    </div>
                    <div class="modal-footer">
                        <input type="submit" class="btn btn-primary" value="Submit" />
                        <a href="/AdminUser" class="btn btn-danger">Cancel</a>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <table class="table table-hover">
            <tr>

                <th>Full Name</th>
                <th>Birth Date</th>
                <th>Phone Number</th>
                <th>Email</th>
                <th>Address</th>
                <th>Date Added</th>
                <th>User Role</th>
                <th>Action</th>
            </tr>
            <c:forEach var="user" items="${listUsers}" varStatus="status">
                <tr>
                    <td>${user.fullName}</td>
                    <td><fmt:formatDate value="${user.birthDate}" pattern="dd/MM/yyyy"/></td>
                    <td>${user.phoneNumber}</td>
                    <td>${user.email}</td>
                    <td>${user.address}</td>

                    <td><fmt:formatDate value="${user.dateAdded}" pattern="yyyy/MM/dd"/></td>
                    <td>${user.userRole}</td>
                    <td>
                        <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#signupModal${user.userId}">
                            Edit
                        </button>

                        <!-- Modal -->
                        <div class="modal fade" id="signupModal${user.userId}" tabindex="-1" aria-labelledby="signupModalLabel${user.userId}" aria-hidden="true">
                            <div class="modal-dialog">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title" id="signupModalLabel${user.userId}">Edit User</h5>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                    </div>
                                    <div class="modal-body">
                                        <h5 id="errorMessages" class="text-danger"></h5>
                                        <form id="userInformationForm" action="AddEditDeleteUser" method="post" class="container mt-3">
                                                
                                            <div class="mb-3">
                                                <input type="hidden" class="form-control" name="id" placeholder="Please Enter Full Name" value="${user.userId}" required />
                                            </div>
                                            <div class="mb-3">
                                                <input type="text" class="form-control" name="fullName" placeholder="Please Enter Full Name" value="${user.fullName}" required />
                                            </div>
                                            <div class="mb-3">
                                                <input type="date" class="form-control" name="birthdate" id="datePicker" placeholder="Please Enter Birthdate" value="${user.birthDate}"  required />
                                            </div>
                                            <div class="mb-3">
                                                <input type="text" class="form-control" name="address" required placeholder="Please Enter Address" value="${user.address}" />
                                            </div>
                                            <div class="mb-3">
                                                <input type="number" class="form-control" name="phoneNumber" required placeholder="Please Enter Phone Number" value="${user.phoneNumber}" />
                                            </div>
                                            <div class="mb-3">
                                                <input type="email" class="form-control" name="email" required placeholder="Please Enter email" value="${user.email}" />
                                            </div>
                                            <input type="hidden" value="edit" name="method"/>


                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                                                <input type="submit" class="btn btn-primary" value="SAVE" />
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>

                    </td>
                    <td>
                        <button type="button" class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#DeleteModal${user.userId}">
                            Delete
                        </button>

                        <!-- Modal -->
                        <div class="modal fade" id="DeleteModal${user.userId}" tabindex="-1" aria-labelledby="DeleteModalLabel${user.userId}" aria-hidden="true">
                            <div class="modal-dialog">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title" id="DeleteModalLabel${user.userId}">Delete User</h5>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                    </div>
                                    <div class="modal-body">
                                        <h3>Are You Sure Delete This User</h3>
                                        <form  action="AddEditDeleteUser" method="POST">
                                            <input type="hidden" value="${user.userId}" name="id"/>
                                            <input type="hidden" value="delete" name="method"/>
                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                                                <input type="submit" class="btn btn-danger" value="Delete" />
                                            </div>

                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </td>
                </tr>
            </c:forEach>

        </table>
        <script>
            // Đợi cho đến khi toàn bộ DOM được tải
            document.addEventListener("DOMContentLoaded", function () {
                // Lấy nút mở modal và modal
                var openModalButton = document.getElementById('openModalButton');
                var myModal = new bootstrap.Modal(document.getElementById('exampleModal'), {
                    keyboard: true // Cho phép đóng modal bằng phím Esc
                });

                // Thêm sự kiện click cho nút để mở modal
                openModalButton.addEventListener('click', function () {
                    myModal.show();
                });
            });

            document.addEventListener('DOMContentLoaded', (event) => {
                // Hàm này giúp lấy giá trị của một tham số từ URL
                function getQueryParam(param) {
                    const urlParams = new URLSearchParams(window.location.search);
                    return urlParams.get(param);
                }

                // Kiểm tra xem tham số 'method' có phải là 'add' hay không
                if (getQueryParam('method') === 'add') {
                    // Sử dụng jQuery để mở modal
                    $('#exampleModal').modal('show');

                    // Nếu bạn không sử dụng jQuery, bạn có thể thay thế dòng trên bằng vanilla JS:
                    // new bootstrap.Modal(document.getElementById('exampleModal')).show();
                }
            });
            $(document).ready(function () {
                $("#userInformationForm").submit(function (event) {
                    var phoneNumber = $("input[name='phoneNumber']").val();
                    var password = $("input[name='password']").val();
                    var phoneNumberRegex = /^\d{10}$/;
                    var passwordRegex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,}$/;
                    var errorMessage = '';

                    if (!phoneNumberRegex.test(phoneNumber)) {
                        errorMessage += "Phone number must be 10 digits and start by 0.<br>";
                    }

                    if (!passwordRegex.test(password)) {
                        errorMessage += "Password must be at least 8 characters long, including uppercase, lowercase, and numbers.";
                    }

                    if (errorMessage.length > 0) {
                        $("#errorMessages").html(errorMessage);
                        event.preventDefault(); // Prevent form submission
                    } else {
                        $("#errorMessages").html(''); // Clear error message
                    }
                });
            });

            var today = new Date();
            var date = '2012-12-31';
            document.getElementById('datePicker').setAttribute("max", date);
        </script>

    </body>
</html>
