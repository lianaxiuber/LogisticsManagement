<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.logistics.model.User" %>
<%@ page import="com.logistics.model.RepairOrder" %>
<%@ page import="com.logistics.dao.RepairOrderDAO" %>
<%@ page import="java.util.List" %>
<%@ include file="/common/header.jsp" %>
<%
    User currentUser = (User) session.getAttribute("currentUser");
    if (currentUser == null || !"repairer".equals(currentUser.getRoleName())) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
    RepairOrderDAO orderDAO = new RepairOrderDAO();
    List<RepairOrder> myOrders = orderDAO.getOrdersByRepairer(currentUser.getId());
%>
<!DOCTYPE html>
<html>
<head>
    <title>我的工单 - 维修员</title>
</head>
<body>
<div class="container-fluid">
    <div class="row">
        <!-- 侧边栏 -->
        <div class="col-md-2 p-0 sidebar">
            <div class="text-center py-4">
                <h5><i class="fas fa-wrench"></i> 维修平台</h5>
                <small><%= currentUser.getRealName() %></small>
            </div>
            <a href="<%= request.getContextPath() %>/repairer/index.jsp" class="active">
                <i class="fas fa-tasks"></i> 我的工单
            </a >
            <a href="<%= request.getContextPath() %>/logout">
                <i class="fas fa-sign-out-alt"></i> 退出登录
            </a >
        </div>

        <!-- 主内容区：工单列表 -->
        <div class="col-md-10 p-4">
            <h3><i class="fas fa-clipboard-list"></i> 待处理工单</h3>
            <div class="card mt-3">
                <div class="card-body">
                    <table class="table table-bordered table-hover align-middle">
                        <thead class="table-light">
                            <tr><th>ID</th><th>标题</th><th>描述</th><th>房间</th><th>报修人</th><th>状态</th><th>操作</th></tr>
                        </thead>
                        <tbody>
                        <% if (myOrders != null && !myOrders.isEmpty()) {
                            for (RepairOrder order : myOrders) { %>
                            <tr>
                                <td><%= order.getId() %></td>
                                <td><%= order.getTitle() %></td>
                                <td><%= order.getDescription() %></td>
                                <td><%= order.getRoom() %></td>
                                <td><%= order.getSubmitterName() %></td>
                                <td><span class="badge bg-warning text-dark"><%= order.getStatus() %></span></td>
                                <td>
                                    <% if ("processing".equals(order.getStatus()) || "pending".equals(order.getStatus())) { %>
                                        <a href="<%= request.getContextPath() %>/completeOrder?orderId=<%= order.getId() %>"
                                           class="btn btn-sm btn-success"
                                           onclick="return confirm('确认已经完成维修？')">
                                            <i class="fas fa-check-circle"></i> 完成
                                        </a >
                                    <% } else { %>
                                        <span class="text-muted">已完成</span>
                                    <% } %>
                                </td>
                            </tr>
                        <% }
                        } else { %>
                            <tr><td colspan="7" class="text-center text-muted">暂无待处理工单</td></tr>
                        <% } %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>