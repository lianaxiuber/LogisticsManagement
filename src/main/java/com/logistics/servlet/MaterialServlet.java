package com.logistics.servlet;

import com.logistics.dao.MaterialDAO;
import com.logistics.model.Material;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/admin/material")
public class MaterialServlet extends HttpServlet {
    private MaterialDAO materialDAO = new MaterialDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) action = "list";

        switch (action) {
            case "delete":
                deleteMaterial(req, resp);
                break;
            case "edit":
                showEditForm(req, resp);
                break;
            case "add":
                showAddForm(req, resp);
                break;
            default:
                listMaterials(req, resp);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if ("update".equals(action)) {
            updateMaterial(req, resp);
        } else {
            addMaterial(req, resp);
        }
    }

    // 显示物资列表
    private void listMaterials(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setAttribute("materials", materialDAO.getAllMaterials());
        req.getRequestDispatcher("/admin/materialList.jsp").forward(req, resp);
    }

    // 显示添加表单
    private void showAddForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/admin/materialForm.jsp").forward(req, resp);
    }

    // 显示编辑表单
    private void showEditForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        Material m = materialDAO.getMaterialById(id);
        req.setAttribute("material", m);
        req.getRequestDispatcher("/admin/materialForm.jsp").forward(req, resp);
    }

    // 添加物资
    private void addMaterial(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String name = req.getParameter("name");
        int quantity = Integer.parseInt(req.getParameter("quantity"));
        String unit = req.getParameter("unit");
        String location = req.getParameter("location");

        Material m = new Material(name, quantity, unit, location);
        materialDAO.addMaterial(m);
        resp.sendRedirect(req.getContextPath() + "/admin/material?action=list");
    }

    // 更新物资
    private void updateMaterial(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        String name = req.getParameter("name");
        int quantity = Integer.parseInt(req.getParameter("quantity"));
        String unit = req.getParameter("unit");
        String location = req.getParameter("location");

        Material m = new Material(name, quantity, unit, location);
        m.setId(id);
        materialDAO.updateMaterial(m);
        resp.sendRedirect(req.getContextPath() + "/admin/material?action=list");
    }

    // 删除物资
    private void deleteMaterial(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        materialDAO.deleteMaterial(id);
        resp.sendRedirect(req.getContextPath() + "/admin/material?action=list");
    }
}