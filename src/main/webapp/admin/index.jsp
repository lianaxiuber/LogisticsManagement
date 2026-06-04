<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.logistics.model.User" %>
<%@ include file="/common/header.jsp" %>
<%
    User currentUser = (User) session.getAttribute("currentUser");
    if (currentUser == null || !"admin".equals(currentUser.getRoleName())) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>管理员后台</title>
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
            <!-- 仪表盘链接指向真正的 dashboard.jsp -->
            <a href="<%= request.getContextPath() %>/admin/dashboard.jsp">
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

        <!-- 主内容区：简单欢迎信息（无虚假数据） -->
        <div class="col-md-10 p-4">
            <div class="card">
                <div class="card-header bg-white">
                    <h3><i class="fas fa-user-shield"></i> 欢迎，<%= currentUser.getRealName() %></h3>
                </div>
                <div class="card-body">
                    <p>请使用左侧菜单进行操作：</p >
                    <ul>
                        <li><strong>仪表盘</strong> - 查看系统关键数据统计</li>
                        <li><strong>物资管理</strong> - 管理库存物资</li>
                        <li><strong>报修单管理</strong> - 处理报修工单</li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>