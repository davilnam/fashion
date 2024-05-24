/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import model.Inventory;
import model.Product;
import model.ProductImage;
import model.ProductOption;

/**
 *
 * @author PC
 */
public class ProductDAO extends DAO {

    public ProductDAO() {
        super();
    }

    public ArrayList<Product> getAllProduct() {
        try {
            String sql = "select * from tblProduct";
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            ArrayList<Product> list = new ArrayList<>();
            while (rs.next()) {
                Product p = new Product();
                int id = rs.getInt("id"); // id san pham
                p.setId(id);
                p.setName(rs.getString("name"));
                p.setDescription(rs.getString("description"));
                p.setPrice(rs.getDouble("price"));
                p.setImage(rs.getString("image"));

                ArrayList<ProductImage> listProductImages = new ProductImageDAO().getAllProductImageByPid(id); // ds hinh anh lien quan                
                p.setProductImages(listProductImages);

                ArrayList<Inventory> listInventory = new InventoryDAO().getAllInventoryByPid(id);
                p.setInventory(listInventory);

                list.add(p);
            }
            return list;
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public ArrayList<Product> getProductTop8(){
        try {
            String sql = "select top 8 * from tblProduct";
            PreparedStatement st = connection.prepareStatement(sql);            
            ResultSet rs = st.executeQuery();
            ArrayList<Product> list = new ArrayList<>();
            while (rs.next()) {
                Product p = new Product();
                int id = rs.getInt("id"); // id san pham
                p.setId(id);
                p.setName(rs.getString("name"));
                p.setDescription(rs.getString("description"));
                p.setPrice(rs.getDouble("price"));
                p.setImage(rs.getString("image"));

                ArrayList<ProductImage> listProductImages = new ArrayList<>(); // ds hinh anh lien quan
                String sql1 = "select id, url from tblProductImage where productId = ?";
                PreparedStatement st1 = connection.prepareStatement(sql1);
                st1.setInt(1, id);
                ResultSet rs1 = st1.executeQuery();
                while (rs1.next()) {
                    ProductImage productImage = new ProductImage(rs1.getInt("id"), rs1.getString("url"));
                    listProductImages.add(productImage);
                }
                p.setProductImages(listProductImages);

                ArrayList<Inventory> listInventory = new ArrayList<>();
                String sql2 = "select id, productOptionId, stockQuantity from tblInventory where productId = ?";
                PreparedStatement st2 = connection.prepareStatement(sql2);
                st2.setInt(1, id);
                ResultSet rs2 = st2.executeQuery();
                while (rs2.next()) {
                    Inventory inventory = new Inventory();
                    inventory.setId(rs2.getInt("id"));
                    inventory.setStockQuantity(rs2.getInt("stockQuantity"));
                    int productOptionId = rs2.getInt("productOptionId");

                    String sql3 = "select id, size, color from tblProductOption where id = ?";
                    PreparedStatement st3 = connection.prepareStatement(sql3);
                    st3.setInt(1, productOptionId);
                    ResultSet rs3 = st3.executeQuery();
                    ProductOption productOption = new ProductOption();
                    if (rs3.next()) {
                        productOption.setId(productOptionId);
                        productOption.setSize(rs3.getString("size"));
                        productOption.setColor(rs3.getString("color"));
                    }
                    inventory.setProductOption(productOption);
                    listInventory.add(inventory);
                }
                p.setInventory(listInventory);

                list.add(p);
            }
            return list;
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }
    public Product getProductById(int id) {
        try {
            String sql = "select * from tblProduct where id = ?";
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            Product p = new Product();                
            while (rs.next()) {                
                p.setId(id);
                p.setName(rs.getString("name"));
                p.setDescription(rs.getString("description"));
                p.setPrice(rs.getDouble("price"));
                p.setImage(rs.getString("image"));
                
                ArrayList<ProductImage> listProductImages = new ArrayList<>(); // ds hinh anh lien quan
                String sql1 = "select id, url from tblProductImage where productId = ?";
                PreparedStatement st1 = connection.prepareStatement(sql1);
                st1.setInt(1, id);
                ResultSet rs1 = st1.executeQuery();
                while (rs1.next()) {
                    ProductImage productImage = new ProductImage(rs1.getInt("id"), rs1.getString("url"));
                    listProductImages.add(productImage);
                }
                p.setProductImages(listProductImages);

                ArrayList<Inventory> listInventory = new ArrayList<>();
                String sql2 = "select id, productOptionId, stockQuantity from tblInventory where productId = ?";
                PreparedStatement st2 = connection.prepareStatement(sql2);
                st2.setInt(1, id);
                ResultSet rs2 = st2.executeQuery();
                while (rs2.next()) {
                    Inventory inventory = new Inventory();
                    inventory.setId(rs2.getInt("id"));
                    inventory.setStockQuantity(rs2.getInt("stockQuantity"));
                    int productOptionId = rs2.getInt("productOptionId");

                    String sql3 = "select id, size, color from tblProductOption where id = ?";
                    PreparedStatement st3 = connection.prepareStatement(sql3);
                    st3.setInt(1, productOptionId);
                    ResultSet rs3 = st3.executeQuery();
                    ProductOption productOption = new ProductOption();
                    if (rs3.next()) {
                        productOption.setId(productOptionId);
                        productOption.setSize(rs3.getString("size"));
                        productOption.setColor(rs3.getString("color"));
                    }
                    inventory.setProductOption(productOption);
                    listInventory.add(inventory);
                }
                p.setInventory(listInventory);

                return p;
            }
            
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }
    
    public ArrayList<Product> getAllProductByCid(int categoryId) {
        try {
            String sql = "select * from tblProduct where categoryId = ?";
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, categoryId);
            ResultSet rs = st.executeQuery();
            ArrayList<Product> list = new ArrayList<>();
            while (rs.next()) {
                Product p = new Product();
                int id = rs.getInt("id"); // id san pham
                p.setId(id);
                p.setName(rs.getString("name"));
                p.setDescription(rs.getString("description"));
                p.setPrice(rs.getDouble("price"));
                p.setImage(rs.getString("image"));

                ArrayList<ProductImage> listProductImages = new ArrayList<>(); // ds hinh anh lien quan
                String sql1 = "select id, url from tblProductImage where productId = ?";
                PreparedStatement st1 = connection.prepareStatement(sql1);
                st1.setInt(1, id);
                ResultSet rs1 = st1.executeQuery();
                while (rs1.next()) {
                    ProductImage productImage = new ProductImage(rs1.getInt("id"), rs1.getString("url"));
                    listProductImages.add(productImage);
                }
                p.setProductImages(listProductImages);

                ArrayList<Inventory> listInventory = new ArrayList<>();
                String sql2 = "select id, productOptionId, stockQuantity from tblInventory where productId = ?";
                PreparedStatement st2 = connection.prepareStatement(sql2);
                st2.setInt(1, id);
                ResultSet rs2 = st2.executeQuery();
                while (rs2.next()) {
                    Inventory inventory = new Inventory();
                    inventory.setId(rs2.getInt("id"));
                    inventory.setStockQuantity(rs2.getInt("stockQuantity"));
                    int productOptionId = rs2.getInt("productOptionId");

                    String sql3 = "select id, size, color from tblProductOption where id = ?";
                    PreparedStatement st3 = connection.prepareStatement(sql3);
                    st3.setInt(1, productOptionId);
                    ResultSet rs3 = st3.executeQuery();
                    ProductOption productOption = new ProductOption();
                    if (rs3.next()) {
                        productOption.setId(productOptionId);
                        productOption.setSize(rs3.getString("size"));
                        productOption.setColor(rs3.getString("color"));
                    }
                    inventory.setProductOption(productOption);
                    listInventory.add(inventory);
                }
                p.setInventory(listInventory);

                list.add(p);
            }
            return list;
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public int getCategoryIdByPId(int productId) {
        try {
            String sql = "select categoryId from tblProduct where id = ?";
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, productId);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return rs.getInt("categoryId");
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return 0;
    }

    public void addProduct(Product p, int categoryId) {
        try {
            connection.setAutoCommit(false); // Disable auto-commit                       

            String sql = "INSERT INTO tblProduct(name, image, description, price, categoryId) VALUES(?, ?, ?, ?, ?)";
            PreparedStatement st = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            st.setString(1, p.getName());
            st.setString(2, p.getImage());
            st.setString(3, p.getDescription());
            st.setDouble(4, p.getPrice());
            st.setInt(5, categoryId);
            st.executeUpdate();

            // Get the generated product ID
            ResultSet generatedKeys = st.getGeneratedKeys();
            int productId = -1;
            if (generatedKeys.next()) {
                productId = generatedKeys.getInt(1);
            }
            generatedKeys.close();
            st.close();

            ArrayList<ProductImage> listProductImage = p.getProductImages();
            for (ProductImage pi : listProductImage) {
                String sql1 = "INSERT INTO tblProductImage(url, productId) VALUES(?, ?)";
                PreparedStatement st1 = connection.prepareStatement(sql1);
                st1.setString(1, pi.getUrl());
                st1.setInt(2, productId);
                st1.executeUpdate();
                st1.close();
            }

            ArrayList<Inventory> listInventory = p.getInventory();
            for (Inventory inventory : listInventory) {
                ProductOption po = inventory.getProductOption();

                String sql2 = "INSERT INTO tblProductOption(size, color) VALUES(?, ?)";
                PreparedStatement st2 = connection.prepareStatement(sql2, Statement.RETURN_GENERATED_KEYS);
                st2.setString(1, po.getSize());
                st2.setString(2, po.getColor());
                st2.executeUpdate();

                // Get the generated productOption ID
                ResultSet generatedKeys2 = st2.getGeneratedKeys();
                int productOptionId = -1;
                if (generatedKeys2.next()) {
                    productOptionId = generatedKeys2.getInt(1);
                }
                generatedKeys2.close();
                st2.close();

                po.setId(productOptionId);
                inventory.setProductOption(po);

                String sql3 = "INSERT INTO tblInventory(productId, productOptionId, stockQuantity) VALUES(?, ?, ?)";
                PreparedStatement st3 = connection.prepareStatement(sql3);
                st3.setInt(1, productId);
                st3.setInt(2, inventory.getProductOption().getId());
                st3.setInt(3, inventory.getStockQuantity());
                st3.executeUpdate();
                st3.close();
            }

            connection.commit();
        } catch (SQLException e) {
            if (connection != null) {
                try {
                    connection.rollback(); // Rollback if any error occurs
                } catch (SQLException ex) {
                    System.out.println("Error during rollback: " + ex.getMessage());
                }
            }
            System.out.println("Error during data insertion: " + e.getMessage());
        } finally {
            if (connection != null) {
                try {
                    connection.setAutoCommit(true); // Re-enable auto-commit
                } catch (SQLException ex) {
                    System.out.println("Error re-enabling auto-commit: " + ex.getMessage());
                }
            }
        }
    }

    public void editProduct(Product p, int categoryId) {
        try {
            connection.setAutoCommit(false); // Disable auto-commit

            // Lấy categoryId từ productId            

            // Cập nhật sản phẩm
            String sql = "update tblProduct set name = ?, image = ?, description = ?, price = ?, categoryId = ? where id = ?";
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, p.getName());
            st.setString(2, p.getImage());
            st.setString(3, p.getDescription());
            st.setDouble(4, p.getPrice());
            st.setInt(5, categoryId);
            st.setInt(6, p.getId());
            st.executeUpdate();
            st.close();

            // Cập nhật hình ảnh sản phẩm
            ArrayList<ProductImage> listProductImage = p.getProductImages();
            if (listProductImage != null && !listProductImage.isEmpty()) {
                for (ProductImage pi : listProductImage) {
                    String sql1 = "update tblProductImage set url = ? where id = ?";
                    PreparedStatement st1 = connection.prepareStatement(sql1);
                    st1.setString(1, pi.getUrl());
                    st1.setInt(2, pi.getId());
                    st1.executeUpdate();
                    st1.close();
                }
            }

            // Cập nhật inventory và product options
            ArrayList<Inventory> listInventory = p.getInventory();
            if (listInventory != null && !listInventory.isEmpty()) {
                for (Inventory inventory : listInventory) {
                    ProductOption po = inventory.getProductOption();

                    // Cập nhật product option
                    String sql2 = "update tblProductOption set size = ?, color = ? where id = ?";
                    PreparedStatement st2 = connection.prepareStatement(sql2);
                    st2.setString(1, po.getSize());
                    st2.setString(2, po.getColor());
                    st2.setInt(3, po.getId());
                    st2.executeUpdate();
                    st2.close();

                    // Cập nhật inventory
                    String sql3 = "update tblInventory set stockQuantity = ? where id = ?";
                    PreparedStatement st3 = connection.prepareStatement(sql3);
                    st3.setInt(1, inventory.getStockQuantity());
                    st3.setInt(2, inventory.getId());
                    st3.executeUpdate();
                    st3.close();
                }
            }

            connection.commit();
        } catch (SQLException e) {
            if (connection != null) {
                try {
                    connection.rollback(); // Rollback if any error occurs
                } catch (SQLException ex) {
                    System.out.println("Error during rollback: " + ex.getMessage());
                }
            }
            System.out.println("Error during data update: " + e.getMessage());
        } finally {
            if (connection != null) {
                try {
                    connection.setAutoCommit(true); // Re-enable auto-commit
                } catch (SQLException ex) {
                    System.out.println("Error re-enabling auto-commit: " + ex.getMessage());
                }
            }
        }
    }

    public void deleteProduct(int productId) {
        try {
            connection.setAutoCommit(false); // Bắt đầu giao dịch

            // Xóa hình ảnh sản phẩm trước
            String sql2 = "delete from tblProductImage where productId = ?";
            PreparedStatement st2 = connection.prepareStatement(sql2);
            st2.setInt(1, productId);
            st2.executeUpdate();

            // Thu thập tất cả productOptionId liên quan
            String sql3 = "select productOptionId from tblInventory where productId = ?";
            PreparedStatement st3 = connection.prepareStatement(sql3);
            st3.setInt(1, productId);
            ResultSet rs = st3.executeQuery();
            ArrayList<Integer> productOptionIds = new ArrayList<>();
            while (rs.next()) {
                productOptionIds.add(rs.getInt("productOptionId"));
            }

            // Xóa từ bảng tblInventory trước
            String sql4 = "delete from tblInventory where productId = ?";
            PreparedStatement st4 = connection.prepareStatement(sql4);
            st4.setInt(1, productId);
            st4.executeUpdate();

            // Xóa các tùy chọn sản phẩm liên quan từ bảng tblProductOption
            String sql5 = "delete from tblProductOption where id = ?";
            PreparedStatement st5 = connection.prepareStatement(sql5);
            for (int productOptionId : productOptionIds) {
                st5.setInt(1, productOptionId);
                st5.executeUpdate();
            }

            // Cuối cùng, xóa sản phẩm từ bảng tblProduct
            String sql1 = "delete from tblProduct where id = ?";
            PreparedStatement st1 = connection.prepareStatement(sql1);
            st1.setInt(1, productId);
            st1.executeUpdate();

            connection.commit(); // Kết thúc giao dịch thành công
        } catch (SQLException e) {
            if (connection != null) {
                try {
                    connection.rollback(); // Rollback nếu có lỗi
                } catch (SQLException ex) {
                    System.out.println("Lỗi trong quá trình rollback: " + ex.getMessage());
                }
            }
            System.out.println("Lỗi trong quá trình xóa dữ liệu: " + e.getMessage());
        } finally {
            if (connection != null) {
                try {
                    connection.setAutoCommit(true); // Bật lại chế độ tự động commit
                } catch (SQLException ex) {
                    System.out.println("Lỗi trong quá trình bật lại chế độ tự động commit: " + ex.getMessage());
                }
            }
        }
    }

}
