package com.logistics.filter;

import com.logistics.model.User;
import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebFilter("/*")
public class LoginFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;

        String uri = req.getRequestURI();

        // 放行资源：登录页面、登录请求、静态资源（css/js/图片）、公共资源
        if (uri.endsWith("login.jsp") || uri.endsWith("login")
                || uri.contains("/css/") || uri.contains("/js/") || uri.contains("/fonts/")
                || uri.contains("/common/")) {
            chain.doFilter(request, response);
            return;
        }

        HttpSession session = req.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("currentUser") : null;

        // 未登录，重定向到登录页
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        // 角色路径权限控制
        if (uri.contains("/admin/") && !"admin".equals(user.getRoleName())) {
            resp.sendError(HttpServletResponse.SC_FORBIDDEN, "无权限访问");
            return;
        }
        if (uri.contains("/repairer/") && !"repairer".equals(user.getRoleName())) {
            resp.sendError(HttpServletResponse.SC_FORBIDDEN, "无权限访问");
            return;
        }
        if (uri.contains("/user/") && !"user".equals(user.getRoleName())) {
            resp.sendError(HttpServletResponse.SC_FORBIDDEN, "无权限访问");
            return;
        }

        // 通过校验，继续请求
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        chain.doFilter(request, response);
    }

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // 初始化代码，可以为空
    }

    @Override
    public void destroy() {
        // 销毁代码，可以为空
    }
}