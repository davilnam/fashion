/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.admin;

import dao.CategoryDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import model.Category;

/**
 *
 * @author PC
 */
public class CategoryManagerControl extends HttpServlet {

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
            out.println("<title>Servlet CategoryManagerControl</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CategoryManagerControl at " + request.getContextPath() + "</h1>");
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
        String action = request.getParameter("action");
        if (action == null) {
            action = "";
        }
        switch (action) {
            case "create" ->
                createCategory(request, response);
            case "edit" ->
                editCategory(request, response);
            case "delete" ->
                deleteCategory(request, response);
            default ->
                goCategoryList(request, response);
        }
    }

    private void createCategory(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        session.setAttribute("create", "create");
        session.removeAttribute("edit");
        request.setAttribute("managerCategory", "managerCategory"); // hiện thị active 
        request.getRequestDispatcher("category-manager.jsp").forward(request, response);
    }

    private void editCategory(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        session.setAttribute("edit", "edit");
        session.removeAttribute("create");
        int cid = Integer.parseInt(request.getParameter("cid"));
        ArrayList<Category> listCategory = (ArrayList<Category>) session.getAttribute("listCategory");
        for (Category c : listCategory) {
            if (c.getId() == cid) {
                request.setAttribute("category", c);
                request.setAttribute("managerCategory", "managerCategory"); // hiện thị active 
                request.getRequestDispatcher("category-manager.jsp").forward(request, response);
                break;
            }
        }
    }

    private void deleteCategory(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        CategoryDAO categoryDao = new CategoryDAO();
        int cid = Integer.parseInt(request.getParameter("cid"));
        categoryDao.deleteCategory(cid);
        response.sendRedirect("category");
    }

    private void goCategoryList(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        session.removeAttribute("create");
        session.removeAttribute("edit");

        CategoryDAO categoryDao = new CategoryDAO();
        ArrayList<Category> listCategory = categoryDao.getAllCategory();

        session.setAttribute("listCategory", listCategory);

        String text = (String) session.getAttribute("text"); // lay tu khoa cua nguoi dung nhap
        ArrayList<Category> listSearchCategory = (ArrayList<Category>) session.getAttribute("listSearchCategory");
        session.removeAttribute("listSearchCategory");
        session.removeAttribute("text");

        if (listSearchCategory != null && !listSearchCategory.isEmpty()) {
            listCategory = listSearchCategory;
        } else if (listSearchCategory != null && text != null) {
            listCategory = null;
        }

        int itemsPerPage = 5;
        int currentPage = 1;
        int totalItems = 0;
        if (listCategory != null) {
            totalItems = listCategory.size();
        }
        int totalPages = totalItems / itemsPerPage;
        if (totalItems % itemsPerPage != 0) {
            totalPages++;
        }

        if (request.getParameter("page") != null) {
            currentPage = Integer.parseInt(request.getParameter("page"));
        }
        int startItem = (currentPage - 1) * itemsPerPage;
        ArrayList<Category> listItemsPerPage = new ArrayList<>();
        for (int i = startItem; i < Math.min(startItem + itemsPerPage, totalItems); i++) {
            listItemsPerPage.add(listCategory.get(i));
        }

        request.setAttribute("text", text);
        request.setAttribute("startItem", startItem + 1);
        request.setAttribute("managerCategory", "managerCategory"); // hiện thị active 
        request.setAttribute("listItemsPerPage", listItemsPerPage);
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("totalPages", totalPages);
        request.getRequestDispatcher("category-manager.jsp").forward(request, response);
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
            case "saveCreate" ->
                saveNewCategory(request, response);
            case "saveEdit" ->
                saveEditCategory(request, response);
            case "search" ->
                searchDanhMuc(request, response);
            default ->
                goCategoryList(request, response);
        }
    }

    private void saveNewCategory(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        session.removeAttribute("create");
        session.removeAttribute("edit");
        String tenDanhMuc = request.getParameter("tenDanhMuc");
        CategoryDAO categoryDao = new CategoryDAO();
        categoryDao.addCategory(tenDanhMuc);
        response.sendRedirect("category");
    }

    private void saveEditCategory(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        session.removeAttribute("create");
        session.removeAttribute("edit");
        String tenDanhMuc = request.getParameter("tenDanhMuc");
        int cid = Integer.parseInt(request.getParameter("cid"));
        Category c = new Category();
        c.setId(cid);
        c.setName(tenDanhMuc);
        CategoryDAO categoryDao = new CategoryDAO();
        categoryDao.editCategory(c);
        response.sendRedirect("category");
    }

    private void searchDanhMuc(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        String text = request.getParameter("text");

        ArrayList<Category> listCategory = (ArrayList<Category>) session.getAttribute("listCategory");
        ArrayList<Category> tmp = new ArrayList<>();
        for (Category c : listCategory) {
            if (c.getName().contains(text)) {
                tmp.add(c);
            }
        }

        session.setAttribute("text", text); // lưu từ khóa của người dùng vào session
        session.setAttribute("listSearchCategory", tmp); // lưu danh sách kết quả tìm kiếm vào session
        response.sendRedirect("category");
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
