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
    <title>用户中心</title>
</head>
<body>
<div class="container-fluid">
    <div class="row">
        <div class="col-md-2 p-0 sidebar">
            <div class="text-center py-4">
                <h5><i class="fas fa-building"></i> 后勤系统</h5>
                <small><%= currentUser.getRealName() %></small>
            </div>
            <a href="<%= request.getContextPath() %>/user/index.jsp" class="active"><i class="fas fa-home"></i> 首页</a >
            <a href="<%= request.getContextPath() %>/user/submitRepair.jsp"><i class="fas fa-plus-circle"></i> 提交报修</a >
            <a href="<%= request.getContextPath() %>/user/myRepairs.jsp"><i class="fas fa-list"></i> 我的报修</a >
            <a href="<%= request.getContextPath() %>/logout"><i class="fas fa-sign-out-alt"></i> 退出</a >
        </div>
        <div class="col-md-10 p-4">
            <div class="jumbotron bg-white p-5 rounded shadow-sm">
                <h1 class="display-5">欢迎，<%= currentUser.getRealName() %></h1>
                <p class="lead">快速处理后勤报修，跟踪维修进度。</p >
                <hr class="my-4">
                <a class="btn btn-primary btn-lg" href="<%= request.getContextPath() %>/user/submitRepair.jsp" role="button">
                    <i class="fas fa-tools"></i> 立即报修
                </a >
                <a class="btn btn-outline-secondary btn-lg" href="<%= request.getContextPath() %>/user/myRepairs.jsp" role="button">
                    查看我的报修单
                </a >
            </div>
        </div>
    </div>
</div>
</body>
</html>