<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>高校后勤管理系统 - 登录</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome 6 图标库 -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            font-family: 'Segoe UI', 'Poppins', system-ui, sans-serif;
        }
        .login-card {
            background: rgba(255, 255, 255, 0.95);
            border-radius: 24px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.2);
            backdrop-filter: blur(2px);
            transition: transform 0.3s ease;
            width: 100%;
            max-width: 450px;
            padding: 2rem;
        }
        .login-card:hover {
            transform: translateY(-5px);
        }
        .login-header {
            text-align: center;
            margin-bottom: 2rem;
        }
        .login-header i {
            font-size: 3rem;
            color: #4f46e5;
            background: #eef2ff;
            padding: 1rem;
            border-radius: 60px;
        }
        .login-header h3 {
            margin-top: 1rem;
            font-weight: 600;
            color: #1f2937;
        }
        .login-header p {
            color: #6b7280;
            font-size: 0.9rem;
        }
        .form-floating {
            margin-bottom: 1rem;
        }
        .btn-login {
            background: linear-gradient(90deg, #4f46e5, #7c3aed);
            border: none;
            padding: 12px;
            font-weight: 600;
            font-size: 1rem;
            border-radius: 40px;
            transition: 0.2s;
            width: 100%;
            color: white;
        }
        .btn-login:hover {
            background: linear-gradient(90deg, #4338ca, #6d28d9);
            transform: scale(1.01);
            box-shadow: 0 8px 20px rgba(79, 70, 229, 0.3);
        }
        .alert-custom {
            border-radius: 40px;
            font-size: 0.9rem;
            padding: 0.75rem 1rem;
            margin-top: 1rem;
        }
        .footer-note {
            text-align: center;
            margin-top: 1.5rem;
            font-size: 0.8rem;
            color: #9ca3af;
        }
        @media (max-width: 480px) {
            .login-card {
                margin: 1rem;
                padding: 1.5rem;
            }
        }
    </style>
</head>
<body>
<div class="login-card">
    <div class="login-header">
        <i class="fas fa-building"></i>
        <h3>高校后勤管理系统</h3>
        <p>后勤保障 · 智慧服务</p >
    </div>

    <form action="login" method="post">
        <div class="form-floating mb-3">
            <input type="text" class="form-control" id="username" name="username" placeholder="用户名" required>
            <label for="username"><i class="fas fa-user"></i> 用户名</label>
        </div>
        <div class="form-floating mb-4">
            <input type="password" class="form-control" id="password" name="password" placeholder="密码" required>
            <label for="password"><i class="fas fa-lock"></i> 密码</label>
        </div>
        <button type="submit" class="btn btn-login">
            <i class="fas fa-sign-in-alt"></i> 登录
        </button>

        <% if (request.getAttribute("error") != null) { %>
        <div class="alert alert-danger alert-custom mt-3" role="alert">
            <i class="fas fa-exclamation-circle"></i> <%= request.getAttribute("error") %>
        </div>
        <% } %>
    </form>
    <div class="footer-note">
        默认管理员账号：admin / 123456
    </div>
</div>
</body>
</html>