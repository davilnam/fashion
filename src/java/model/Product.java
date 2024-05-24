/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.io.Serializable;
import java.util.ArrayList;

/**
 *
 * @author PC
 */
public class Product implements Serializable {

    private int id;
    private String name;
    private String image;
    private String description;
    private double price;
    private ArrayList<ProductImage> productImages;
    private ArrayList<Inventory> inventory;

    public Product() {
        productImages = new ArrayList<>();
        inventory = new ArrayList<>();
    }

    public Product(Product p) {
        this.id = p.getId();
        this.name = p.getName();
        this.image = p.getImage();
        this.description = p.getDescription();
        this.price = p.getPrice();
        this.productImages = p.getProductImages();
        this.inventory = p.getInventory();
    }

    public Product(int id, String name, String image, String description, double price, ArrayList<ProductImage> productImages, ArrayList<Inventory> inventory) {
        this.id = id;
        this.name = name;
        this.image = image;
        this.description = description;
        this.price = price;
        this.productImages = productImages;
        this.inventory = inventory;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public ArrayList<ProductImage> getProductImages() {
        return productImages;
    }

    public void setProductImages(ArrayList<ProductImage> productImages) {
        this.productImages = productImages;
    }

    public ArrayList<Inventory> getInventory() {
        return inventory;
    }

    public void setInventory(ArrayList<Inventory> inventory) {
        this.inventory = inventory;
    }

}
