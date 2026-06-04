<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.logistics.model.Material" %>
<%@ page import="com.logistics.model.User" %>
<%@ include file="/common/header.jsp" %>
<%
    User currentUser = (User) session.getAttribute("currentUser");
    if (currentUser == null || !"admin".equals(currentUser.getRoleName())) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
    List<Material> materials = (List<Material>) request.getAttribute("materials");
%>
<html>
<head>
    <title>物资管理</title>
</head>
<body>
<div class="container-fluid">
    <div class="row">
        <div class="col-md-2 p-0 sidebar">
            <div class="text-center py-4">
                <h5><i class="fas fa-building"></i> 后勤管理系统</h5>
                <small>管理员</small>
            </div>
            <a href="<%= request.getContextPath() %>/admin/index.jsp"><i class="fas fa-tachometer-alt"></i> 仪表盘</a >
            <a href="<%= request.getContextPath() %>/admin/material?action=list" class="active"><i class="fas fa-boxes"></i> 物资管理</a >
            <a href="<%= request.getContextPath() %>/admin/repairList.jsp"><i class="fas fa-clipboard-list"></i> 报修单管理</a >
            <a href="<%= request.getContextPath() %>/logout"><i class="fas fa-sign-out-alt"></i> 退出登录</a >
        </div>

        <div class="col-md-10 p-4">
            <div class="d-flex justify-content-between align-items-center mb-3">
                <h3><i class="fas fa-warehouse"></i> 物资清单</h3>
                <a href="<%= request.getContextPath() %>/admin/material?action=add" class="btn btn-success">
                    <i class="fas fa-plus"></i> 新增物资
                </a >
            </div>

            <div class="card">
                <div class="card-body">
                    <table class="table table-striped table-hover align-middle">
                        <thead class="table-light">
                            <tr><th>ID</th><th>名称</th><th>数量</th><th>单位</th><th>存放位置</th><th>操作</th></tr>
                        </thead>
                        <tbody>
                        <% if (materials != null && !materials.isEmpty()) {
                            for (Material m : materials) { %>
                            <tr>
                                <td><%= m.getId() %></td>
                                <td><%= m.getName() %></td>
                                <td><%= m.getQuantity() %></td>
                                <td><%= m.getUnit() %></td>
                                <td><%= m.getLocation() %></td>
                                <td>
                                    <a href="<%= request.getContextPath() %>/admin/material?action=edit&id=<%= m.getId() %>" class="btn btn-sm btn-warning">
                                        <i class="fas fa-edit"></i> 编辑
                                    </a >
                                    <a href="<%= request.getContextPath() %>/admin/material?action=delete&id=<%= m.getId() %>" class="btn btn-sm btn-danger" onclick="return confirm('确定删除？')">
                                        <i class="fas fa-trash"></i> 删除
                                    </a >
                                </td>
                            </tr>
                        <% }
                        } else { %>
                            <tr><td colspan="6" class="text-center text-muted">暂无物资数据</td></tr>
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