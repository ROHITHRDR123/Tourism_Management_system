package com.dcl.tours.servlet;

import java.io.IOException;
import java.util.List;

import com.dcl.tours.daoImplClasses.BookingDAOImpl;
import com.dcl.tours.daoImplClasses.PackageDAOImpl;
import com.dcl.tours.daoImplClasses.PaymentDAOImpl;
import com.dcl.tours.daoImplClasses.UserDAOImpl;
import com.dcl.tours.daoInterfaces.BookingDAO;
import com.dcl.tours.daoInterfaces.PackageDAO;
import com.dcl.tours.daoInterfaces.PaymentDAO;
import com.dcl.tours.daoInterfaces.UserDAO;
import com.dcl.tours.dto.Booking;
import com.dcl.tours.dto.Package;
import com.dcl.tours.dto.Payment;
import com.dcl.tours.dto.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/admin")
public class AdminDashboard extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);

        User admin = (session != null) ? (User) session.getAttribute("user") : null;

        if (admin == null || admin.getUid() != 1) {

            resp.sendRedirect("login.jsp");
            return;
        }

        UserDAO udao = new UserDAOImpl();
        PackageDAO pdao = new PackageDAOImpl();
        BookingDAO bdao = new BookingDAOImpl();
        PaymentDAO paydao = new PaymentDAOImpl();

        List<User> users = udao.getAllUser();
        List<Package> packages = pdao.getAllPackage();
        List<Booking> bookings = bdao.getAllBooking();
        List<Payment> payments = paydao.getAllPayment();

        req.setAttribute("admin", admin);
        req.setAttribute("users", users);
        req.setAttribute("packages", packages);
        req.setAttribute("bookings", bookings);
        req.setAttribute("payments", payments);

        req.getRequestDispatcher("admin.jsp").forward(req, resp);
    }
}
