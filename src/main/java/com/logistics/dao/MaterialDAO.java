package com.logistics.dao;

import com.logistics.model.Material;
import com.logistics.util.DBUtil;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class MaterialDAO {

    // 统计所有物资的库存数量总和（注意是 sum(quantity) 不是 count）
    public int getTotalMaterialQuantity() {
        String sql = "SELECT SUM(quantity) FROM material";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
    // 查询所有物资
    public List<Material> getAllMaterials() {
        List<Material> list = new ArrayList<>();
        String sql = "SELECT * FROM material ORDER BY id";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Material m = new Material();
                m.setId(rs.getInt("id"));
                m.setName(rs.getString("name"));
                m.setQuantity(rs.getInt("quantity"));
                m.setUnit(rs.getString("unit"));
                m.setLocation(rs.getString("location"));
                list.add(m);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // 根据ID查询单个物资
    public Material getMaterialById(int id) {
        String sql = "SELECT * FROM material WHERE id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Material m = new Material();
                m.setId(rs.getInt("id"));
                m.setName(rs.getString("name"));
                m.setQuantity(rs.getInt("quantity"));
                m.setUnit(rs.getString("unit"));
                m.setLocation(rs.getString("location"));
                return m;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // 添加物资
    public boolean addMaterial(Material m) {
        String sql = "INSERT INTO material (name, quantity, unit, location) VALUES (?, ?, ?, ?)";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, m.getName());
            ps.setInt(2, m.getQuantity());
            ps.setString(3, m.getUnit());
            ps.setString(4, m.getLocation());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // 更新物资
    public boolean updateMaterial(Material m) {
        String sql = "UPDATE material SET name = ?, quantity = ?, unit = ?, location = ? WHERE id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, m.getName());
            ps.setInt(2, m.getQuantity());
            ps.setString(3, m.getUnit());
            ps.setString(4, m.getLocation());
            ps.setInt(5, m.getId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // 删除物资
    public boolean deleteMaterial(int id) {
        String sql = "DELETE FROM material WHERE id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}