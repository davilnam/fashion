/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */


function removeProduct(productId) {
    fetch('cart?action=remove', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: 'productId=' + encodeURIComponent(productId)
    })
    .then(function(response) {
        console.log(response);
        if (response.ok) {              
            window.location.reload();
            console.log("thanh cong");
        } else {
            console.error('Xóa sản phẩm không thành công');
        }
    })
    .catch(function(error) {
        console.error('Lỗi:', error);
    });
}

function changeItem(input) {
    let quantity = input.value;
    var productId = input.getAttribute('data-product-id');
    fetch('cart?action=change', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: 'productId=' + encodeURIComponent(productId) + '&quantity=' + encodeURIComponent(quantity)
    })
    .then(function(response) {
        console.log(response);
        if (response.ok) {              
            window.location.reload();
            console.log("thanh cong");
        } else {
            console.error('Xóa sản phẩm không thành công');
        }
    })
    .catch(function(error) {
        console.error('Lỗi:', error);
    });
}