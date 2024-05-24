<%-- 
    Document   : home
    Created on : Apr 27, 2024, 4:04:06 PM
    Author     : PC
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="model.User" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="description" content="Male_Fashion Template">
        <meta name="keywords" content="Male_Fashion, unica, creative, html">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
        <title>Male-Fashion | Template</title>

        <!-- Google Font -->
        <link href="https://fonts.googleapis.com/css2?family=Nunito+Sans:wght@300;400;600;700;800;900&display=swap"
              rel="stylesheet">

        <!-- Css Styles -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
        <link rel="stylesheet" href="//use.fontawesome.com/releases/v5.0.7/css/all.css">
        <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
        <link rel="stylesheet" href="css/owl.carousel.min.css" type="text/css">
        <link rel="stylesheet" href="css/slicknav.min.css" type="text/css">
        <link rel="stylesheet" href="css/style.css" type="text/css">
        <link rel="stylesheet" href="css/client/register.css" type="text/css">

    </head>

    <body>
        <%
         String status = (String) request.getAttribute("success-register");
        if (status != null) {
        %>
        <script>
            swal("Congrats", "Tạo tài khoản thành công", "success");
        </script>
        <%
            }          
        %>
        <%
            User user = (User)session.getAttribute("acc");
            String ten = "";
            if(user != null){
                ten = user.getUsername();
            }
             
        %>
        <!-- Page Preloder -->
        <div id="preloder">
            <div class="loader"></div>
        </div>

        <!-- Offcanvas Menu Begin -->
        <div class="offcanvas-menu-overlay"></div>
        <div class="offcanvas-menu-wrapper">
            <div class="offcanvas__option">
                <%
                    if(user != null){
                %>
                <div class="offcanvas__links">
                    <div>
                        <img class="rounded-circle me-lg-2" src="./images/default_avatar.png" alt="" style="width: 30px; height: 30px;">
                        <span style='color: white; margin-left: 5px;'><%= ten %></span>
                    </div>
                    <ul class="dropdown">
                        <li><a href="profile">My Profile</a></li>
                        <li><a href="purchase">Đơn mua</a></li>
                        <li><a href="logout">Log Out</a></li>
                    </ul>
                </div>
                <%
                    }else{
                %>
                <div class="offcanvas__links">
                    <a href="login">Đăng nhập</a>
                    <a href="register">Tạo tài khoản</a>
                </div>
                <%
                    }
                %>
            </div>
            <div class="offcanvas__nav__option">
                <a href="#" class="search-switch"><img src="images/icon/search.png" alt=""></a>
                <a href="#"><img src="images/icon/heart.png" alt=""></a>
                <a href="#"><img src="images/icon/cart.png" alt=""> <span>0</span></a>
                <div class="price"></div>
            </div>
            <div id="mobile-menu-wrap"></div>
            <div class="offcanvas__text">
                <p>Miễn phí vận chuyển, đảm bảo hoàn trả hoặc hoàn tiền trong 30 ngày.</p>
            </div>
        </div>
        <!-- Offcanvas Menu End -->

        <!-- Header Section Begin -->
        <header class="header">
            <div class="header__top">
                <div class="container">
                    <div class="row">
                        <div class="col-lg-6 col-md-7">
                            <div class="header__top__left">
                                <p>Miễn phí vận chuyển, đảm bảo hoàn trả hoặc hoàn tiền trong 30 ngày.</p>
                            </div>
                        </div>
                        <div class="col-lg-6 col-md-5">
                            <div class="header__top__right">
                                <%
                                    if(user != null){
                                %>
                                <div class="offcanvas__links">
                                    <div class="avatar">
                                        <img class="rounded-circle me-lg-2" src="./images/default_avatar.png" alt="" style="width: 30px; height: 30px;">
                                        <span style='color: white; margin-left: 5px;'>
                                            <%= ten %>
                                            <ul class="dropdown">
                                                <li><a href="profile">My Profile</a></li>
                                                <li><a href="purchase">Đơn mua</a></li>
                                                <li><a href="logout">Log Out</a></li>
                                            </ul>
                                        </span>

                                    </div>

                                </div>
                                <%
                                    }else{
                                %>
                                <div class="header__top__links">
                                    <a href="login">Đăng nhập</a>
                                    <a href="register">Tạo tài khoản</a>
                                </div>
                                <%
                                    }
                                %>

                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="container">
                <div class="row">
                    <div class="col-lg-3 col-md-3">
                        <div class="header__logo">
                            <a href="home"><img src="images/logo.png" alt=""></a>
                        </div>
                    </div>
                    <div class="col-lg-6 col-md-6">
                        <nav class="header__menu mobile-menu">
                            <ul>
                                <li class="active"><a href="home">Home</a></li>
                                <li><a href="product">Shop</a></li>
                                <li><a href="blog">Blog</a></li>
                                <li><a href="contacts">Contacts</a></li>
                            </ul>
                        </nav>
                    </div>
                    <div class="col-lg-3 col-md-3">
                        <div class="header__nav__option">
                            <a href="#" class="search-switch"><img src="images/icon/search.png" alt=""></a>
                            <a href="#"><img src="images/icon/heart.png" alt=""></a>
                            <c:choose>
                                <c:when test="${empty sessionScope.cartSize}">
                                    <a href="cart"><img src="images/icon/cart.png" alt=""> <span>0</span></a>
                                </c:when>
                                <c:otherwise>
                                    <a href="cart"><img src="images/icon/cart.png" alt=""> <span>${sessionScope.cartSize}</span></a>
                                </c:otherwise>
                            </c:choose>
                            <div class="price"></div>
                        </div>
                    </div>
                </div>
                <div class="canvas__open"><i class="fa fa-bars"></i></div>
            </div>
        </header>
        <!-- Header Section End -->

        <section class="spad">
            <div class="container h-100">
                <div class="row d-flex justify-content-center align-items-center h-100">
                    <div class="col-12 col-md-9 col-lg-7 col-xl-6">
                        <div class="card" style="border-radius: 15px;">
                            <div class="card-body p-5">
                                <h2 class="text-uppercase text-center mb-5">Tạo tài khoản mới</h2>

                                <form action="register" id="signupForm" method="post">
                                    <div class="form-outline mb-4">
                                        <input type="text" name="username" required class="form-control form-control-lg" placeholder="Username" />                                            
                                    </div>

                                    <div class="form-outline mb-4"> 
                                        <h6 id="status_email"></h6>
                                        <input type="email" name="email" id="email" required placeholder="Email"  class="form-control form-control-lg" />                                            
                                        <script>
                                            function isEmailValid(email) {
                                                // Regular expression pattern for a valid email address
                                                let emailPattern = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/;
                                                return emailPattern.test(email);
                                            }
                                            let emailInput = document.getElementById("email");
                                            emailInput.addEventListener("blur", (event) => {
                                                let email = emailInput.value.trim();
                                                let status_email = document.getElementById("status_email");
                                                if (!isEmailValid(email)) {
                                                    status_email.innerHTML = "Email khong dung dinh dang";
                                                    status_email.classList.add('mb-2');
                                                    status_email.style.color = "red";
                                                } else {
                                                    status_email.innerHTML = "";
                                                }
                                            });
                                        </script>
                                    </div>                                        

                                    <div class="form-outline mb-4" >   
                                        <h6 id="status_pass"></h6>
                                        <div id="show_hide_password1">
                                            <input type="password" id="password" name="password" required placeholder="Password" class="form-control form-control-lg" />
                                            <div class="input-group-addon">                                                 
                                                <a href=""><i class="fas fa-eye-slash"></i></a>
                                            </div>                                                
                                        </div>
                                        <!--                                        <script>
                                                                                    // Get a reference to the password input field and the error message span
                                                                                    let passwordInput = document.getElementById("password");
                                                                                    // Add an event listener to the input field to validate the password
                                                                                    passwordInput.addEventListener("blur", (event) => {
                                                                                        const password = passwordInput.value;
                                                                                        let status_pass = document.getElementById("status_pass");
                                                                                        // Define the regular expression pattern for password validation
                                                                                        const passwordPattern = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$/;
                                                                                        // Check if the password matches the pattern
                                                                                        if (!passwordPattern.test(password)) {
                                                                                            status_pass.innerHTML = "Password must contain at least eight characters, at least one letter, one number and one special character.";
                                                                                            status_pass.classList.add('mb-2');
                                                                                            status_pass.style.color = "red";
                                                                                        } else {
                                                                                            status_pass.innerHTML = "";
                                                                                        }
                                                                                    });
                                                                                </script>-->
                                    </div>

                                    <div class="form-outline mb-4" >
                                        <h6 id="status_pass_confirm"></h6>
                                        <div id="show_hide_password2"> 
                                            <input type="password" id="confirmPassword" name="confirmPassword" required class="form-control form-control-lg" placeholder="Repeat your password" />                                            
                                            <div class="input-group-addon">                                                 
                                                <a href=""><i class="fas fa-eye-slash"></i></a>
                                            </div>                                                
                                        </div>
                                        <script>//check if password in confirm password field matches that in password field
                                            let password = document.getElementById("password");
                                            let passwordConfirm = document.getElementById("confirmPassword");
                                            let status_pass_confirm = document.getElementById("status_pass_confirm");
                                            passwordConfirm.addEventListener("blur", (event) => {
                                                try {
                                                    if (passwordConfirm.value !== password.value) {
                                                        status_pass_confirm.innerHTML = "Mat khau khong khop";
                                                        status_pass_confirm.classList.add('mb-2');
                                                        status_pass_confirm.style.color = "red";
                                                    } else {
                                                        status_pass_confirm.innerHTML = "";
                                                    }
                                                } catch (error) {
                                                    status_pass_confirm.innerHTML = "Mat khau khong khop";
                                                    status_pass_confirm.classList.add('mb-2');
                                                    status_pass_confirm.style.color = "red";
                                                }
                                            });
                                        </script>                                            
                                    </div>                                       

                                    <div class="form-outline mb-4">  
                                        <h6 id="status_phone"></h6>
                                        <input type="text" id="phone" name="phone" required class="form-control form-control-lg" placeholder="Phone number" />
                                        <script>//check phone number
                                            let phone = document.getElementById("phone");
                                            let status_phone = document.getElementById("status_phone");
                                            phone.addEventListener("blur", (event) => {
                                                try {
                                                    if (phone.value.length !== 10) {
                                                        status_phone.innerHTML = "Số điện thoại phải có 10 chứ số";
                                                        status_phone.classList.add('mb-2');
                                                        status_phone.style.color = "red";
                                                    } else {
                                                        status_phone.innerHTML = "";
                                                    }
                                                } catch (error) {
                                                    status_phone.innerHTML = "Số điện thoại phải có 10 chứ số";
                                                    status_phone.classList.add('mb-2');
                                                    status_phone.style.color = "red";
                                                }
                                            });
                                        </script>                                            
                                    </div>

                                    <div class="form-outline mb-4">
                                        <input type="text" name="address" required class="form-control form-control-lg" placeholder="Address"/>
                                    </div>

                                    <div class="d-flex mb-5">
                                        <input type="checkbox" value="" id="form2Example3cg" />
                                        <label class="form-check-label ms-2" for="form2Example3cg">
                                            Tôi đồng ý với tất cả các tuyên bố trong Điều khoản dịch vụ
                                        </label>
                                    </div>


                                    <div class="d-flex justify-content-center">
                                        <button type="submit" style="width: 100%"
                                                class="btn btn-success btn-block btn-lg gradient-custom-4 text-body">
                                            Đăng ký
                                        </button>
                                    </div>

                                    <p class="text-center text-muted mt-5 mb-0">Đã có tài khoản rồi? 
                                        <a href="login" class="fw-bold text-body">
                                            <span>Đăng nhập</span>
                                        </a>
                                    </p>


                                    <%
                                        // Server-side code to handle failed registration attempt
                                        String message = (String) request.getAttribute("ms");
                                        if (message != null) {
                                    %> 
                                    <!-- Display error message for failed registration -->
                                    <div class="WrongRegister">
                                        <p><%= message%></p>
                                    </div>
                                    <%
                                        }
                                    %>                                                                                
                                </form>

                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>


        <!-- Footer Section Begin -->
        <footer class="footer">
            <div class="container">
                <div class="row">
                    <div class="col-lg-3 col-md-6 col-sm-6">
                        <div class="footer__about">
                            <div class="footer__logo">
                                <a href="#"><img src="images/footer-logo.png" alt=""></a>
                            </div>
                            <p>Chúng tôi tận tâm đặt khách hàng vào trung tâm của mọi hoạt động kinh doanh, từ thiết kế đến dịch vụ, 
                                nhằm mang lại trải nghiệm tốt nhất cho quý khách.
                            </p>
                            <a href="#"><img src="images/payment.png" alt=""></a>
                        </div>
                    </div>
                    <div class="col-lg-2 offset-lg-1 col-md-3 col-sm-6">
                        <div class="footer__widget">
                            <h6>Mua sắm</h6>
                            <ul>
                                <li><a href="#">Cửa hàng quần áo</a></li>
                                <li><a href="#">Phụ kiện</a></li>
                                <li><a href="#">Khuyến mãi</a></li>
                            </ul>
                        </div>
                    </div>
                    <div class="col-lg-2 col-md-3 col-sm-6">
                        <div class="footer__widget">
                            <h6>Hỗ trợ</h6>
                            <ul>
                                <li><a href="#">Liên hệ</a></li>
                                <li><a href="#">Phương thức thanh toán</a></li>
                                <li><a href="#">Giao hàng</a></li>
                                <li><a href="#">Đổi trả hàng</a></li>
                            </ul>
                        </div>
                    </div>
                    <div class="col-lg-3 offset-lg-1 col-md-6 col-sm-6">
                        <div class="footer__widget">
                            <h6>Thư thông báo</h6>
                            <div class="footer__newslatter">
                                <p>Hãy là người đầu tiên nhận thông tin về các sản phẩm mới, lookbook, khuyến mãi & sự kiện!</p>
                                <form action="#">
                                    <input type="text" placeholder="Email của bạn">
                                    <button type="submit"><span class="icon_mail_alt"></span></button>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </footer>
        <!-- Footer Section End -->


        <!-- Js Plugins -->
        <script src="js/jquery-3.3.1.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script src="js/jquery.countdown.min.js"></script>
        <script src="js/jquery.slicknav.js"></script>
        <script src="js/owl.carousel.min.js"></script>
        <script src="js/main.js"></script>
        <script src="js/client/register.js"></script>

    </body>

</html>
