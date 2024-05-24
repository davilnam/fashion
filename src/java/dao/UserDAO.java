/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import model.User;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserDAO extends DAO {

    public boolean checkLogin(User user) {
        boolean result = false;
        String sql = "SELECT * FROM tblUser WHERE email = ? AND password = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, user.getEmail());
            ps.setString(2, user.getPassword());
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                user.setUsername(rs.getString("username"));
                user.setAddress(rs.getString("address"));
                user.setPhone(rs.getString("phone"));
                user.setFullName(rs.getString("fullName"));
                user.setPosition(rs.getString("position"));
                user.setId(rs.getInt("id"));
                result = true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return result;
    }

    public void register(User user) {
        try {
            connection.setAutoCommit(false); // Bắt đầu giao dịch
            String sql = "insert into [tblUser] (username, password, phone, address, email ) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, user.getUsername());
            st.setString(2, user.getPassword());
            st.setString(3, user.getPhone());
            st.setString(4, user.getAddress());
            st.setString(5, user.getEmail());
            int check = st.executeUpdate();
            if (check != 0) {
                connection.commit();
            }
        } catch (SQLException e) {
            if (connection != null) {
                try {
                    connection.rollback(); // Rollback nếu có lỗi
                } catch (SQLException ex) {
                    System.out.println("Lỗi trong quá trình rollback: " + ex.getMessage());
                }
            }
            System.out.println("Loi trong qua trinh them du lieu: " + e.getMessage());
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

    public boolean updateInfo(User u) {
        String sql = "update tblUser set username = ?, phone = ?, address = ?, email = ?, fullName = ? where id = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, u.getUsername());
            st.setString(2, u.getPhone());
            st.setString(3, u.getAddress());
            st.setString(4, u.getEmail());
            st.setString(5, u.getFullName());
            st.setInt(6, u.getId());
            int row = st.executeUpdate();
            return row != 0;
        } catch (SQLException e) {
            System.out.println(e);
        }
        return false;
    }
}
