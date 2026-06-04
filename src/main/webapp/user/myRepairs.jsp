<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.logistics.model.User" %>
<%@ page import="com.logistics.model.RepairOrder" %>
<%@ page import="com.logistics.dao.RepairOrderDAO" %>
<%@ page import="java.util.List" %>
<%@ include file="/common/header.jsp" %>
<%
    User currentUser = (User) session.getAttribute("currentUser");
    if (currentUser == null || !"user".equals(currentUser.getRoleName())) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
    RepairOrderDAO orderDAO = new RepairOrderDAO();
    List<RepairOrder> orders = orderDAO.getOrdersByUser(currentUser.getId());
%>
<!DOCTYPE html>
<html>
<head>
    <title>我的报修单 - 用户中心</title>
</head>
<body>
<div class="container-fluid">
    <div class="row">
        <!-- 侧边栏 -->
        <div class="col-md-2 p-0 sidebar">
            <div class="text-center py-4">
                <h5><i class="fas fa-building"></i> 后勤系统</h5>
                <small><%= currentUser.getRealName() %></small>
            </div>
            <a href="<%= request.getContextPath() %>/user/index.jsp">
                <i class="fas fa-home"></i> 首页
            </a >
            <a href="<%= request.getContextPath() %>/user/submitRepair.jsp">
                <i class="fas fa-plus-circle"></i> 提交报修
            </a >
            <a href="<%= request.getContextPath() %>/user/myRepairs.jsp" class="active">
                <i class="fas fa-list"></i> 我的报修
            </a >
            <a href="<%= request.getContextPath() %>/logout">
                <i class="fas fa-sign-out-alt"></i> 退出
            </a >
        </div>

        <!-- 主内容区：报修单列表 -->
        <div class="col-md-10 p-4">
            <div class="card">
                <div class="card-header bg-white">
                    <h3><i class="fas fa-clipboard-list"></i> 我的报修记录</h3>
                </div>
                <div class="card-body">
                    <table class="table table-striped table-hover align-middle">
                        <thead class="table-light">
                            <tr>
                                <th>标题</th>
                                <th>描述</th>
                                <th>房间号</th>
                                <th>状态</th>
                                <th>提交时间</th>
                            </tr>
                        </thead>
                        <tbody>
                        <% if (orders != null && !orders.isEmpty()) {
                            for (RepairOrder order : orders) { %>
                            <tr>
                                <td><%= order.getTitle() %></td>
                                <td><%= order.getDescription() %></td>
                                <td><%= order.getRoom() %></td>
                                <td>
                                    <% if ("pending".equals(order.getStatus())) { %>
                                        <span class="badge bg-warning text-dark">待处理</span>
                                    <% } else if ("processing".equals(order.getStatus())) { %>
                                        <span class="badge bg-primary">处理中</span>
                                    <% } else { %>
                                        <span class="badge bg-success">已完成</span>
                                    <% } %>
                                </td>
                                <td><%= order.getSubmitTime() %></td>
                            </tr>
                        <% }
                        } else { %>
                            <tr><td colspan="5" class="text-center text-muted">暂无报修记录</td></tr>
                        <% } %>
                        </tbody>
                    </table>
                    <div class="mt-3">
                        <a href="<%= request.getContextPath() %>/user/index.jsp" class="btn btn-secondary">返回首页</a >
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>