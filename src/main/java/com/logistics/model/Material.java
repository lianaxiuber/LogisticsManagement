package com.logistics.model;

/**
 * 物资实体类，对应数据库中的 material 表
 */
public class Material {
    private int id;          // 物资ID
    private String name;     // 物资名称
    private int quantity;    // 库存数量
    private String unit;     // 单位（如：个、台、箱）
    private String location; // 存放位置

    // 无参构造方法（必须，供框架或手动创建使用）
    public Material() {
    }

    // 有参构造方法（方便快速创建对象）
    public Material(String name, int quantity, String unit, String location) {
        this.name = name;
        this.quantity = quantity;
        this.unit = unit;
        this.location = location;
    }

    // 以下是所有属性的 Getter 和 Setter 方法
    // 在 IDEA 中可以用快捷键 Alt+Insert → Getter and Setter 自动生成
    // 为了确保完整性，这里手动列出，你也可以自己生成

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

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public String getUnit() {
        return unit;
    }

    public void setUnit(String unit) {
        this.unit = unit;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }
}