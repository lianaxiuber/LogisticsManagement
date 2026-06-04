package com.logistics.servlet;

import com.logistics.dao.RepairOrderDAO;
import com.logistics.model.RepairOrder;
import com.logistics.model.User;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/submitRepair")
public class SubmitRepairServlet extends HttpServlet {
    private RepairOrderDAO orderDAO = new RepairOrderDAO();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");   // 加上这一行，解决中文乱码
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("currentUser");
        if (user == null || !"user".equals(user.getRoleName())) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        String title = req.getParameter("title");
        String description = req.getParameter("description");
        String room = req.getParameter("room");

        RepairOrder order = new RepairOrder();
        order.setTitle(title);
        order.setDescription(description);
        order.setRoom(room);
        order.setSubmitterId(user.getId());

        boolean success = orderDAO.addOrder(order);
        if (success) {
            resp.sendRedirect(req.getContextPath() + "/user/myRepairs.jsp");
        } else {
            req.setAttribute("error", "提交失败，请重试");
            req.getRequestDispatcher("/user/submitRepair.jsp").forward(req, resp);
        }
    }
}