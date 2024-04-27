/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;
import model.User;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserDAO extends DAO{
    public UserDAO() {
        super();
    }
    
    public boolean checkLogin(User user) {
        boolean result = false;
        String sql = "SELECT * FROM tblUser WHERE username = ? AND password = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, user.getUsername());
            ps.setString(2, user.getPassword());
            ResultSet rs = ps.executeQuery();
            if(rs.next()) {
                user.setAddress(rs.getString("address"));
                user.setPhone(rs.getString("phone"));
                user.setFullName(rs.getString("fullName"));
                user.setPosition(rs.getString("position"));
                user.setId(rs.getInt("id"));
                result = true;
            }
        }catch(SQLException e) {
            e.printStackTrace();
        }
        return result;
    }
}
