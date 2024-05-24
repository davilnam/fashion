<%-- 
    Document   : home
    Created on : Apr 27, 2024, 4:04:06 PM
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
           String ten = "";
           if(user != null){
              ten = user.getUsername();
           }             
        %>
        <%
            String requiredLogin = (String)session.getAttribute("requireLogin");
            if(requiredLogin != null){                        
        %>
        <script>
            swal("Warning", "<%= requiredLogin%>", "warning");
        </script>
        <%
            }
            session.removeAttribute("requireLogin");
        %>
        <%
            String addToCartSuccess = (String)session.getAttribute("addToCartSuccess");
            if(addToCartSuccess != null){                        
        %>
        <script>
            swal("Congrats", "<%= addToCartSuccess%>", "success");
        </script>
        <%
            }
            session.removeAttribute("addToCartSuccess");
        %>        <!-- Page Preloder -->
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

        <!-- Shop Details Section Begin -->        
        <div class="product__details__pic">
            <div class="container">
                <div class="row">
                    <div class="col-lg-5 col-md-5">
                        <div class="row">
                            <div class="tab-content" style="width: 100%; text-align: center">
                                <c:forEach items="${requestScope.product.productImages}" var="o" varStatus="loop">
                                    <div class="tab-pane <c:if test="${loop.index == 0}">active</c:if>" id="tabs-${loop.index + 1}" role="tabpanel">
                                            <div class="product__details__pic__item">
                                                <img src="images/${o.url}" alt="">
                                        </div>
                                    </div>
                                </c:forEach>

                            </div>
                        </div>
                        <div class="row">
                            <ul class="nav nav-tabs slider" role="tablist">
                                <c:forEach items="${requestScope.product.productImages}" var="o" varStatus="loop">
                                    <li class="nav-item">
                                        <a class="nav-link <c:if test="${loop.index == 0}">active</c:if>" data-toggle="tab" href="#tabs-${loop.index + 1}" role="tab">
                                            <div class="product__thumb__pic set-bg" data-setbg="images/${o.url}">
                                            </div>
                                        </a>
                                    </li>
                                </c:forEach>                              
                            </ul>
                        </div>
                    </div>
                    <div class="col-lg-7 col-md-7 pl-5">
                        <div class="product__details__text">
                            <h4>${requestScope.product.name}</h4>
                            <div class="rating">
                                <i class="fa fa-star"></i>
                                <i class="fa fa-star"></i>
                                <i class="fa fa-star"></i>
                                <i class="fa fa-star"></i>
                                <i class="fa fa-star-o"></i>
                                <span> - 5 Reviews</span>
                            </div>
                            <fmt:formatNumber value="${requestScope.product.price}" type="currency" currencyCode="VND" var="formattedPrice" pattern="#,##0" />                            
                            <h3>${formattedPrice} VND</h3>
                            <p>${requestScope.product.description}</p>
                            <form method="post" action="add-to-cart">
                                <input type="hidden" name="productId" value="${requestScope.product.id}">
                                <div class="product__details__option">
                                    <div class="product__details__option__size">                                    
                                        <label for="size" class="form-label">Size:</label>
                                        <select id="size" name="size">
                                            <c:forEach items="${requestScope.product.inventory}" var="o">
                                                <option value="${o.productOption.size}">${o.productOption.size}</option>
                                            </c:forEach>
                                        </select>                                    
                                    </div>                                
                                    <div class="product__details__option__color">
                                        <label for="color" class="form-label">Color:</label>
                                        <select id="color" name="color">
                                            <c:forEach items="${requestScope.product.inventory}" var="o">
                                                <option value="${o.productOption.color}">${o.productOption.color}</option>
                                            </c:forEach>
                                        </select>  
                                    </div>
                                </div>                            
                                <div class="product__details__cart__option">
                                    <div class="quantity">
                                        <div class="pro-qty">
                                            <input type="number" name="soLuong" value="1">
                                        </div>
                                    </div>

                                    <button type="submit" class="primary-btn">add to cart</button>
                                </div> 
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>            
        <!-- Shop Details Section End -->

        <!-- Related Section Begin -->
        <section class="related spad">
            <div class="container">
                <div class="row">
                    <div class="col-lg-12">
                        <h3 class="related-title">Related Product</h3>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-3 col-md-6 col-sm-6 col-sm-6">
                        <div class="product__item">
                            <div class="product__item__pic set-bg" data-setbg="images/product/product-1.jpg">
                                <span class="label">New</span>
                                <ul class="product__hover">
                                    <li><a href="#"><img src="images/icon/heart.png" alt=""></a></li>
                                    <li><a href="#"><img src="images/icon/compare.png" alt=""> <span>Compare</span></a></li>
                                    <li><a href="#"><img src="images/icon/search.png" alt=""></a></li>
                                </ul>
                            </div>
                            <div class="product__item__text">
                                <h6>Piqué Biker Jacket</h6>
                                <a href="#" class="add-cart">+ Add To Cart</a>
                                <div class="rating">
                                    <i class="fa fa-star-o"></i>
                                    <i class="fa fa-star-o"></i>
                                    <i class="fa fa-star-o"></i>
                                    <i class="fa fa-star-o"></i>
                                    <i class="fa fa-star-o"></i>
                                </div>
                                <h5>$67.24</h5>
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
                    <div class="col-lg-3 col-md-6 col-sm-6 col-sm-6">
                        <div class="product__item">
                            <div class="product__item__pic set-bg" data-setbg="images/product/product-2.jpg">
                                <ul class="product__hover">
                                    <li><a href="#"><img src="images/icon/heart.png" alt=""></a></li>
                                    <li><a href="#"><img src="images/icon/compare.png" alt=""> <span>Compare</span></a></li>
                                    <li><a href="#"><img src="images/icon/search.png" alt=""></a></li>
                                </ul>
                            </div>
                            <div class="product__item__text">
                                <h6>Piqué Biker Jacket</h6>
                                <a href="#" class="add-cart">+ Add To Cart</a>
                                <div class="rating">
                                    <i class="fa fa-star-o"></i>
                                    <i class="fa fa-star-o"></i>
                                    <i class="fa fa-star-o"></i>
                                    <i class="fa fa-star-o"></i>
                                    <i class="fa fa-star-o"></i>
                                </div>
                                <h5>$67.24</h5>
                                <div class="product__color__select">
                                    <label for="pc-4">
                                        <input type="radio" id="pc-4">
                                    </label>
                                    <label class="active black" for="pc-5">
                                        <input type="radio" id="pc-5">
                                    </label>
                                    <label class="grey" for="pc-6">
                                        <input type="radio" id="pc-6">
                                    </label>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6 col-sm-6 col-sm-6">
                        <div class="product__item sale">
                            <div class="product__item__pic set-bg" data-setbg="images/product/product-3.jpg">
                                <span class="label">Sale</span>
                                <ul class="product__hover">
                                    <li><a href="#"><img src="images/icon/heart.png" alt=""></a></li>
                                    <li><a href="#"><img src="images/icon/compare.png" alt=""> <span>Compare</span></a></li>
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
                                <h5>$43.48</h5>
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
                    <div class="col-lg-3 col-md-6 col-sm-6 col-sm-6">
                        <div class="product__item">
                            <div class="product__item__pic set-bg" data-setbg="images/product/product-4.jpg">
                                <ul class="product__hover">
                                    <li><a href="#"><img src="images/icon/heart.png" alt=""></a></li>
                                    <li><a href="#"><img src="images/icon/compare.png" alt=""> <span>Compare</span></a></li>
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
                                <h5>$60.9</h5>
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
                </div>
            </div>
        </section>
        <!-- Related Section End -->

        <!<!-- comment -->
        <section class="comments pb-5">
            <div class="container">
                <h2>Bình luận</h2>
                <form action="product-detail" method="post">
                    <input type="hidden" value="${requestScope.product.id}" name="pid" />
                    <div className="form-group">
                        <textarea
                            class="form-control"                            
                            placeholder="Nhập bình luận của bạn..."
                            rows="4"
                            name="comment"
                            required
                            ></textarea>
                    </div>
                    <button type="submit" class="btn btn-primary mt-2">Đăng</button>
                </form>

            </div>
        </section>

        <c:if test="${not empty requestScope.listReview}">
            <section class="comment-list">
                <div class="container">
                    <h3>Danh sách bình luận</h3>
                    <div class="row mb-4">
                        <c:forEach items="${requestScope.listReview}" var="r">
                            <div class="col-12 mb-3">
                                <div class="comment">
                                    <div class="row">
                                        <div class="col-2 col-sm-2 col-md-1">
                                            <div>
                                                <img src="images/default_avatar.png" alt="Avatar" class="avatar img-fluid">
                                            </div>
                                        </div>
                                        <div class="col-10 col-sm-10 col-md-11">
                                            <h5 class="mb-2">${r.user.username}</h5>
                                            <p>${r.comment}</p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>                   
                    </div>
                </div>
            </section>
        </c:if>

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
