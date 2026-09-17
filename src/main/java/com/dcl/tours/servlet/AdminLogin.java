package com.dcl.tours.servlet;

import java.io.IOException;

import com.dcl.tours.daoImplClasses.UserDAOImpl;
import com.dcl.tours.daoInterfaces.UserDAO;
import com.dcl.tours.dto.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/adminLogin")
public class AdminLogin extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        UserDAO udao = new UserDAOImpl();

        String adminId = req.getParameter("adminId");
        String password = req.getParameter("password");

        User admin = udao.getUserByEmailAndPassword(adminId, password);

        if (admin != null && admin.getUid() == 1) {

            HttpSession session = req.getSession();
            session.setAttribute("user", admin);

            resp.sendRedirect("admin");

        } else {

            req.setAttribute("loginError", "Invalid Admin ID or Password.");

            req.getRequestDispatcher("login.jsp").forward(req, resp);
        }
    }
}
