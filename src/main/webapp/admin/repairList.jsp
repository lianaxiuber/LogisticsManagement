<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.logistics.model.RepairOrder" %>
<%@ page import="com.logistics.model.User" %>
<%@ page import="com.logistics.dao.RepairOrderDAO" %>
<%@ page import="com.logistics.dao.UserDAO" %>
<%@ include file="/common/header.jsp" %>
<%
    User admin = (User) session.getAttribute("currentUser");
    if (admin == null || !"admin".equals(admin.getRoleName())) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
    RepairOrderDAO orderDAO = new RepairOrderDAO();
    List<RepairOrder> orders = orderDAO.getPendingOrders();
    UserDAO userDAO = new UserDAO();
    List<User> repairers = userDAO.getUsersByRole("repairer");
%>
<!DOCTYPE html>
<html>
<head>
    <title>报修单管理</title>
</head>
<body>
<div class="container-fluid">
    <div class="row">
        <!-- 侧边栏（与物资管理相同） -->
        <div class="col-md-2 p-0 sidebar">
            <div class="text-center py-4">
                <h5><i class="fas fa-building"></i> 后勤管理系统</h5>
                <small>管理员</small>
            </div>
            <a href="<%= request.getContextPath() %>/admin/index.jsp"><i class="fas fa-tachometer-alt"></i> 仪表盘</a >
            <a href="<%= request.getContextPath() %>/admin/material?action=list"><i class="fas fa-boxes"></i> 物资管理</a >
            <a href="<%= request.getContextPath() %>/admin/repairList.jsp" class="active"><i class="fas fa-clipboard-list"></i> 报修单管理</a >
            <a href="<%= request.getContextPath() %>/logout"><i class="fas fa-sign-out-alt"></i> 退出登录</a >
        </div>

        <!-- 主内容 -->
        <div class="col-md-10 p-4">
            <h3><i class="fas fa-tools"></i> 待处理报修单</h3>
            <div class="card mt-3">
                <div class="card-body">
                    <table class="table table-bordered table-hover align-middle">
                        <thead class="table-light">
                            <tr><th>ID</th><th>标题</th><th>提交人</th><th>房间</th><th>状态</th><th>指派维修员</th></tr>
                        </thead>
                        <tbody>
                        <% if (orders != null && !orders.isEmpty()) {
                            for (RepairOrder order : orders) { %>
                            <tr>
                                <td><%= order.getId() %></td>
                                <td><%= order.getTitle() %></td>
                                <td><%= order.getSubmitterName() %></td>
                                <td><%= order.getRoom() %></td>
                                <td><span class="badge bg-warning text-dark"><%= order.getStatus() %></span></td>
                                <td>
                                    <form action="<%= request.getContextPath() %>/assignRepair" method="post" class="row g-2">
                                        <input type="hidden" name="orderId" value="<%= order.getId() %>">
                                        <div class="col-auto">
                                            <select name="repairerId" class="form-select form-select-sm">
                                                <% for (User r : repairers) { %>
                                                    <option value="<%= r.getId() %>"><%= r.getRealName() %></option>
                                                <% } %>
                                            </select>
                                        </div>
                                        <div class="col-auto">
                                            <button type="submit" class="btn btn-sm btn-primary">指派</button>
                                        </div>
                                    </form>
                                </td>
                            </tr>
                        <% }
                        } else { %>
                            <tr><td colspan="6" class="text-center text-muted">暂无待处理报修单</td></tr>
                        <% } %>
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="mt-3">
                <a href="<%= request.getContextPath() %>/admin/index.jsp" class="btn btn-secondary">返回后台首页</a >
            </div>
        </div>
    </div>
</div>
</body>
</html>