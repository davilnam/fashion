/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
/**
 *
 * @author PC
 */
public class DAO {
    protected Connection connection;
    
    public  DAO(){
        try{
            String url = "jdbc:sqlserver://localhost:1433;databaseName=banquanao";
            String name = "sa";
            String pass = "123";
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            connection = DriverManager.getConnection(url, name, pass);
        }catch(ClassNotFoundException | SQLException e){
            System.out.println(e);
        }
    }
}