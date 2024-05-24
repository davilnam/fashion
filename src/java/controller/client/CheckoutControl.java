/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.client;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import dao.OrderDAO;
import dao.UserDAO;
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
import java.util.Date;
import model.Order;
import model.OrderDetail;
import model.PaymentMethod;
import model.Product;
import model.Status;
import model.User;

/**
 *
 * @author PC
 */
public class CheckoutControl extends HttpServlet {

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
            out.println("<title>Servlet CheckoutControl</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CheckoutControl at " + request.getContextPath() + "</h1>");
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
        request.setAttribute("cartSize", cart.size());
        request.setAttribute("cart", cart);
        request.getRequestDispatcher("client/checkout.jsp").forward(request, response);
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
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("acc");
        if (user == null) {
            session.setAttribute("loginRequired", "true");
            response.sendRedirect("checkout");
        } else {
            ArrayList<Product> cart = getCartFromCookie(request);
            ArrayList<OrderDetail> list = new ArrayList<>();
            for (Product p : cart) {
                OrderDetail od = new OrderDetail();
                od.setProduct(p);
                od.setPrice(p.getPrice());
                od.setQuantity(p.getInventory().get(0).getStockQuantity());
                list.add(od);
            }
            String fullName = request.getParameter("fullName");
            String note = request.getParameter("note");
            String phone = request.getParameter("phone");
            String address = request.getParameter("address");
            user.setAddress(address);
            user.setPhone(phone);
            user.setFullName(fullName);
            UserDAO userDao = new UserDAO();
            boolean c = userDao.updateInfo(user);
            
            Double totalAmount = Double.valueOf(request.getParameter("totalAmount"));
            int paymentMethod = Integer.parseInt(request.getParameter("paymentMethod"));
            Date orderDate = new Date();
            Order order = new Order();
            order.setNote(note);
            order.setTotalAmount(totalAmount);
            order.setOrderDetails(list);
            Status status = new Status(1, "đang xử lý");
            order.setStatus(status);
            PaymentMethod p = new PaymentMethod();
            p.setId(paymentMethod);
            order.setPaymentMethod(p);
            order.setOrderDate(orderDate);
            order.setUser(user);

            OrderDAO orderDao = new OrderDAO();
            boolean check = orderDao.addOrder(order);
            if (check) {
                cart.clear();
                saveCartToCookie(cart, response);                
                response.sendRedirect("thank-you");
            } else {
                session.setAttribute("error", "error");
                response.sendRedirect("checkout");
            }

        }
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
