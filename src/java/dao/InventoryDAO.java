/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import model.Inventory;
import model.ProductOption;

/**
 *
 * @author PC
 */
public class InventoryDAO extends DAO {

    public InventoryDAO() {
        super();
    }

    public ArrayList<Inventory> getAllInventoryByPid(int productId) {
        try {
            ArrayList<Inventory> listInventory = new ArrayList<>();
            String sql2 = "select id, productOptionId, stockQuantity from tblInventory where productId = ?";
            PreparedStatement st2 = connection.prepareStatement(sql2);
            st2.setInt(1, productId);
            ResultSet rs2 = st2.executeQuery();
            while (rs2.next()) {
                Inventory inventory = new Inventory();
                inventory.setId(rs2.getInt("id"));
                inventory.setStockQuantity(rs2.getInt("stockQuantity"));
                int productOptionId = rs2.getInt("productOptionId");

                ProductOption productOption = new ProductOptionDAO().getProductOptionById(productId);
                inventory.setProductOption(productOption);
                listInventory.add(inventory);                
            }
            return listInventory;
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }
        
    public void insertInventory(Inventory i, int productId){
        try{
            String sql = "insert into tblInventory(productId, productOptionId, stockQuantity) values(?, ?, ?)";
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, productId);
            st.setInt(2, i.getProductOption().getId());
            st.setInt(3, i.getStockQuantity());
            st.executeUpdate();
        }catch(SQLException e){
            System.out.println(e);
        }
    }
}
