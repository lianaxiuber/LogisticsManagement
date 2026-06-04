package com.logistics.dao;

import com.logistics.model.RepairOrder;
import com.logistics.util.DBUtil;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class RepairOrderDAO {
    /**
     * 获取指派给某维修员的未完成报修单（状态为 pending 或 processing）
     * @param repairerId 维修员用户ID
     * @return 报修单列表
     */
    public List<RepairOrder> getOrdersByRepairer(int repairerId) {
        List<RepairOrder> list = new ArrayList<>();
        String sql = "SELECT o.*, u.real_name AS submitter_name " +
                "FROM repair_order o " +
                "LEFT JOIN user u ON o.submitter_id = u.id " +
                "WHERE o.assignee_id = ? AND o.status IN ('pending', 'processing') " +
                "ORDER BY o.submit_time DESC";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, repairerId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                RepairOrder order = new RepairOrder();
                order.setId(rs.getInt("id"));
                order.setTitle(rs.getString("title"));
                order.setDescription(rs.getString("description"));
                order.setRoom(rs.getString("room"));
                order.setSubmitterId(rs.getInt("submitter_id"));
                order.setSubmitterName(rs.getString("submitter_name"));
                order.setAssigneeId(rs.getInt("assignee_id"));
                order.setStatus(rs.getString("status"));
                order.setSubmitTime(rs.getTimestamp("submit_time"));
                order.setCompleteTime(rs.getTimestamp("complete_time"));
                list.add(order);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean completeOrder(int orderId) {
        String sql = "UPDATE repair_order SET status = 'completed', complete_time = NOW() WHERE id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, orderId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    // 统计待处理的报修单数量（pending 或 processing，即未完成的）
    public int countPendingOrders() {
        String sql = "SELECT COUNT(*) FROM repair_order WHERE status IN ('pending', 'processing')";
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

    // 统计所有报修单总数（可选，备用）
    public int countTotalOrders() {
        String sql = "SELECT COUNT(*) FROM repair_order";
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
    // 提交新报修单
    public boolean addOrder(RepairOrder order) {
        String sql = "INSERT INTO repair_order (title, description, room, submitter_id, status) VALUES (?,?,?,?,?)";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, order.getTitle());
            ps.setString(2, order.getDescription());
            ps.setString(3, order.getRoom());
            ps.setInt(4, order.getSubmitterId());
            ps.setString(5, "pending");
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // 查询某个用户提交的所有报修单（普通用户用）
    public List<RepairOrder> getOrdersByUser(int userId) {
        List<RepairOrder> list = new ArrayList<>();
        String sql = "SELECT o.*, u.real_name AS submitter_name FROM repair_order o " +
                "LEFT JOIN user u ON o.submitter_id = u.id " +
                "WHERE o.submitter_id = ? ORDER BY o.submit_time DESC";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                RepairOrder order = new RepairOrder();
                order.setId(rs.getInt("id"));
                order.setTitle(rs.getString("title"));
                order.setDescription(rs.getString("description"));
                order.setRoom(rs.getString("room"));
                order.setStatus(rs.getString("status"));
                order.setSubmitterName(rs.getString("submitter_name"));
                order.setSubmitTime(rs.getTimestamp("submit_time"));
                list.add(order);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // 管理员查询所有未完成的报修单（用于分配）
    public List<RepairOrder> getPendingOrders() {
        List<RepairOrder> list = new ArrayList<>();
        String sql = "SELECT o.*, u.real_name AS submitter_name FROM repair_order o " +
                "LEFT JOIN user u ON o.submitter_id = u.id " +
                "WHERE o.status IN ('pending','processing') ORDER BY o.submit_time";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                RepairOrder order = new RepairOrder();
                order.setId(rs.getInt("id"));
                order.setTitle(rs.getString("title"));
                order.setDescription(rs.getString("description"));
                order.setRoom(rs.getString("room"));
                order.setStatus(rs.getString("status"));
                order.setSubmitterName(rs.getString("submitter_name"));
                order.setSubmitTime(rs.getTimestamp("submit_time"));
                list.add(order);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // 更新报修单状态（维修员使用）
    public boolean updateStatus(int orderId, String newStatus) {
        String sql = "UPDATE repair_order SET status=? WHERE id=?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, newStatus);
            ps.setInt(2, orderId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    /**
     * 管理员指派维修员
     * @param orderId    报修单ID
     * @param repairerId 维修员用户ID
     * @return 是否更新成功
     */
    public boolean assignRepairer(int orderId, int repairerId) {
        String sql = "UPDATE repair_order SET assignee_id = ?, status = 'processing' WHERE id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, repairerId);
            ps.setInt(2, orderId);
            int affectedRows = ps.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
