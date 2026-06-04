<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.logistics.model.User" %>
<%@ page import="com.logistics.dao.RepairOrderDAO" %>
<%@ page import="com.logistics.dao.MaterialDAO" %>
<%@ include file="/common/header.jsp" %>
<%
    User currentUser = (User) session.getAttribute("currentUser");
    if (currentUser == null || !"admin".equals(currentUser.getRoleName())) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
    // 查询真实数据
    RepairOrderDAO orderDAO = new RepairOrderDAO();
    MaterialDAO materialDAO = new MaterialDAO();
    int pendingOrders = orderDAO.countPendingOrders();           // 待处理报修数
    int totalMaterialQty = materialDAO.getTotalMaterialQuantity(); // 物资总数量
%>
<!DOCTYPE html>
<html>
<head>
    <title>仪表盘 - 后勤管理系统</title>
</head>
<body>
<div class="container-fluid">
    <div class="row">
        <!-- 侧边栏 -->
        <div class="col-md-2 p-0 sidebar">
            <div class="text-center py-4">
                <h5><i class="fas fa-building"></i> 后勤管理系统</h5>
                <small>管理员</small>
            </div>
            <a href="<%= request.getContextPath() %>/admin/dashboard.jsp" class="active">
                <i class="fas fa-tachometer-alt"></i> 仪表盘
            </a >
            <a href="<%= request.getContextPath() %>/admin/material?action=list">
                <i class="fas fa-boxes"></i> 物资管理
            </a >
            <a href="<%= request.getContextPath() %>/admin/repairList.jsp">
                <i class="fas fa-clipboard-list"></i> 报修单管理
            </a >
            <a href="<%= request.getContextPath() %>/logout">
                <i class="fas fa-sign-out-alt"></i> 退出登录
            </a >
        </div>

        <!-- 主内容区：真实数据卡片 -->
        <div class="col-md-10 p-4">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2>欢迎回来，<%= currentUser.getRealName() %></h2>
                <span class="text-muted"><i class="far fa-calendar-alt"></i> 今日动态</span>
            </div>

            <div class="row mb-4">
                <!-- 待处理报修卡片 -->
                <div class="col-md-6">
                    <div class="card text-white bg-primary mb-3">
                        <div class="card-body">
                            <h5 class="card-title">待处理报修</h5>
                            <p class="card-text display-6"><%= pendingOrders %></p >
                        </div>
                    </div>
                </div>
                <!-- 库存物资总数卡片 -->
                <div class="col-md-6">
                    <div class="card text-white bg-success mb-3">
                        <div class="card-body">
                            <h5 class="card-title">库存物资总数</h5>
                            <p class="card-text display-6"><%= totalMaterialQty %></p >
                        </div>
                    </div>
                </div>
            </div>

            <!-- 快捷操作 -->
            <div class="card">
                <div class="card-header">快速操作</div>
                <div class="card-body">
                    <a href="<%= request.getContextPath() %>/admin/material?action=add" class="btn btn-outline-primary me-2">
                        <i class="fas fa-plus"></i> 新增物资
                    </a >
                    <a href="<%= request.getContextPath() %>/admin/repairList.jsp" class="btn btn-outline-secondary">
                        <i class="fas fa-tools"></i> 派单处理
                    </a >
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>