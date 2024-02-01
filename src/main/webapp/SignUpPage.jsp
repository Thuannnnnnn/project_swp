<%-- 
    Document   : SignUpPage
    Created on : Jan 30, 2024, 12:37:15 PM
    Author     : tranq
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html> 
<%String method = request.getParameter("method");
String email = request.getParameter("email");
String error = request.getParameter("error");
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="css/style.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
    </head>
    <body>

        <h1>Sign Up</h1>
        <%if(!"infomation".equals(method)&& !"enter".equals(method)){%>
        <form action="SendOtpServlet" method ="get">
            <h3>Enter Email <input type="text" name="email" required/> </h3>
            <input type="hidden" name="feature" value="SignUp"/>
            <input type="submit" value="Verify OTP"/>
        </form>
        <%} else if("enter".equals(method)) {%>
       
        <form action="VerifyOtpServlet" method="post">
            Enter OTP: <input type="text" name="otp" required />
            <input type="submit" value="Verify OTP" />
            <input type= hidden name="email" value="<%= email%>" required/>
            
            <input type="hidden" name="feature" value="SignUp"/>
        </form>
            <form action="SendOtpServlet" method ="get">
            <input type="hidden" name="email" value="<%= email%>" required/>
            <input type="hidden" name="feature" value="SignUp"/>
            <input type="submit" value="ResendOTP"/>
        </form>
        <% }
             if("exited".equals(error)){%>
        <h3 class="text-danger">Email Exited</h3>
        <%}else if ("invalidOTP".equals(error)){%>

        <h3 class="text-danger">OTP invalid or expiry time</h3>

        <%}

        if("infomation".equals(method)){
        %>
        <form action="SignUp" method="post" class="container mt-10">
            <input type =text name="fullName" placeholder="Please Enter Full Name" required/>
            <input type =date name="birthdate" id="datePicker" placeholder="Please Enter Birthdate"  max="" required/>
            <input type =text name="address"required placeholder="Please Enter Address"/>
            <input type =number name="phoneNumber"required placeholder="Please Enter Phone Number"/>
            <input type =password name ="password"required placeholder="Please Enter Password"/>
            <input type= hidden name="email" value="<%= email%>"required/>
            <input type= hidden name="userRole" Value="customer"required/>
            <input type="submit" value="SignUp"/>
        </form>

        <%
            }
        %>
        <script>
            var today = new Date();
            var date = today.getFullYear() + '-' + (today.getMonth() + 1).toString().padStart(2, '0') + '-' + today.getDate().toString().padStart(2, '0');
            document.getElementById('datePicker').setAttribute("max", date);
        </script>
    </body>
</html>
