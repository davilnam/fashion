<%-- 
    Document   : shop
    Created on : Apr 27, 2024, 9:33:57 PM
    Author     : PC
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="java.text.DecimalFormat" %>
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
        <link rel="stylesheet" href="css/owl.carousel.min.css" type="text/css">
        <link rel="stylesheet" href="css/slicknav.min.css" type="text/css">
        <link rel="stylesheet" href="css/style.css" type="text/css">
        <link rel="stylesheet" href="css/client/shop.css" type="text/css">

    </head>

    <body>
        <%
           User user = (User)session.getAttribute("acc");
           String ten = "";
           if(user != null){
              ten = user.getUsername();
           }
             
        %>
        <%
            DecimalFormat formatter = new DecimalFormat("#,### VND");
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
                                <li class="active"><a href="product">Shop</a></li>
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
                            <h4>Shop</h4>
                            <div class="breadcrumb__links">
                                <a href="home">Home</a>
                                <i class="fas fa-angle-right"></i>
                                <a href="product">Shop</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!-- Breadcrumb Section End -->

        <!-- Shop Section Begin -->
        <section class="shop spad">
            <div class="container">
                <div class="row">
                    <div class="col-lg-3">
                        <div class="shop__sidebar">
                            <div class="shop__sidebar__search">
                                <form action="search" method="post">
                                    <input type="text" name="text" placeholder="Search...">
                                    <button type="submit"><i class="fas fa-search"></i></button>
                                </form>
                            </div>
                            <div class="shop__sidebar__accordion">
                                <div class="accordion" id="accordionExample">
                                    <div class="card">
                                        <div class="card-heading" data-toggle="collapse" data-target="#collapseOne">
                                            <span>Categories</span>
                                            <i class="fas fa-chevron-down"></i>
                                        </div>
                                        <div id="collapseOne" class="collapse show" data-parent="#accordionExample">
                                            <div class="card-body">
                                                <div class="shop__sidebar__categories">
                                                    <ul class="nice-scroll">
                                                        <c:forEach items="${sessionScope.listCategory}" var="o">
                                                            <li class="category-filter ${o.id == requestScope.cid ? ' active' : ''}" style="cursor: pointer"><a href="filter?cid=${o.id}">${o.name}</a></li>
                                                        </c:forEach>                                                                                                                
                                                    </ul>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-9">
                        <div class="shop__product__option">
                            
                        </div>
                        <div class="row">
                            <c:forEach items="${requestScope.listItemsPerPage}" var="p">
                                <div class="col-lg-4 col-md-6 col-sm-6">
                                    <div class="product__item sale">
                                        <div class="product__item__pic set-bg" data-setbg="images/${p.image}">                                    
                                            <ul class="product__hover">
                                                <li><a href="#"><img src="images/icon/heart.png" alt=""></a></li>
                                                <li><a href="#"><img src="images/icon/compare.png" alt=""> <span>Compare</span></a></li>
                                                <li><a href="#"><img src="images/icon/search.png" alt=""></a></li>
                                            </ul>
                                        </div>
                                        <div class="product__item__text">
                                            <h6><a href="product-detail?id=${p.id}">${p.name}</a></h6>                                    
                                            <div class="rating">
                                                <i class="fas fa-star"></i>
                                                <i class="fas fa-star"></i>
                                                <i class="fas fa-star"></i>
                                                <i class="fas fa-star"></i>
                                                <i class="fas fa-star"></i>
                                            </div>
                                            <fmt:formatNumber value="${p.price}" type="currency" currencyCode="VND" var="formattedPrice" pattern="#,##0" />
                                            <h5>
                                                ${formattedPrice} VND                                 
                                            </h5>
                                            <div class="product__color__select">
                                                <label for="pc-1">
                                                    <input type="radio" id="pc-1">
                                                </label>
                                                <label class="active black" for="pc-2">
                                                    <input type="radio" id="pc-2">
                                                </label>
                                                <label class="grey" for="pc-3">
                                                    <input type="radio" id="pc-3">
                                                </label>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>                               
                            <div class="col-lg-4 col-md-6 col-sm-6">
                                <div class="product__item sale">
                                    <div class="product__item__pic set-bg" data-setbg="images/product/product-3.jpg">
                                        <span class="label">Sale</span>
                                        <ul class="product__hover">
                                            <li><a href="#"><img src="images/icon/heart.png" alt=""></a></li>
                                            <li><a href="#"><img src="images/icon/compare.png" alt=""> <span>Compare</span></a>
                                            </li>
                                            <li><a href="#"><img src="images/icon/search.png" alt=""></a></li>
                                        </ul>
                                    </div>
                                    <div class="product__item__text">
                                        <h6>Multi-pocket Chest Bag</h6>
                                        <a href="#" class="add-cart">+ Add To Cart</a>
                                        <div class="rating">
                                            <i class="fa fa-star"></i>
                                            <i class="fa fa-star"></i>
                                            <i class="fa fa-star"></i>
                                            <i class="fa fa-star"></i>
                                            <i class="fa fa-star-o"></i>
                                        </div>
                                        <h5>100000vnd</h5>
                                        <div class="product__color__select">
                                            <label for="pc-7">
                                                <input type="radio" id="pc-7">
                                            </label>
                                            <label class="active black" for="pc-8">
                                                <input type="radio" id="pc-8">
                                            </label>
                                            <label class="grey" for="pc-9">
                                                <input type="radio" id="pc-9">
                                            </label>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-6 col-sm-6">
                                <div class="product__item">
                                    <div class="product__item__pic set-bg" data-setbg="images/product/product-4.jpg">
                                        <ul class="product__hover">
                                            <li><a href="#"><img src="images/icon/heart.png" alt=""></a></li>
                                            <li><a href="#"><img src="images/icon/compare.png" alt=""> <span>Compare</span></a>
                                            </li>
                                            <li><a href="#"><img src="images/icon/search.png" alt=""></a></li>
                                        </ul>
                                    </div>
                                    <div class="product__item__text">
                                        <h6>Diagonal Textured Cap</h6>
                                        <a href="#" class="add-cart">+ Add To Cart</a>
                                        <div class="rating">
                                            <i class="fa fa-star-o"></i>
                                            <i class="fa fa-star-o"></i>
                                            <i class="fa fa-star-o"></i>
                                            <i class="fa fa-star-o"></i>
                                            <i class="fa fa-star-o"></i>
                                        </div>
                                        <h5>150000vnd</h5>
                                        <div class="product__color__select">
                                            <label for="pc-10">
                                                <input type="radio" id="pc-10">
                                            </label>
                                            <label class="active black" for="pc-11">
                                                <input type="radio" id="pc-11">
                                            </label>
                                            <label class="grey" for="pc-12">
                                                <input type="radio" id="pc-12">
                                            </label>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-6 col-sm-6">
                                <div class="product__item sale">
                                    <div class="product__item__pic set-bg" data-setbg="images/product/product-6.jpg">
                                        <span class="label">Sale</span>
                                        <ul class="product__hover">
                                            <li><a href="#"><img src="images/icon/heart.png" alt=""></a></li>
                                            <li><a href="#"><img src="images/icon/compare.png" alt=""> <span>Compare</span></a>
                                            </li>
                                            <li><a href="#"><img src="images/icon/search.png" alt=""></a></li>
                                        </ul>
                                    </div>
                                    <div class="product__item__text">
                                        <h6>Ankle Boots</h6>
                                        <a href="#" class="add-cart">+ Add To Cart</a>
                                        <div class="rating">
                                            <i class="fa fa-star"></i>
                                            <i class="fa fa-star"></i>
                                            <i class="fa fa-star"></i>
                                            <i class="fa fa-star"></i>
                                            <i class="fa fa-star-o"></i>
                                        </div>
                                        <h5>250000vnd</h5>
                                        <div class="product__color__select">
                                            <label for="pc-16">
                                                <input type="radio" id="pc-16">
                                            </label>
                                            <label class="active black" for="pc-17">
                                                <input type="radio" id="pc-17">
                                            </label>
                                            <label class="grey" for="pc-18">
                                                <input type="radio" id="pc-18">
                                            </label>
                                        </div>
                                    </div>
                                </div>
                            </div>                            
                        </div>
                        <!-- Phân trang -->
                        <ul class="pagination">
                            <!-- Hiển thị nút "Previous" -->
                            <c:if test="${currentPage > 1}">
                                <li class="page-item">
                                    <a class="page-link" href="?page=${currentPage - 1}" aria-label="Previous">
                                        <span aria-hidden="true">&laquo;</span>
                                    </a>
                                </li>
                            </c:if>

                            <!-- Hiển thị các trang bên trái của trang hiện tại -->
                            <c:forEach begin="${currentPage - 1}" end="${currentPage + 2}" var="page">
                                <c:if test="${page > 0 && page <= totalPages}">
                                    <c:choose>
                                        <c:when test="${page == currentPage}">
                                            <li class="page-item active">
                                                <span class="page-link">${page}</span>
                                            </li>
                                        </c:when>
                                        <c:otherwise>
                                            <li class="page-item">
                                                <a class="page-link" href="?page=${page}">${page}</a>
                                            </li>
                                        </c:otherwise>
                                    </c:choose>
                                </c:if>
                            </c:forEach>

                            <!-- Hiển thị nút "Next" -->
                            <c:if test="${currentPage < totalPages}">
                                <li class="page-item">
                                    <a class="page-link" href="?page=${currentPage + 1}" aria-label="Next">
                                        <span aria-hidden="true">&raquo;</span>
                                    </a>
                                </li>
                            </c:if>
                        </ul>
                    </div>
                </div>
            </div>
        </section>
        <!-- Shop Section End -->

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
        <script src="js/client/shop.js"></script>

    </body>

</html>
