/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import model.ProductOption;

/**
 *
 * @author PC
 */
public class ProductOptionDAO extends DAO {

    public ProductOptionDAO() {
        super();
    }

    public ProductOption getProductOptionById(int id) {
        try {
            String sql3 = "select id, size, color from tblProductOption where id = ?";
            PreparedStatement st3 = connection.prepareStatement(sql3);
            st3.setInt(1, id);
            ResultSet rs3 = st3.executeQuery();
            ProductOption productOption = new ProductOption();
            if (rs3.next()) {
                productOption.setId(id);
                productOption.setSize(rs3.getString("size"));
                productOption.setColor(rs3.getString("color"));
            }
            return productOption;
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }
    
    public int insertProductOption(ProductOption po){
        try{
            String sql = "insert into tblProductOption(size, color) values(?, ?)";
            PreparedStatement st = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            st.setString(1, po.getSize());
            st.setString(2, po.getColor());
             st.executeUpdate();

            // Lấy id của productOption vừa được insert
            ResultSet generatedKeys = st.getGeneratedKeys();
            int productOptionId = -1;
            if (generatedKeys.next()) {
                productOptionId = generatedKeys.getInt(1);
            }
            return productOptionId;
        }catch(SQLException e){
            System.out.println(e);
        }
        return -1; 
    }

}
