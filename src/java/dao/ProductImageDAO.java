/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import model.ProductImage;

/**
 *
 * @author PC
 */
public class ProductImageDAO extends DAO {

    public ProductImageDAO() {
        super();
    }

    public ArrayList<ProductImage> getAllProductImageByPid(int productId) {
        try {
            ArrayList<ProductImage> listProductImages = new ArrayList<>(); // ds hinh anh lien quan
            String sql1 = "select id, url from tblProductImage where productId = ?";
            PreparedStatement st1 = connection.prepareStatement(sql1);
            st1.setInt(1, productId);
            ResultSet rs1 = st1.executeQuery();
            while (rs1.next()) {
                ProductImage productImage = new ProductImage(rs1.getInt("id"), rs1.getString("url"));
                listProductImages.add(productImage);
            }
            return listProductImages;
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }
    
    public void insertProductImage(ProductImage pi, int productId){
        try{
            String sql = "insert into tblProductImage(url, productId) values(?, ?)";
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, pi.getUrl());
            st.setInt(2, productId);
            st.executeUpdate();
        }catch(SQLException e){
            System.out.println(e);
        }
    }

}
