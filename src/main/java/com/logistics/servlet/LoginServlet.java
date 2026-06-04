package com.logistics.servlet;

import com.logistics.dao.UserDAO;
import com.logistics.model.User;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String username = req.getParameter("username");
        String password = req.getParameter("password");

        User user = userDAO.login(username, password);
        if (user != null) {
            HttpSession session = req.getSession();
            session.setAttribute("currentUser", user);
            // 暂时所有角色都跳到同一个测试页（避免404）
            if ("admin".equals(user.getRoleName())) {
                resp.sendRedirect(req.getContextPath() + "/admin/index.jsp");
            } else if ("repairer".equals(user.getRoleName())) {
                resp.sendRedirect(req.getContextPath() + "/repairer/index.jsp");
            } else {
                resp.sendRedirect(req.getContextPath() + "/user/index.jsp");
            };
        } else {
            req.setAttribute("error", "用户名或密码错误");
            req.getRequestDispatcher("login.jsp").forward(req, resp);
        }
    }
}