/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;

/**
 *
 * @author PC
 */
public class Order implements Serializable{
    private int id;
    private Date orderDate;
    private double totalAmount;
    private String reasonForCancel;
    private String note;
    private Status status;
    private PaymentMethod paymentMethod;
    private User user;
    private ArrayList<OrderDetail> orderDetails;

    public Order() {
        orderDetails = new ArrayList<>();
    }
    
    public Order(Order o){
        this.id = o.getId();
        this.orderDate = o.getOrderDate();
        this.totalAmount = o.getTotalAmount();
        this.reasonForCancel = o.getReasonForCancel();
        this.note = o.getNote();
        this.status = o.getStatus();
        this.paymentMethod = o.getPaymentMethod();
        this.user = o.getUser();
        this.orderDetails = o.getOrderDetails();
    }

    public Order(int id, Date orderDate, double totalAmount, String reasonForCancel, String note, Status status, PaymentMethod paymentMethod, User user, ArrayList<OrderDetail> orderDetails) {
        this.id = id;
        this.orderDate = orderDate;
        this.totalAmount = totalAmount;
        this.reasonForCancel = reasonForCancel;
        this.note = note;
        this.status = status;
        this.paymentMethod = paymentMethod;
        this.user = user;
        this.orderDetails = orderDetails;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Date getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(Date orderDate) {
        this.orderDate = orderDate;
    }

    public double getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(double totalAmount) {
        this.totalAmount = totalAmount;
    }

    public String getReasonForCancel() {
        return reasonForCancel;
    }

    public void setReasonForCancel(String reasonForCancel) {
        this.reasonForCancel = reasonForCancel;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public Status getStatus() {
        return status;
    }

    public void setStatus(Status status) {
        this.status = status;
    }

    public PaymentMethod getPaymentMethod() {
        return paymentMethod;
    }

    public void setPaymentMethod(PaymentMethod paymentMethod) {
        this.paymentMethod = paymentMethod;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public ArrayList<OrderDetail> getOrderDetails() {
        return orderDetails;
    }

    public void setOrderDetails(ArrayList<OrderDetail> orderDetails) {
        this.orderDetails = orderDetails;
    }
    
}
