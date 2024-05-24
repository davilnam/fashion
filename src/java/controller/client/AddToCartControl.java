/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.client;

import com.google.gson.Gson;
import dao.CategoryDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.net.URLEncoder;
import java.util.ArrayList;
import model.Category;
import model.Inventory;
import model.Product;
import model.ProductOption;
import com.google.gson.reflect.TypeToken;
import java.io.UnsupportedEncodingException;
import java.lang.reflect.Type;
import java.net.URLDecoder;

/**
 *
 * @author PC
 */
public class AddToCartControl extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet AddToCartControl</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AddToCartControl at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        ArrayList<Category> listCategory = (ArrayList<Category>) session.getAttribute("listCategory");
        if (listCategory == null) {
            CategoryDAO categoryDao = new CategoryDAO();
            listCategory = categoryDao.getAllCategory();
            session.setAttribute("listCategory", listCategory);
        }
        ArrayList<Product> cart = getCartFromCookie(request);
        if (cart == null) {
            cart = new ArrayList<>();
        }

        int productId = Integer.parseInt(request.getParameter("productId"));
        int soLuong = Integer.parseInt(request.getParameter("soLuong"));
        String size = request.getParameter("size");
        String color = request.getParameter("color");
        ProductOption po = new ProductOption(size, color);
        Inventory inventory = new Inventory(soLuong, po);
        ArrayList<Inventory> listInventory = new ArrayList<>();
        listInventory.add(inventory);
        Product product = new Product();
        product.setInventory(listInventory);
        for (Category category : listCategory) {
            ArrayList<Product> list = category.getProducts();
            for (Product p : list) {
                if (productId == p.getId()) {
                    product.setId(p.getId());
                    product.setImage(p.getImage());
                    product.setDescription(p.getDescription());
                    product.setPrice(p.getPrice());
                    product.setName(p.getName());
                    break;
                }
            }
        }
        boolean exists = false;
        for (Product tmp : cart) {
            if (tmp.getId() == productId) { // tồn tại trong giỏ hàng rồi thì chỉ cập nhật số lượng thôi
                Inventory it = tmp.getInventory().get(0);
                if (it.getProductOption().getColor().equals(color) && it.getProductOption().getSize().equals(size)) {
                    it.setStockQuantity(it.getStockQuantity() + soLuong);
                    exists = true;
                    break;
                }
            }
        }
        if (!exists) {
            cart.add(product);
        }        
       
        saveCartToCookie(cart, response);
        session.setAttribute("addToCartSuccess", "Sản phẩm đã được thêm vào giỏ hàng");
        response.sendRedirect("product-detail?id=" + productId);
    }

    private ArrayList<Product> getCartFromCookie(HttpServletRequest request) throws UnsupportedEncodingException {
        Cookie[] cookies = request.getCookies();
        ArrayList<Product> cart = new ArrayList<>();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals("cart")) {
                    String cartJson = URLDecoder.decode(cookie.getValue(), "UTF-8");
                    Type listType = new TypeToken<ArrayList<Product>>() {
                    }.getType();
                    cart = new Gson().fromJson(cartJson, listType);
                    break;
                }
            }
        }
        return cart;
    }

    private void saveCartToCookie(ArrayList<Product> cart, HttpServletResponse response) throws IOException {
        String cartJson = new Gson().toJson(cart);
        String cartCookie = URLEncoder.encode(cartJson, "UTF-8");
        Cookie cookie = new Cookie("cart", cartCookie);
        cookie.setMaxAge(24 * 60 * 60); // Cookie hết hạn sau 1 ngày
        response.addCookie(cookie);
        
        // Cập nhật số lượng sản phẩm trong giỏ hàng       
        Cookie cartSizeCookie = new Cookie("cartSize", Integer.toString(cart.size()));
        cartSizeCookie.setMaxAge(60 * 60 * 24); // 1 ngay
        response.addCookie(cartSizeCookie);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
