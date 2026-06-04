<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.logistics.model.User" %>
<%@ include file="/common/header.jsp" %>
<%
    User currentUser = (User) session.getAttribute("currentUser");
    if (currentUser == null || !"user".equals(currentUser.getRoleName())) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>提交报修单 - 用户中心</title>
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
            <a href="<%= request.getContextPath() %>/user/submitRepair.jsp" class="active">
                <i class="fas fa-plus-circle"></i> 提交报修
            </a >
            <a href="<%= request.getContextPath() %>/user/myRepairs.jsp">
                <i class="fas fa-list"></i> 我的报修
            </a >
            <a href="<%= request.getContextPath() %>/logout">
                <i class="fas fa-sign-out-alt"></i> 退出
            </a >
        </div>

        <!-- 主内容区：提交报修表单 -->
        <div class="col-md-10 p-4">
            <div class="card">
                <div class="card-header bg-white">
                    <h3><i class="fas fa-tools"></i> 提交新报修单</h3>
                </div>
                <div class="card-body">
                    <form action="<%= request.getContextPath() %>/submitRepair" method="post">
                        <div class="mb-3">
                            <label class="form-label">标题</label>
                            <input type="text" name="title" class="form-control" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">描述</label>
                            <textarea name="description" rows="4" class="form-control"></textarea>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">房间号</label>
                            <input type="text" name="room" class="form-control">
                        </div>
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-paper-plane"></i> 提交
                        </button>
                        <a href="<%= request.getContextPath() %>/user/index.jsp" class="btn btn-secondary">返回首页</a >
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>