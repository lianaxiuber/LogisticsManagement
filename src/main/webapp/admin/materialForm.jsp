<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.logistics.model.Material" %>
<%@ page import="com.logistics.model.User" %>
<%@ include file="/common/header.jsp" %>
<%
    User currentUser = (User) session.getAttribute("currentUser");
    if (currentUser == null || !"admin".equals(currentUser.getRoleName())) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
    Material material = (Material) request.getAttribute("material");
    boolean isEdit = (material != null);
    String action = isEdit ? "update" : "add";
%>
<!DOCTYPE html>
<html>
<head>
    <title><%= isEdit ? "编辑物资" : "新增物资" %></title>
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
            <div class="card">
                <div class="card-header bg-white">
                    <h4><%= isEdit ? "编辑物资" : "新增物资" %></h4>
                </div>
                <div class="card-body">
                    <form action="<%= request.getContextPath() %>/admin/material" method="post">
                        <input type="hidden" name="action" value="<%= action %>">
                        <% if (isEdit) { %>
                            <input type="hidden" name="id" value="<%= material.getId() %>">
                        <% } %>

                        <div class="mb-3">
                            <label class="form-label">物资名称</label>
                            <input type="text" name="name" class="form-control" value="<%= isEdit ? material.getName() : "" %>" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">数量</label>
                            <input type="number" name="quantity" class="form-control" value="<%= isEdit ? material.getQuantity() : 0 %>" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">单位</label>
                            <input type="text" name="unit" class="form-control" value="<%= isEdit ? material.getUnit() : "" %>" placeholder="如：个、台、箱">
                        </div>
                        <div class="mb-3">
                            <label class="form-label">存放位置</label>
                            <input type="text" name="location" class="form-control" value="<%= isEdit ? material.getLocation() : "" %>" placeholder="仓库/房间号">
                        </div>
                        <button type="submit" class="btn btn-primary">提交</button>
                        <a href="<%= request.getContextPath() %>/admin/material?action=list" class="btn btn-secondary">取消</a >
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>