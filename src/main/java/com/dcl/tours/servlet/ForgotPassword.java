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

@WebServlet("/forgotPassword")
public class ForgotPassword extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req,
            HttpServletResponse resp)
            throws ServletException, IOException {

        UserDAO udao = new UserDAOImpl();

        String email = req.getParameter("email");
        String password = req.getParameter("password");
        String confirm = req.getParameter("confirm");

        User user = udao.getUserByEmail(email);

        if (user == null) {

            req.setAttribute("error", "Email does not exist.");
            req.getRequestDispatcher("forgotPassword.jsp")
                    .forward(req, resp);

        } else if (!password.equals(confirm)) {

            req.setAttribute("error", "Password and Confirm Password do not match.");
            req.getRequestDispatcher("forgotPassword.jsp")
                    .forward(req, resp);

        } else {

            boolean updated = udao.updatePassword(email, password);

            if (updated) {

                req.setAttribute("signupSuccess",
                        "Password Updated Successfully. Please Login.");

                req.getRequestDispatcher("login.jsp")
                        .forward(req, resp);

            } else {

                req.setAttribute("error",
                        "Unable to update password.");

                req.getRequestDispatcher("forgotPassword.jsp")
                        .forward(req, resp);
            }
        }
    }
}