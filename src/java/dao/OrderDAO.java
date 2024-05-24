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
import model.Order;
import model.OrderDetail;
import model.PaymentMethod;
import model.Product;
import model.Status;
import model.User;

/**
 *
 * @author PC
 */
public class OrderDAO extends DAO {

    public OrderDAO() {
        super();
    }

    public ArrayList<Order> getAllOrders() {
        ArrayList<Order> orders = new ArrayList<>();
        try {
            String sql = "select * from tblOrder";
            PreparedStatement stmt = connection.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Order order = new Order();
                int orderId = rs.getInt("id");
                order.setId(orderId);
                order.setOrderDate(rs.getDate("orderDate"));
                order.setTotalAmount(rs.getDouble("totalAmount"));
                order.setReasonForCancel(rs.getString("reasonForCancel"));
                order.setNote(rs.getString("note"));

                Status status = new Status();
                int statusId = rs.getInt("statusId");
                status.setId(statusId);
                String sql1 = "select * from tblStatus where id = ?";
                PreparedStatement st1 = connection.prepareStatement(sql1);
                st1.setInt(1, statusId);
                ResultSet rs1 = st1.executeQuery();
                if (rs1.next()) {
                    status.setStatusName(rs1.getString("statusName"));
                }
                st1.close();
                order.setStatus(status);

                int paymentMethodId = rs.getInt("paymentMethodId");
                PaymentMethod paymentMethod = new PaymentMethod();
                paymentMethod.setId(paymentMethodId);
                String sql2 = "select * from tblPaymentMethod where id = ?";
                PreparedStatement st2 = connection.prepareStatement(sql2);
                st2.setInt(1, paymentMethodId);
                ResultSet rs2 = st2.executeQuery();
                if (rs2.next()) {
                    paymentMethod.setMethodName(rs2.getString("methodName"));
                }
                st2.close();
                order.setPaymentMethod(paymentMethod);

                ArrayList<OrderDetail> listOrderDetail = new ArrayList<>();
                String sql3 = "select * from tblOrderDetail where orderId = ?";
                PreparedStatement st3 = connection.prepareStatement(sql3);
                st3.setInt(1, orderId);
                ResultSet rs3 = st3.executeQuery();
                while (rs3.next()) {
                    OrderDetail od = new OrderDetail();
                    od.setId(rs3.getInt("id"));
                    od.setPrice(rs3.getDouble("price"));
                    od.setQuantity(rs3.getInt("quantity"));

                    int productId = rs3.getInt("productId");
                    ProductDAO productDao = new ProductDAO();
                    Product p = productDao.getProductById(productId);
                    od.setProduct(p);
                    listOrderDetail.add(od);
                }
                order.setOrderDetails(listOrderDetail);

                orders.add(order);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return orders;
    }

    public ArrayList<Order> getAllOrderByUid(int uid) {
        ArrayList<Order> orders = new ArrayList<>();
        try {
            String sql = "select * from tblOrder where userId = ?";
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setInt(1, uid);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Order order = new Order();
                int orderId = rs.getInt("id");
                order.setId(orderId);
                order.setOrderDate(rs.getDate("orderDate"));
                order.setTotalAmount(rs.getDouble("totalAmount"));
                order.setReasonForCancel(rs.getString("reasonForCancel"));
                order.setNote(rs.getString("note"));

                Status status = new Status();
                int statusId = rs.getInt("statusId");
                status.setId(statusId);
                String sql1 = "select * from tblStatus where id = ?";
                PreparedStatement st1 = connection.prepareStatement(sql1);
                st1.setInt(1, statusId);
                ResultSet rs1 = st1.executeQuery();
                if (rs1.next()) {
                    status.setStatusName(rs1.getString("statusName"));
                }
                st1.close();
                order.setStatus(status);

                int paymentMethodId = rs.getInt("paymentMethodId");
                PaymentMethod paymentMethod = new PaymentMethod();
                paymentMethod.setId(paymentMethodId);
                String sql2 = "select * from tblPaymentMethod where id = ?";
                PreparedStatement st2 = connection.prepareStatement(sql2);
                st2.setInt(1, paymentMethodId);
                ResultSet rs2 = st2.executeQuery();
                if (rs2.next()) {
                    paymentMethod.setMethodName(rs2.getString("methodName"));
                }
                st2.close();
                order.setPaymentMethod(paymentMethod);

                ArrayList<OrderDetail> listOrderDetail = new ArrayList<>();
                String sql3 = "select * from tblOrderDetail where orderId = ?";
                PreparedStatement st3 = connection.prepareStatement(sql3);
                st3.setInt(1, orderId);
                ResultSet rs3 = st3.executeQuery();
                while (rs3.next()) {
                    OrderDetail od = new OrderDetail();
                    od.setId(rs3.getInt("id"));
                    od.setPrice(rs3.getDouble("price"));
                    od.setQuantity(rs3.getInt("quantity"));

                    int productId = rs3.getInt("productId");
                    ProductDAO productDao = new ProductDAO();
                    Product p = productDao.getProductById(productId);
                    od.setProduct(p);
                    listOrderDetail.add(od);
                }
                order.setOrderDetails(listOrderDetail);

                orders.add(order);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return orders;
    }

    public boolean addOrder(Order o) {
        try {
            connection.setAutoCommit(false); // Disable auto-commit      

            // Insert into tblOrder
            String sql = "INSERT INTO tblOrder (orderDate, totalAmount, statusId, paymentMethodId, userId, note) VALUES (?, ?, ?, ?, ?, ?)";
            PreparedStatement st = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            st.setDate(1, new java.sql.Date(o.getOrderDate().getTime()));
            st.setDouble(2, o.getTotalAmount());
            st.setInt(3, o.getStatus().getId());
            st.setInt(4, o.getPaymentMethod().getId());
            st.setInt(5, o.getUser().getId());
            st.setString(6, o.getNote());
            st.executeUpdate();

            // Get the generated order ID
            ResultSet generatedKeys = st.getGeneratedKeys();
            int orderId = -1;
            if (generatedKeys.next()) {
                orderId = generatedKeys.getInt(1);
            }
            o.setId(orderId);
            generatedKeys.close();
            st.close();

            // Insert into tblOrderDetail and update tblInventory
            for (OrderDetail detail : o.getOrderDetails()) {
                // Insert into tblOrderDetail
                String detailSql = "INSERT INTO tblOrderDetail (orderId, productId, quantity, price) VALUES (?, ?, ?, ?)";
                PreparedStatement st1 = connection.prepareStatement(detailSql);
                st1.setInt(1, orderId);
                st1.setInt(2, detail.getProduct().getId());
                st1.setInt(3, detail.getQuantity());
                st1.setDouble(4, detail.getPrice());
                st1.executeUpdate();
                st1.close();

                // Update tblInventory
                String inventorySql = "UPDATE tblInventory SET stockQuantity = stockQuantity - ? WHERE productId = ?";
                PreparedStatement st2 = connection.prepareStatement(inventorySql);
                st2.setInt(1, detail.getQuantity());
                st2.setInt(2, detail.getProduct().getId());
                st2.executeUpdate();
                st2.close();
            }

            connection.commit();
            return true;
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
        return false;
    }

}
