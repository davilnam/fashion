/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */


// Lấy tất cả các phần tử danh mục
var categories = document.querySelectorAll('.category-filter');

// Duyệt qua từng phần tử danh mục
categories.forEach(function (category) {
    // Thêm sự kiện click cho mỗi phần tử danh mục
    category.addEventListener('click', function () {
        // Loại bỏ lớp 'active' từ tất cả các phần tử danh mục        
        categories.forEach(function (c) {
            c.classList.remove('active');
        });
        // Thêm lớp 'active' cho phần tử danh mục được nhấp vào
        category.classList.add('active');
    });
});

