
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%String email = request.getParameter("email");%>
<%String method = request.getParameter("method"); %>
<%String emailExit = request.getParameter("emailExit"); 
String error = request.getParameter("error");%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Password Page</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="css/style.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    </head>
    <body>
        <h1>Fogot Password</h1>
        <h3 id="errorMessages" class="text-danger"></h3>
        <%if(!"enterPassword".equals(method)&& !"enter".equals(method)){%>
        <form action="SendOtpServlet" method ="get">
            <h3>Enter Email <input type="text" name="email" required/> </h3>
            <input type="hidden" name="feature" value="FGPW"/>
            <input type="submit" value="Verify OTP"/>
        </form>
        <%}%>
        <%                
                     if ("enter".equals(method)) {
        %>

        <form action="VerifyOtpServlet" method="post">
            Enter OTP: <input type="text" name="otp" required />
            <input type="submit" value="Verify OTP" />
            <input type="hidden" name="feature" value="FGPW"/>
            <input type= hidden name="email" value="<%= email%>" required/>
        </form>

        <% 
            } 
if("invalidOTP".equals(error)){
        %> <h3 class="text-danger">Otp Invalid</h3>
        <%}
if("enterPassword".equals(method)){%>
        <form action="FogotPassword" method="POST" id="enterPassword">
            <input type="password" name="password" required/>
            <input type="password" name="Repassword" required/>
            <input type="hidden" name="email" value="<%=email%>"required/>
            <input type="submit" value="Change Password"/>
        </form>
        <%}%> <% 
             if("emailNotExit".equals(error)){%>
        <h3 class="text-danger">Email does not Exit</h3>
        <%}%>

        <script>
            $(document).ready(function () {
                $("#enterPassword").submit(function (event) {
                    var password = $("input[name='password']").val();
                    var repassword = $("input[name='Repassword']").val();
                    var passwordRegex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,}$/;
                    var errorMessages = '';
                    console.log(password);
                    console.log(repassword);
                    if (!passwordRegex.test(password)) {
                        console.log("Password must be at least 8 characters long, including uppercase, lowercase, and numbers. </br>");
                        errorMessages += "Password must be at least 8 characters long, including uppercase, lowercase, and numbers. </br>";
                        event.preventDefault();
                    }
                    if (password !== repassword) {
                        console.log("Mật khẩu không khớp. Vui lòng nhập lại.");
                        errorMessages += "Mật khẩu không khớp. Vui lòng nhập lại.";
                        event.preventDefault(); // Ngăn chặn form được gửi nếu mật khẩu không khớp
                    }


                    if (errorMessages.length > 0) {
                        $("#errorMessages").html(errorMessages);
                        event.preventDefault(); // Prevent form submission
                    } else {
                        $("#errorMessages").html(''); // Clear error message
                    }
                });
            });

        </script>

    </body>
</html>