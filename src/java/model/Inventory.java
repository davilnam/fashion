/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.io.Serializable;

/**
 *
 * @author PC
 */
public class Inventory implements Serializable{
    private int id;
    private int stockQuantity;
    private ProductOption productOption;

    public Inventory() {
    }
    
    public Inventory(Inventory i){
        this.id = i.getId();
        this.stockQuantity = i.getStockQuantity();
        this.productOption = i.getProductOption();
    }

    public Inventory(int stockQuantity, ProductOption productOption) {
        this.stockQuantity = stockQuantity;
        this.productOption = productOption;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getStockQuantity() {
        return stockQuantity;
    }

    public void setStockQuantity(int stockQuantity) {
        this.stockQuantity = stockQuantity;
    }

    public ProductOption getProductOption() {
        return productOption;
    }

    public void setProductOption(ProductOption productOption) {
        this.productOption = productOption;
    }
    
    
}
