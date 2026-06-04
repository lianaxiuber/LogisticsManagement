package com.logistics.servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/logout")
public class LogoutServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 获取当前 session（如果存在）
        HttpSession session = req.getSession(false);
        if (session != null) {
            // 清除 session 中的所有属性
            session.invalidate();
        }
        // 重定向到登录页面
        resp.sendRedirect(req.getContextPath() + "/login.jsp");
    }

    // 也可以处理 POST 请求，通常 GET 就够了
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }
}