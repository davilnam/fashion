<%-- 
    Document   : checkout
    Created on : May 17, 2024, 3:15:07 PM
    Author     : PC
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="model.User" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="description" content="Male_Fashion Template">
        <meta name="keywords" content="Male_Fashion, unica, creative, html">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
        <title>Male-Fashion</title>

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
    </head>

    <body>
        <%
            User user = (User)session.getAttribute("acc");
            String ten = "";
            if(user != null){
               ten = user.getUsername();
            }  
            request.setAttribute("user", user);            
        %>
        <%
            String status = (String) session.getAttribute("loginRequired");
            if (status != null) {
        %>
        <script>
            swal("Vui lòng đăng nhập trước khi thanh toán");
        </script>
        <%
            }
            session.removeAttribute("loginRequired");            
        %>
        <%
            String error = (String) session.getAttribute("error");
            if (error != null) {
        %>
        <script>
            swal("Xảy ra lỗi vui lòng thử lại sau", "error");
        </script>
        <%
            }
            session.removeAttribute("error");            
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

        <!-- Breadcrumb Section Begin -->
        <section class="breadcrumb-option">
            <div class="container">
                <div class="row">
                    <div class="col-lg-12">
                        <div class="breadcrumb__text">
                            <h4>Check Out</h4>
                            <div class="breadcrumb__links">
                                <a href="home">Home</a>
                                <i class="fas fa-angle-right"></i>
                                <a href="product">Shop</a>
                                <i class="fas fa-angle-right"></i>
                                <span>Checkout</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!-- Breadcrumb Section End -->

        <!-- Checkout Section Begin -->
        <section class="checkout mt-5 mb-5">
            <div class="container">
                <div class="checkout__form">
                    <form action="checkout" method="post">
                        <div class="mb-4">
                            <h2>Địa chỉ</h2>
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label for="fullName" class="form-label">Họ và tên</label>
                                    <input type="text" value="${user.fullName}" class="form-control" id="fullName" name="fullName" required>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label for="note" class="form-label">Ghi chú</label>
                                    <input type="text" class="form-control" id="note" name="note">
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label for="phone" class="form-label">Số điện thoại</label>
                                    <input type="text" value="${user.phone}" class="form-control" id="phone" name="phone" required>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label for="address" class="form-label">Địa chỉ</label>
                                    <input type="text" value="${user.address}" class="form-control" id="address" name="address" required>
                                </div>                                
                            </div>
                        </div>                        
                        <div class="mb-5">
                            <h2 class="mb-3">Sản phẩm</h2>
                            <table class="table table-bordered">
                                <thead>
                                    <tr>
                                        <th>Hình ảnh</th>
                                        <th>Tên</th>
                                        <th>Giá</th>
                                        <th>Số lượng</th>
                                        <th>Thành tiền</th>
                                    </tr>
                                </thead>                                
                                <tbody>
                                    <c:set var="totalAmount" value="0" />
                                    <c:forEach items="${requestScope.cart}" var="p">
                                        <tr>
                                            <td>
                                                <div style="width: 100px; margin-right: 10px">
                                                    <img src="images/${p.image}" alt="" class="img-fluid">
                                                </div>
                                            </td>
                                            <td>${p.name}</td>
                                            <td>
                                                <fmt:formatNumber value="${p.price}" type="currency" currencyCode="VND" var="formattedPrice" pattern="#,##0" />
                                                <h5>${formattedPrice}</h5>
                                            </td>
                                            <td>${p.inventory[0].stockQuantity}</td>
                                            <c:set var="itemTotal" value="${p.inventory[0].stockQuantity * p.price}" />
                                            <fmt:formatNumber value="${itemTotal}" type="currency" currencyCode="VND" var="formattedPrice1" pattern="#,##0" />
                                            <td class="cart__price">${formattedPrice1}</td>     
                                            <c:set var="totalAmount" value="${totalAmount + itemTotal}" />
                                        </tr>
                                    </c:forEach>
                                </tbody>

                            </table>
                        </div>

                        <div class="mb-4">
                            <h3>Phương thức thanh toán</h3>
                            <div class="form-check">
                                <input type="radio" id="cash-on-delivery" name="paymentMethod" value="1" class="form-check-input" required>
                                <label for="cash-on-delivery" class="form-check-label">Thanh toán khi nhận hàng</label>
                            </div>
                            <div class="form-check">
                                <input type="radio" id="credit-card" name="paymentMethod" value="2" class="form-check-input" required>
                                <label for="credit-card" class="form-check-label">Thanh toán bằng thẻ tín dụng</label>
                            </div>
                        </div>

                        <div class="d-flex justify-content-end">
                            <div style="width: 30%">
                                <div class="d-flex align-items-center justify-content-between mb-2">                                   
                                    <h5>Tổng tiền hàng: </h5>
                                    <fmt:formatNumber value="${totalAmount}" type="currency" currencyCode="VND" var="formattedPrice2" pattern="#,##0" />
                                    <span>${formattedPrice2} VND</span>
                                </div>                                
                                <div class="d-flex align-items-center justify-content-between mb-2">
                                    <h5>Phí vận chuyển: </h5>
                                    <span>30,000 VND</span>
                                </div>
                                <div class="d-flex align-items-center justify-content-between mb-3">                                    
                                    <h5>Tổng thanh toán: </h5>
                                    <c:set var="total" value="${totalAmount + 30000}" />
                                    <fmt:formatNumber value="${total}" type="currency" currencyCode="VND" var="formattedPrice3" pattern="#,##0" />
                                    <span>${formattedPrice3} VND</span>
                                    <input type="hidden" name="totalAmount" value="${total}">
                                </div>
                                <button type="submit" class="btn btn-primary btn-block">Đặt hàng</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </section>

        <!-- Checkout Section End -->

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
    </body>

</html>
