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

@WebServlet("/signup")
public class SignUp extends HttpServlet{

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {

		UserDAO udao = new UserDAOImpl();

		User alreadyExists = udao.getUserByEmail(req.getParameter("email"));

		if(alreadyExists == null) {

			if(req.getParameter("password")
					.equals(req.getParameter("confirm"))) {

				User user = new User();

				user.setUname(req.getParameter("name"));
				user.setPhno(req.getParameter("phone"));
				user.setEmail(req.getParameter("email"));
				user.setPassword(req.getParameter("password"));

				udao.createUser(user);

				req.setAttribute("signupSuccess", "Account Created Successfully!");

				req.getRequestDispatcher("login.jsp").forward(req, resp);

			}
			else {

				req.setAttribute("signupError", "Password Mismatch!");

				req.getRequestDispatcher("login.jsp").forward(req, resp);

			}

		}
		else {

			req.setAttribute("signupError", "Email Already Exists!");

			req.getRequestDispatcher("login.jsp").forward(req, resp);

		}

	}

}