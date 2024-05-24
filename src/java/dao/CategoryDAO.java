/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import model.Category;
import model.Product;

/**
 *
 * @author PC
 */
public class CategoryDAO extends DAO {

    public CategoryDAO() {
        super();
    }

    public ArrayList<Category> getAllCategory() {
        String sql = "select * from tblCategory";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            ArrayList<Category> list = new ArrayList<>();
            while (rs.next()) {
                Category c = new Category();
                int id = rs.getInt("id"); 
                c.setId(id);
                c.setName(rs.getString("name"));
                ArrayList<Product> listProduct = new ProductDAO().getAllProductByCid(id);
                c.setProducts(listProduct);
                
                list.add(c);
            }
            return list;
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }
    

    public void addCategory(String tenDanhMuc) {
        String sql = "insert into tblCategory(name) values(?)";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, tenDanhMuc);
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public void editCategory(Category c) {
        String sql = "update tblCategory set name = ? where id = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, c.getName());
            st.setInt(2, c.getId());
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public void deleteCategory(int cid) {
        String sql = "delete from tblCategory where id = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, cid);
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public ArrayList<Category> searchCategory(String name) {
        try {
            String sql = """
                         select * from tblCategory
                         where name like ?""";
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, "%" + name + "%");
            ArrayList<Category> list = new ArrayList<>();
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Category c = new Category();
                int id = rs.getInt("id");
                c.setId(id);
                c.setName(rs.getString("name"));
                ArrayList<Product> listProduct = new ProductDAO().getAllProductByCid(id);
                c.setProducts(listProduct);
                list.add(c);
            }
            return list;
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return null;
    }
}
