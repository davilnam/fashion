<%-- 
    Document   : product-manager
    Created on : May 12, 2024, 5:01:17 PM
    Author     : PC
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="model.User" %>
<%@ page import="java.util.Map" %>
<%@ page import="model.Category" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">      
        <meta content="width=device-width, initial-scale=1.0" name="viewport">
        <!-- Google Web Fonts -->
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Heebo:wght@400;500;600;700&display=swap" rel="stylesheet">

        <!-- Icon Font Stylesheet -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">

        <!-- sweetaleart -->
        <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

        <!-- Customized Bootstrap Stylesheet -->
        <link href="../css/admin/bootstrap.min.css" rel="stylesheet">

        <!-- Template Stylesheet -->
        <link href="../css/admin/style.css" rel="stylesheet">

        <title>Quản lý sản phẩm</title>        
        <style>
            /* CSS cho hình ảnh xem trước */
            .preview-image {
                width: 200px; /* Điều chỉnh kích thước theo ý muốn */
                height: 200px;
                object-fit: contain; /* Để hình ảnh vừa khuôn */
            }

            th{
                vertical-align: middle;
            }
        </style>

    </head>
    <body>
        <div class="container-fluid position-relative bg-white d-flex p-0">
            <!-- Spinner Start -->
            <div id="spinner" class="show bg-white position-fixed translate-middle w-100 vh-100 top-50 start-50 d-flex align-items-center justify-content-center">
                <div class="spinner-border text-primary" style="width: 3rem; height: 3rem;" role="status">
                    <span class="sr-only">Loading...</span>
                </div>
            </div>
            <!-- Spinner End -->

            <%
                 User user = (User)session.getAttribute("acc");
                 String ten = "";
                 if(user != null){
                    ten = user.getUsername();
                 }         
                 Map<Integer, Category> categoryMap = (Map<Integer, Category>) session.getAttribute("categoryMap");
                 
            %>

            <!-- Sidebar Start -->
            <div class="sidebar pe-4 pb-3">
                <nav class="navbar bg-light navbar-light">                    
                    <div class="d-flex align-items-center ms-4 mb-4">
                        <div class="position-relative">                            
                            <img class="rounded-circle me-lg-2" src="../images/default_avatar.png" alt="" style="width: 40px; height: 40px;">                           
                            <div class="bg-success rounded-circle border border-2 border-white position-absolute end-0 bottom-0 p-1"></div>
                        </div>
                        <div class="ms-3">
                            <h6 class="mb-0"><%= ten %></h6>
                            <span>Admin</span>
                        </div>
                    </div>
                    <div class="navbar-nav w-100">
                        <%
                            String managerProduct = (String)request.getAttribute("managerProduct");
                            String activeProduct = "";
                            if(managerProduct != null){
                                activeProduct = "active";
                            }
                        %>                        
                        <a href="<c:url value='/admin/order' />" class="nav-item nav-link"><i class="fa fa-th me-2"></i>Quản lý đơn hàng</a>
                        <a href='<c:url value="/admin/product"/>' class="nav-item nav-link <%= activeProduct %>"><i class="fa fa-keyboard me-2"></i>Quản lý sản phẩm</a>
                        <a href='<c:url value="/admin/category"/>' class="nav-item nav-link"><i class="fa fa-table me-2"></i>Quản lý danh mục</a>                        
                        <a href="<c:url value='/admin/stats' />" class="nav-item nav-link"><i class="fa fa-chart-bar me-2"></i>Thống kê</a>                        
                    </div>
                </nav>
            </div>
            <!-- Sidebar End -->

            <!-- Content Start -->
            <div class="content">
                <!-- Navbar Start -->
                <nav class="navbar navbar-expand bg-light navbar-light sticky-top px-4 py-0">
                    <a href="#" class="sidebar-toggler flex-shrink-0">
                        <i class="fa fa-bars"></i>
                    </a>
                    <form class="d-none d-md-flex ms-4">
                        <input class="form-control border-0" type="search" placeholder="Search">
                    </form>
                    <div class="navbar-nav align-items-center ms-auto">                        
                        <div class="nav-item dropdown">
                            <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">                               
                                <img class="rounded-circle me-lg-2" src="../images/default_avatar.png" alt="" style="width: 40px; height: 40px;">                               
                                <span class="d-none d-lg-inline-flex"><%= ten %></span>
                            </a>
                            <div class="dropdown-menu dropdown-menu-end bg-light border-0 rounded-0 rounded-bottom m-0">                              
                                <a href="../logout" class="dropdown-item">Log Out</a>
                            </div>
                        </div>
                    </div>
                </nav>
                <!-- Navbar End -->


                <!--  -->
                <div class="container-fluid pt-4 px-4">                  
                    <c:if test="${sessionScope.create == null && sessionScope.edit == null}">
                        <h3>Quản lý sản phẩm</h3>
                        <div class="d-flex align-items-center justify-content-between">
                            <a class="btn btn-primary" href="product?action=create">Thêm mới sản phẩm</a>                            

                            <form action="product?action=search" method="post" class="input-group justify-content-end" style="width: 40%;">
                                <input type="text" name="text" value="${requestScope.text}" class="form-control" placeholder="Tìm theo ten san pham">
                                <div class="input-group-append">
                                    <button type="submit" class="btn btn-primary">
                                        <i class="fas fa-search"></i>
                                    </button>
                                </div>
                            </form>
                        </div>

                        <hr/>
                    </c:if>

                    <!--form create san pham-->
                    <c:if test="${sessionScope.create != null}">
                        <h3 class="mb-4">Create Sản phẩm</h3>
                        <form action="product?action=saveCreate" method="post" enctype="multipart/form-data">
                            <div class="mb-3">
                                <label for="tenSanPham" class="form-label">Tên Sản Phẩm</label>
                                <input type="text" class="form-control" id="tenSanPham" name="tenSanPham" required>
                            </div>

                            <div class="mb-3">
                                <label for="moTa" class="form-label">Mô tả</label>
                                <textarea class="form-control" id="moTa" name="moTa" rows="4"></textarea>
                            </div>

                            <div class="row mb-3">
                                <div class="col">
                                    <label for="giaBan" class="form-label">Giá Bán</label>
                                    <input type="number" class="form-control" id="giaBan" name="giaBan" required>
                                </div>
                                <div class="col">
                                    <label for="soLuong" class="form-label">Số Lượng</label>
                                    <input type="number" class="form-control" id="soLuong" name="soLuong" required>
                                </div>
                            </div>

                            <div class="mb-3">
                                <label for="anhDaiDien" class="form-label">Ảnh Đại Diện</label>
                                <input type="file" class="form-control" id="imageInput" name="anhDaiDien" accept="image/*">
                                <div id="imagePreview" ></div>
                            </div>

                            <div class="mb-3">
                                <label for="anhSanPham" class="form-label">Ảnh Sản Phẩm</label>
                                <input type="file" class="form-control" id="imageInputs" name="anhSanPham" accept="image/*" multiple>
                                <div id="imagePreviews" class="d-flex flex-wrap mt-4 gap-4"></div>
                            </div>

                            <div class="mb-3">
                                <label for="category" class="form-label">Danh Mục</label>
                                <select class="form-select" id="category" name="categoryId">
                                    <c:forEach items="${sessionScope.listCategory}" var="o">
                                        <option value="${o.id}">${o.name}</option>
                                    </c:forEach>
                                </select>
                            </div>


                            <div class="row mb-3">
                                <div class="col">
                                    <label for="size" class="form-label">Kích cỡ</label>
                                    <select class="form-select" name="size" id="size">
                                        <option selected="selected" value="S">S</option>
                                        <option value="M">M</option>
                                        <option value="L">L</option>
                                        <option value="XL">XL</option>
                                        <option value="XXL">XXL</option>
                                    </select>
                                </div>
                                <div class="col">
                                    <label for="mauSac" class="form-label">Màu sắc</label>
                                    <input type="text" class="form-control" id="mauSac" name="mauSac" required>
                                </div>
                            </div>                            

                            <button type="submit" class="btn btn-success">Save</button>
                            <a class="btn btn-secondary m-4" href="product">
                                <i class="ri-arrow-left-s-line"></i> Back
                            </a>
                        </form>

                    </c:if>

                    <!--form edit san pham-->    
                    <c:if test="${sessionScope.edit != null}">
                        <h3 class="mb-4">Edit sản phẩm</h3>
                        <form action="product?action=saveEdit" method="post" enctype="multipart/form-data">
                            <input type="hidden" name="id" value="${requestScope.product.id}">

                            <div class="mb-3">
                                <label for="tenSanPham" class="form-label">Tên Sản Phẩm</label>
                                <input type="text" class="form-control" id="tenSanPham" name="tenSanPham" value="${requestScope.product.name}" required>
                            </div>

                            <div class="mb-3">
                                <label for="moTa" class="form-label">Mô tả</label>
                                <textarea class="form-control" id="moTa" name="moTa" rows="4">${requestScope.product.description}</textarea>
                            </div>                          

                            <div class="row mb-3">
                                <div class="col">
                                    <label for="giaBan" class="form-label">Giá Bán</label>
                                    <input type="number" class="form-control" id="giaBan" name="giaBan" required>                                    
                                    <script>
                                        var giaBanValue = "${requestScope.product.price}";
                                        var giaBanNumber = parseFloat(giaBanValue);
                                        document.getElementById("giaBan").value = giaBanNumber;
                                    </script>
                                </div>
                                <div class="col">
                                    <label for="soLuong" class="form-label">Số Lượng</label>
                                    <input type="number" class="form-control" value="${requestScope.inventory.stockQuantity}" id="soLuong" name="soLuong" required>
                                </div>
                            </div>

                            <div class="mb-3">
                                <label for="anhDaiDien" class="form-label">Ảnh Đại Diện</label>
                                <input type="file" class="form-control" id="imageInput" name="anhDaiDien" accept="image/*">
                                <div id="imagePreview" class="preview-image mt-4">
                                    <img src="../images/${requestScope.product.image}" class="img-thumbnail" style="width: 200px; height: 200px; object-fit: contain" />
                                </div>
                            </div>

                            <div class="mb-3">
                                <label for="anhSanPham" class="form-label">Ảnh Sản Phẩm</label>
                                <input type="hidden" id="arrayListInput" name="arrayListInput">
                                <input type="file" class="form-control" id="imageInputs" name="anhSanPham" accept="image/*" multiple>
                                <div id="imagePreviews" class="d-flex flex-wrap mt-4 gap-4">
                                    <c:forEach items="${requestScope.listImageProduct}" var="i">
                                        <div class="d-flex flex-column gap-4"> 
                                            <img src="../images/${i.url}" class="img-thumbnail" style="width: 200px; height: 200px; object-fit: contain" /> 
                                            <button class="btn btn-danger delete">Xóa</button>
                                        </div>
                                    </c:forEach>
                                </div>
                            </div>
                            <input type="hidden" name="categoryIdOld" value="${requestScope.category.id}">

                            <div class="mb-3">
                                <label for="category" class="form-label">Category</label>
                                <select class="form-select" id="category" name="categoryId">
                                    <c:forEach items="${sessionScope.listCategory}" var="o">
                                        <c:choose>
                                            <c:when test="${o.id == requestScope.category.id}">                                                
                                                <option value="${o.id}" selected="selected">${o.name}</option>
                                            </c:when>
                                            <c:otherwise>
                                                <option value="${o.id}">${o.name}</option>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:forEach>
                                </select>
                            </div>  

                            <input type="hidden" name="inventoryId" value="${requestScope.inventory.id}"><!-- comment -->

                            <div class="row mb-3">
                                <div class="col">
                                    <label for="size" class="form-label">Kích cỡ</label>
                                    <select class="form-select" name="size" id="size">
                                        <option value="S" ${requestScope.inventory.productOption.size == 'S' ? 'selected="selected"' : ''}>S</option>
                                        <option value="M" ${requestScope.inventory.productOption.size == 'M' ? 'selected="selected"' : ''}>M</option>
                                        <option value="L" ${requestScope.inventory.productOption.size == 'L' ? 'selected="selected"' : ''}>L</option>
                                        <option value="XL" ${requestScope.inventory.productOption.size == 'XL' ? 'selected="selected"' : ''}>XL</option>
                                        <option value="XXL" ${requestScope.inventory.productOption.size == 'XXL' ? 'selected="selected"' : ''}>XXL</option>
                                    </select>

                                </div>
                                <div class="col">
                                    <label for="mauSac" class="form-label">Màu sắc</label>
                                    <input type="text" class="form-control" id="mauSac" name="mauSac" value="${requestScope.inventory.productOption.color}" required>
                                </div>
                            </div>                            

                            <button type="submit" class="btn btn-success">Save</button>
                            <a class="btn btn-secondary m-4" href="product">
                                <i class="ri-arrow-left-s-line"></i> Back
                            </a>
                        </form>
                    </c:if>


                    <!--hien thi danh sach san pham-->
                    <c:if test="${sessionScope.create == null && sessionScope.edit == null}">
                        <div class="table-responsive">
                            <table class="table table-bordered">
                                <thead>
                                    <tr>
                                        <th>TT</th>
                                        <th>Hình ảnh</th>
                                        <th>Tên SP</th>
                                        <th>Danh Mục</th>
                                        <th>Đơn giá</th>   
                                        <th>Màu sắc</th>
                                        <th>Kích cỡ</th>
                                        <th>Số lượng</th>
                                        <th>Action</th>
                                    </tr>
                                </thead>
                                <tbody>      
                                    <c:set var="cnt" value="${requestScope.startItem}" />
                                    <c:forEach items="${requestScope.listItemsPerPage}" var="p" >
                                        <c:forEach items="${p.inventory}" var="i"> 
                                            <tr>
                                                <td>${cnt}</td>
                                                <c:set var="cnt" value="${cnt + 1}"/>
                                                <td>
                                                    <img src="../images/${p.image}" alt="anh" width="100px" height="100px" style="object-fit: contain" />
                                                </td>
                                                <td>${p.name}</td>
                                                <td>${categoryMap[p.id].name}</td>                                                                                       
                                                <fmt:formatNumber value="${p.price}" type="currency" currencyCode="VND" var="formattedPrice" pattern="#,##0" />
                                                <td>${formattedPrice}</td>  
                                                <td>${i.productOption.color}</td>
                                                <td>${i.productOption.size}</td>
                                                <td>${i.stockQuantity}</td>
                                                <td>
                                                    <a href="product?pid=${p.id}&poid=${i.productOption.id}&action=edit" class="btn btn-primary">
                                                        <i class="fas fa-edit"></i>
                                                    </a>
                                                    <a href="product?pid=${p.id}&action=delete" class="btn btn-danger">
                                                        <i class="fas fa-trash"></i>
                                                    </a>
                                                </td>
                                            </tr>    
                                        </c:forEach>
                                    </c:forEach>
                                </tbody>
                            </table>
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
                    </c:if>

                </div>
                <!--  -->
            </div>
            <!-- Content End -->


            <!-- Back to Top -->
            <a href="#" class="btn btn-lg btn-primary btn-lg-square back-to-top"><i class="bi bi-arrow-up"></i></a>
        </div>

        <script>
            const imageInput = document.getElementById('imageInput');
            const imagePreview = document.getElementById('imagePreview');
            imageInput.addEventListener('change', function () {
                const file = imageInput.files[0];
                if (file) {
                    const reader = new FileReader();
                    reader.onload = function (e) {
                        const img = new Image();
                        img.src = e.target.result;
                        img.classList.add('preview-image'); // Thêm lớp Bootstrap
                        imagePreview.innerHTML = '';
                        imagePreview.appendChild(img);
                    };
                    reader.readAsDataURL(file);
                } else {
                    imagePreview.innerHTML = 'Chưa chọn hình ảnh.';
                }
            });

            const imageInputs = document.getElementById('imageInputs');
            const imagePreviews = document.getElementById('imagePreviews');

            imageInputs.addEventListener('change', function () {
                // Xóa tất cả hình ảnh hiện tại
                imagePreviews.innerHTML = '';
                const files = imageInputs.files;
                const newFiles = Array.from(files); // Sao chép danh sách tệp

                for (let i = 0; i < files.length; i++) {
                    const file = files[i];
                    if (file) {
                        const reader = new FileReader();
                        reader.onload = function (e) {
                            const img = new Image();
                            img.src = e.target.result;
                            img.classList.add('img-thumbnail'); // Thêm lớp Bootstrap
                            img.style.width = "200px";
                            img.style.height = "200px";
                            img.style.objectFit = "contain";
                            // Tạo một nút để xóa hình ảnh
                            const deleteButton = document.createElement('button');
                            deleteButton.classList.add('btn', 'btn-danger', 'btn-sm');
                            deleteButton.textContent = 'Xóa';
                            // Hiển thị hình ảnh và nút xóa
                            const imageContainer = document.createElement('div');
                            imageContainer.classList.add('d-flex', 'flex-column', "gap-4");
                            imageContainer.appendChild(img);
                            imageContainer.appendChild(deleteButton);
                            imagePreviews.appendChild(imageContainer);
                            // Thêm sự kiện xóa cho nút xóa này
                            deleteButton.addEventListener('click', function () {
                                // Xác định vị trí của phần tử đang xử lý
                                const index = newFiles.indexOf(file);
                                if (index !== -1) {
                                    // Xóa phần tử khỏi mảng
                                    newFiles.splice(index, 1);
                                    // Tạo một đối tượng DataTransfer và gán danh sách tệp mới vào đó
                                    const dataTransfer = new DataTransfer();
                                    newFiles.forEach(function (file) {
                                        dataTransfer.items.add(file);
                                    });
                                    // Đặt lại giá trị của input với danh sách tệp mới
                                    imageInputs.value = null;
                                    imageInputs.files = dataTransfer.files;
                                }

                                // Xóa phần tử chứa hình ảnh và nút xóa
                                imageContainer.remove();
                            });
                        };
                        reader.readAsDataURL(file);
                    }
                }
            });

            const deleteButton = document.getElementsByClassName("delete");
            for (let i = 0; i < deleteButton.length; i++) {
                deleteButton[i].addEventListener("click", function () {
                    let parentElement = this.parentNode;
                    parentElement.remove();
                    console.log("xoa thanh cong" + i);
                });
            }

        </script>

        <!-- JavaScript Libraries -->
        <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>

        <!-- Template Javascript -->
        <script src="../js/admin/main.js"></script>  
    </body>
</html>
