<%-- 
    Document   : SignUpPage
    Created on : Jan 30, 2024, 12:37:15 PM
    Author     : tranq
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="css/style.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    </head>
    <body>

        <h1>Sign Up</h1>
        <%-- Server-side code to handle parameters --%>
        <% String method = request.getParameter("method");
           String email = request.getParameter("email");
           String error = request.getParameter("error");
        %>

        <%-- Error messages will be displayed here --%>
        <h3 id="errorMessages" class="text-danger"></h3>

        <%-- Form to enter email and request OTP --%>
        <% if (!"infomation".equals(method) && !"enter".equals(method)) { %>
            <form action="SendOtpServlet" method="get">
                <h3>Enter Email: <input type="text" name="email" required /></h3>
                <input type="hidden" name="feature" value="SignUp"/>
                <input type="submit" value="Verify OTP"/>
            </form>
        <% } %>

        <%-- Form to enter OTP --%>
        <% if ("enter".equals(method)) { %>
            <form action="VerifyOtpServlet" method="post">
                Enter OTP: <input type="text" name="otp" required />
                <input type="hidden" name="email" value="<%= email %>" />
                <input type="hidden" name="feature" value="SignUp"/>
                <input type="submit" value="Verify OTP" />
            </form>
            <form action="SendOtpServlet" method="get">
                <input type="hidden" name="email" value="<%= email %>" />
                <input type="hidden" name="feature" value="SignUp"/>
                <input type="submit" value="Resend OTP"/>
            </form>
        <% } %>

        <%-- Display error messages --%>
        <% if ("exited".equals(error)) { %>
            <h3 class="text-danger">Email Exited</h3>
        <% } else if ("invalidOTP".equals(error)) { %>
            <h3 class="text-danger">OTP invalid or expiry time</h3>
        <% } %>

        <%-- Form to enter user information --%>
        <% if ("infomation".equals(method)) { %>
            <form action="signUp" method="post" class="container mt-10" id="userInformationForm">
                <input type="text" name="fullName" placeholder="Please Enter Full Name" required />
                <input type="date" name="birthdate" id="datePicker" placeholder="Please Enter Birthdate" max="" required />
                <input type="text" name="address" required placeholder="Please Enter Address" />
                <input type="number" name="phoneNumber" required placeholder="Please Enter Phone Number" />
                <input type="password" name="password" required placeholder="Please Enter Password" />
                <input type="hidden" name="email" value="<%= email %>" />
                <input type="hidden" name="userRole" value="customer" />
                <input type="submit" value="Sign Up" />
            </form>
        <% } %>

        <script>
            $(document).ready(function() {
                $("#userInformationForm").submit(function(event) {
                    var phoneNumber = $("input[name='phoneNumber']").val();
                    var password = $("input[name='password']").val();
                    var phoneNumberRegex = /^\d{10}$/;
                    var passwordRegex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[a-zA-Z\d@$!%*?&]{8,}$/;
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