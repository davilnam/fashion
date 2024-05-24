/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import model.Status;

/**
 *
 * @author PC
 */
public class StatusDAO extends DAO{

    public StatusDAO() {
        super();
    }
    
    public ArrayList<Status> getAllStatus(){
        try{
            String sql = "select * from tblStatus";
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            ArrayList<Status> list = new ArrayList<>();
            while(rs.next()){
                Status s = new Status(rs.getInt("id"), rs.getString("statusName"));
                list.add(s);
            }
            return list;
        }catch(SQLException e){
            System.out.println(e);
        }
        return null;
    }
    
}
