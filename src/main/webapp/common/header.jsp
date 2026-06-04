<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!-- 引入 Bootstrap 5 CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
<!-- 引入 Font Awesome 6 免费图标库 -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<!-- 自定义微调样式 -->
<style>
    body {
        background-color: #f4f6f9;
        font-family: 'Segoe UI', system-ui;
    }
    .sidebar {
        min-height: 100vh;
        background: #2c3e50;
        color: white;
    }
    .sidebar a {
        color: #ecf0f1;
        text-decoration: none;
        padding: 10px 15px;
        display: block;
        transition: 0.2s;
    }
    .sidebar a:hover {
        background: #1abc9c;
        border-radius: 8px;
        margin: 0 8px;
    }
    .sidebar .active {
        background: #1abc9c;
        border-radius: 8px;
        margin: 0 8px;
    }
    .card-header {
        background-color: #fff;
        border-bottom: 2px solid #e9ecef;
        font-weight: 600;
    }
    .table thead th {
        background-color: #f8f9fc;
        border-bottom: 2px solid #e9ecef;
    }
    .btn-sm {
        margin: 0 2px;
    }
</style>