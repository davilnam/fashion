<%-- 
    Document   : profile
    Created on : May 22, 2024, 10:57:21 PM
    Author     : PC
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
        <link href="https://fonts.googleapis.com/css2?family=Nunito+Sans:wght@300;400;600;700;800;900&display=swap" rel="stylesheet">

        <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

        <!-- Css Styles -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
        <link rel="stylesheet" href="//use.fontawesome.com/releases/v5.0.7/css/all.css">
        <link rel="stylesheet" href="css/owl.carousel.min.css" type="text/css">
        <link rel="stylesheet" href="css/slicknav.min.css" type="text/css">
        <link rel="stylesheet" href="css/style.css" type="text/css">
    </head>

    <body>
        <%
           User user = (User)session.getAttribute("acc");     
           request.setAttribute("user", user);
        %>
        <%
            String updateInfoSuccess = (String) session.getAttribute("updateInfoSuccess");
            if(updateInfoSuccess != null){
        %>
        <script>
            swal("Congrats", "<%= updateInfoSuccess%>", "success");
        </script>
        <%
            }
            session.removeAttribute("updateInfoSuccess");
        %>
        <%
            String updateInfoError = (String) session.getAttribute("updateInfoError");
            if(updateInfoError != null){
        %>
        <script>
            swal("Error", "<%= updateInfoError%>", "error");
        </script>
        <%
            }
            session.removeAttribute("updateInfoError");
        %>
        <!-- Page Preloder -->
        <div id="preloder">
            <div class="loader"></div>
        </div>

        <!-- Offcanvas Menu Begin -->
        <div class="offcanvas-menu-overlay"></div>
        <div class="offcanvas-menu-wrapper">
            <div class="offcanvas__option">                
                <div class="offcanvas__links">
                    <div>
                        <img class="rounded-circle me-lg-2" src="./images/default_avatar.png" alt="" style="width: 30px; height: 30px;">
                        <span style='color: white; margin-left: 5px;'>${requestScope.user.username}</span>
                    </div>
                    <ul class="dropdown">
                        <li><a href="profile">My Profile</a></li>
                        <li><a href="purchase">Đơn mua</a></li>
                        <li><a href="logout">Log Out</a></li>
                    </ul>
                </div>               
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
                                <div class="offcanvas__links">
                                    <div class="avatar">
                                        <img class="rounded-circle me-lg-2" src="./images/default_avatar.png" alt="" style="width: 30px; height: 30px;">
                                        <span style='color: white; margin-left: 5px;'>
                                            ${requestScope.user.username}
                                            <ul class="dropdown">
                                                <li><a href="profile">My Profile</a></li>
                                                <li><a href="purchase">Đơn mua</a></li>
                                                <li><a href="logout">Log Out</a></li>
                                            </ul>
                                        </span>

                                    </div>
                                </div>                               
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
                                <li><a href="home">Home</a></li>
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
                            <a href="cart"><img src="images/icon/cart.png" alt=""> <span>${requestScope.cartSize}</span></a>

                            <div class="price"></div>
                        </div>
                    </div>
                </div>
                <div class="canvas__open"><i class="fa fa-bars"></i></div>
            </div>
        </header>
        <!-- Header Section End -->        

        <!-- Shopping Cart Section Begin -->
        <section class="mb-4">
            <div class="container">  
                <h4 class="mb-4">Quản lý hồ sơ cá nhân</h4>              
                <form action="profile" method="post">

                    <div class="row align-items-center mb-3">
                        <div class="col-3 col-md-2">
                            <img class="rounded-circle" id="avatar-image" src="./images/default_avatar.png" alt="" style="width: 80px; height: 80px;">
                        </div>
                        <div class="col-9 col-md-10">
                            <div class="mb-3">
                                <label for="avatar-input" class="form-label">Chọn ảnh</label>
                                <input type="file" name="avatar" id="avatar-input" accept="image/*">
                            </div>
                        </div>
                    </div>
                    <hr class="border-light m-0">                    
                    <div class="row">                        
                        <div class="col-md-6">
                            <div class="form-group">
                                <label class="form-label">Username</label>
                                <input type="text" name="username" class="form-control mb-1" value="${requestScope.user.username}">
                            </div>                                    
                            <div class="form-group">
                                <label class="form-label">E-mail</label>
                                <input type="text" name="email" class="form-control mb-1" readonly value="${requestScope.user.email}">                                        
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label class="form-label">Phone</label>
                                <input type="text" name="phone" class="form-control" value="${requestScope.user.phone}">
                            </div>
                            <div class="form-group">
                                <label class="form-label">Address</label>
                                <input type="text" name="address" class="form-control" value="${sessionScope.acc.address}">
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col">
                            <div class="form-group">
                                <label class="form-label">FullName</label>
                                <input type="text" name="fullName" class="form-control mb-1" value="${requestScope.user.fullName}">
                            </div> 
                        </div>
                    </div>
                    <button class="btn btn-primary" type="submit">Lưu</button>

                </form>
            </div>
        </section>



        <!-- Shopping Cart Section End -->

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
        <script src="js/client/cart.js"></script>
    </body>

</html>
