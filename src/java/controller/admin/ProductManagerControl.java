/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.admin;

import dao.CategoryDAO;
import dao.ProductDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.Map;
import model.Category;
import model.Inventory;
import model.Product;
import model.ProductImage;
import model.ProductOption;
import jakarta.servlet.annotation.MultipartConfig;

/**
 *
 * @author PC
 */
@MultipartConfig
public class ProductManagerControl extends HttpServlet {

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
            out.println("<title>Servlet ProductManagerControl</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ProductManagerControl at " + request.getContextPath() + "</h1>");
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
                createProduct(request, response);
            case "edit" ->
                editProduct(request, response);
            case "delete" ->
                deleteProduct(request, response);
            default ->
                goProductList(request, response);
        }
    }

    private void goProductList(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        session.removeAttribute("create");
        session.removeAttribute("edit");
        ArrayList<Category> listCategory;

        String begin = (String) session.getAttribute("begin"); // danh dau de lay du lieu tu csdl neu la lan dau;
        if (begin == null) {
            listCategory = new CategoryDAO().getAllCategory();
            session.setAttribute("listCategory", listCategory);
        } else {
            listCategory = (ArrayList<Category>) session.getAttribute("listCategory");
        }
        session.setAttribute("begin", "begin"); // dau dau de tu lan sau lay trong session ko phai goi lai tu csdl

        String text = (String) session.getAttribute("text"); // lay ra tu khoa nguoi dung tim kiem neu co
        session.removeAttribute("text");

        ArrayList<Product> listProduct = new ArrayList<>();
        Map<Integer, Category> categoryMap = new HashMap<>();
        for (Category category : listCategory) {
            for (Product product : category.getProducts()) {
                categoryMap.put(product.getId(), category);
                listProduct.add(product);
            }
        }
        session.setAttribute("categoryMap", categoryMap);

        // phân trang 
        int itemsPerPage = 5;
        int currentPage = 1;
        int totalItems = 0;
        if (listProduct != null) {
            totalItems = listProduct.size();
        }
        int totalPages = totalItems / itemsPerPage;
        if (totalItems % itemsPerPage != 0) {
            totalPages++;
        }
        if (request.getParameter("page") != null) {
            currentPage = Integer.parseInt(request.getParameter("page"));
        }
        int startItem = (currentPage - 1) * itemsPerPage;
        ArrayList<Product> listItemsPerPage = new ArrayList<>();
        for (int i = startItem; i < Math.min(startItem + itemsPerPage, totalItems); i++) {
            listItemsPerPage.add(listProduct.get(i));
        }

        request.setAttribute("text", text);
        request.setAttribute("startItem", startItem + 1);
        request.setAttribute("managerProduct", "managerProduct"); // hiện thị active 
        request.setAttribute("listItemsPerPage", listItemsPerPage);
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("totalPages", totalPages);

        request.getRequestDispatcher("product-manager.jsp").forward(request, response);
    }

    private void createProduct(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        session.setAttribute("create", "create");
        session.removeAttribute("edit");
        request.setAttribute("managerProduct", "managerProduct"); // hiện thị active 
        request.getRequestDispatcher("product-manager.jsp").forward(request, response);
    }

    private void editProduct(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        session.setAttribute("edit", "edit");
        session.removeAttribute("create");
        ArrayList<Category> listCategory = (ArrayList<Category>) session.getAttribute("listCategory");

        int pid = Integer.parseInt(request.getParameter("pid"));
        int productOptionId = Integer.parseInt(request.getParameter("poid"));
        Product product = null;
        Category category = null;
        for (Category c : listCategory) {
            for (Product p : c.getProducts()) {
                if (p.getId() == pid) {
                    product = new Product(p);
                    category = new Category(c);
                    break;
                }
            }
        }

        ArrayList<ProductImage> listImageProduct = product.getProductImages();
        ArrayList<Inventory> listInventory = product.getInventory();
        Inventory inventory = null;
        for (Inventory i : listInventory) {
            if (i.getProductOption().getId() == productOptionId) {
                inventory = new Inventory(i);
            }
        }

        request.setAttribute("category", category);
        request.setAttribute("product", product);
        request.setAttribute("inventory", inventory);
        request.setAttribute("managerProduct", "managerProduct"); // hiện thị active 
        request.setAttribute("listImageProduct", listImageProduct);
        request.getRequestDispatcher("product-manager.jsp").forward(request, response);
    }

    private void deleteProduct(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        ArrayList<Category> listCategory = (ArrayList<Category>) session.getAttribute("listCategory");
        int pid = Integer.parseInt(request.getParameter("pid"));

//        for (Category c : listCategory) {
//            for (Product p : c.getProducts()) {
//                if (p.getId() == pid) {
//                    c.getProducts().remove(p);                    
//                    break;
//                }
//            }
//        }
        ProductDAO productDao = new ProductDAO();
        productDao.deleteProduct(pid);
        session.removeAttribute("begin");
        response.sendRedirect("product");
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
                saveNewProduct(request, response);
            case "saveEdit" ->
                saveEditProduct(request, response);
            case "search" ->
                searchSanPham(request, response);
            default ->
                goProductList(request, response);
        }
    }

    private void searchSanPham(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String text = request.getParameter("text").toLowerCase();
        HttpSession session = request.getSession();
        session.setAttribute("text", text); // luu tu khoa nguoi dung tim kiem

//        // lay ra listCategory trong session
//        ArrayList<Category> listCategory = (ArrayList<Category>) session.getAttribute("listCategory");
//        ArrayList<Category> tmp = new ArrayList<>();
//
//        // tien hanh loc cac san pham chu tu khoa
//        Category c;
//        for (int i = 0; i < listCategory.size(); i++) {
//            c = listCategory.get(i);
//            ArrayList<Product> listProduct = c.getProducts();
//            ArrayList<Product> tmp1 = new ArrayList<>();
//            for (int j = 0; j < listProduct.size(); j++) {
//                Product p = listProduct.get(j);
//                if (p.getName().contains(text)) {
//                    tmp1.add(p);
//                }
//            }
//            c.setProducts(tmp1);
//            tmp.add(c);
//        }
//       session.setAttribute("listSearch", tmp);
//        //cap nhat lai danh sach;        
        response.sendRedirect("product");
    }

    private void saveNewProduct(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        session.removeAttribute("create");

        ArrayList<Category> listCategory = (ArrayList<Category>) session.getAttribute("listCategory");
        Product p = new Product();
        // lay cac gia tri tu form gui qua
        String tenSanPham = request.getParameter("tenSanPham").trim();
        p.setName(tenSanPham);

        String moTa = request.getParameter("moTa").trim();
        p.setDescription(moTa);

        double giaBan = Double.parseDouble(request.getParameter("giaBan"));
        p.setPrice(giaBan);

        int soLuong = Integer.parseInt(request.getParameter("soLuong"));
        Inventory inventory = new Inventory();
        inventory.setStockQuantity(soLuong);

        String size = request.getParameter("size").trim();
        String mauSac = request.getParameter("mauSac").trim();
        ProductOption po = new ProductOption(size, mauSac);

        inventory.setProductOption(po);
        ArrayList<Inventory> listInventory = new ArrayList<>();
        listInventory.add(inventory);
        p.setInventory(listInventory);

        // lay anh
        Collection<Part> parts = request.getParts();
        ArrayList<String> list = new ArrayList<>();
        for (Part part : parts) {
            if (part.getSubmittedFileName() != null) {
                String fileName = Paths.get(part.getSubmittedFileName()).getFileName().toString();
                list.add(fileName);
            }
        }
        String anhDaiDien = list.get(0);
        p.setImage(anhDaiDien);

        list.remove(0);
        ArrayList<ProductImage> listProductImages = new ArrayList<>();
        for (int i = 0; i < list.size(); i++) {
            ProductImage pi = new ProductImage();
            pi.setUrl(list.get(i));
            listProductImages.add(pi);
        }
        p.setProductImages(listProductImages);

        int categoryId = Integer.parseInt(request.getParameter("categoryId"));
        for (Category category : listCategory) {
            if (category.getId() == categoryId) {
                category.getProducts().add(p);
            }
        }

        // cap nhat lai listCategory trong session
        session.setAttribute("listCategory", listCategory);

        ProductDAO productDao = new ProductDAO();
        productDao.addProduct(p, categoryId);
        response.sendRedirect("product");
    }

    private void saveEditProduct(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        session.removeAttribute("create");
        int id = Integer.parseInt(request.getParameter("id"));

        ArrayList<Category> listCategory = (ArrayList<Category>) session.getAttribute("listCategory");
        Product product = null;
        for (Category c : listCategory) {
            for (Product p : c.getProducts()) {
                if (p.getId() == id) {
                    product = p;
                    break;
                }
            }
        }
        // lay cac gia tri tu form gui qua
        String tenSanPham = request.getParameter("tenSanPham").trim();
        product.setName(tenSanPham);

        String moTa = request.getParameter("moTa").trim();
        product.setDescription(moTa);

        double giaBan = Double.parseDouble(request.getParameter("giaBan"));
        product.setPrice(giaBan);

        
        int soLuong = Integer.parseInt(request.getParameter("soLuong"));
        int inventoryId = Integer.parseInt(request.getParameter("inventoryId"));
        Inventory inventory = null;
        for(Inventory i : product.getInventory()){
            if(i.getId() == inventoryId){
                inventory = i;
            }
        }
        inventory.setStockQuantity(soLuong);

        String size = request.getParameter("size").trim();
        String mauSac = request.getParameter("mauSac").trim();
        ProductOption po = inventory.getProductOption();
        po.setColor(mauSac);
        po.setSize(size);
       

        // lay anh
        Collection<Part> parts = request.getParts();
        ArrayList<String> list = new ArrayList<>();
        for (Part part : parts) {
            if (part.getSubmittedFileName() != null) {
                String fileName = Paths.get(part.getSubmittedFileName()).getFileName().toString();
                list.add(fileName);
            }
        }
        String anhDaiDien = list.get(0);
        if (anhDaiDien != null && !anhDaiDien.equals("")) {
            product.setImage(anhDaiDien);
        }

        list.remove(0);
        ArrayList<ProductImage> listProductImages = new ArrayList<>();
        for (int i = 0; i < list.size();) {
            if (list.get(i).equals("")) {
                list.remove(i);
            } else {
                ProductImage pi = new ProductImage();
                pi.setUrl(list.get(i));
                listProductImages.add(pi);
                i++;
            }

        }
        if (!listProductImages.isEmpty()) {
            product.setProductImages(listProductImages);
        }

        int categoryId = Integer.parseInt(request.getParameter("categoryId"));
        int categoryIdOld = Integer.parseInt(request.getParameter("categoryIdOld"));
        if (categoryId != categoryIdOld) {
            for (Category category : listCategory) {
                if (category.getId() == categoryIdOld) {
                    for (int i = 0; i < category.getProducts().size(); i++) {
                        Product p = category.getProducts().get(i);
                        if (p.getId() == id) {
                            category.getProducts().remove(i);
                        }
                    }
                } else if (category.getId() == categoryId) {
                    category.getProducts().add(product);
                }
            }

        }

        // cap nhat lai listCategory trong session
        session.setAttribute(
                "listCategory", listCategory);

        //cap nhat trong csdl
        ProductDAO productDao = new ProductDAO();
        productDao.editProduct(product, categoryId);
        response.sendRedirect("product");
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
