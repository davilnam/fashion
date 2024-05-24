/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.client;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.UnsupportedEncodingException;
import java.lang.reflect.Type;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.ArrayList;
import model.Product;

/**
 *
 * @author PC
 */
public class CartControl extends HttpServlet {

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
            out.println("<title>Servlet CartControl</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CartControl at " + request.getContextPath() + "</h1>");
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
        ArrayList<Product> cart = getCartFromCookie(request);
        request.setAttribute("cart", cart);
        request.setAttribute("cartSize", cart.size());
        request.getRequestDispatcher("client/cart.jsp").forward(request, response);
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
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            action = "";
        }
        switch (action) {
            case "remove" ->
                removeItem(request, response);
            case "change" ->
                changeItem(request, response);
        }
    }

    private void removeItem(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int productId = Integer.parseInt(request.getParameter("productId"));
        ArrayList<Product> cart = getCartFromCookie(request);
        for (int i = 0; i < cart.size(); i++) {
            Product p = cart.get(i);
            if (p.getId() == productId) {
                cart.remove(i);
                break;
            }
        }
        saveCartToCookie(cart, response);
        response.sendRedirect("cart");
    }

    private void changeItem(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int productId = Integer.parseInt(request.getParameter("productId"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        ArrayList<Product> cart = getCartFromCookie(request);
        for (int i = 0; i < cart.size(); i++) {
            Product p = cart.get(i);
            if (p.getId() == productId) {                
                p.getInventory().get(0).setStockQuantity(quantity);
                break;
            }
        }
        saveCartToCookie(cart, response);
        response.sendRedirect("cart");
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
