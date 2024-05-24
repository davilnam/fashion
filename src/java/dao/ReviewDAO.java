/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.ResultSet;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import model.Reviews;
import model.User;

/**
 *
 * @author PC
 */
public class ReviewDAO extends DAO {

    public ReviewDAO() {
        super();
    }
    
    public ArrayList<Reviews> getAllReviewByPid(int pid){
        ArrayList<Reviews> list = new ArrayList<>();
        String sql = "select * from tblReviews where productId = ?";
        try{
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, pid);
            ResultSet rs = st.executeQuery();
            while(rs.next()){
                Reviews r = new Reviews();
                r.setId(rs.getInt("id"));
                r.setComment(rs.getString("comment"));
                r.setReviewDate(rs.getDate("reviewDate"));
                
                User user = new User();                
                int userId = rs.getInt("userId");
                user.setId(userId);
                
                String sql1 = "select username from tblUser where id = ?";
                PreparedStatement st1 = connection.prepareStatement(sql1);
                st1.setInt(1, userId);
                ResultSet rs1 = st1.executeQuery();
                if(rs1.next()){
                    user.setUsername(rs1.getString("username"));
                }
                
                r.setUser(user);
                list.add(r);
            }            
        }catch(SQLException e){
            System.out.println(e);
        }
        return list;
    }

    public void addComment(Reviews r) {
        String sql = "insert into tblReviews(productId, reviewDate, userId, comment) values(?, ?, ?, ?)";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, r.getProduct().getId());
            st.setDate(2, new java.sql.Date(r.getReviewDate().getTime()));
            st.setInt(3, r.getUser().getId());
            st.setString(4, r.getComment());
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

}
