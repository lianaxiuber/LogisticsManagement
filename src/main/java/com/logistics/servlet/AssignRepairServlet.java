package com.logistics.servlet;

import com.logistics.dao.RepairOrderDAO;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/assignRepair")
public class AssignRepairServlet extends HttpServlet {
    private RepairOrderDAO orderDAO = new RepairOrderDAO();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int orderId = Integer.parseInt(req.getParameter("orderId"));
        int repairerId = Integer.parseInt(req.getParameter("repairerId"));
        // 更新报修单的 assignee_id 和状态
        boolean success = orderDAO.assignRepairer(orderId, repairerId);
        if (success) {
            resp.sendRedirect(req.getContextPath() + "/admin/repairList.jsp");
        } else {
            resp.getWriter().write("指派失败");
        }
    }
}