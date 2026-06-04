package com.logistics.servlet;

import com.logistics.dao.RepairOrderDAO;
import com.logistics.model.User;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/completeOrder")
public class CompleteOrderServlet extends HttpServlet {
    private RepairOrderDAO orderDAO = new RepairOrderDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 只有维修员可以访问
        HttpSession session = req.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("currentUser") : null;
        if (user == null || !"repairer".equals(user.getRoleName())) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        String orderIdParam = req.getParameter("orderId");
        if (orderIdParam != null && !orderIdParam.isEmpty()) {
            int orderId = Integer.parseInt(orderIdParam);
            boolean success = orderDAO.completeOrder(orderId);
            if (success) {
                // 完成后刷新工单列表
                resp.sendRedirect(req.getContextPath() + "/repairer/index.jsp");
            } else {
                resp.getWriter().write("操作失败，请重试");
            }
        } else {
            resp.sendRedirect(req.getContextPath() + "/repairer/index.jsp");
        }
    }
}