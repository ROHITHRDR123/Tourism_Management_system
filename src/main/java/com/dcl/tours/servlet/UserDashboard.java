package com.dcl.tours.servlet;

import java.io.IOException;
import java.util.List;

import com.dcl.tours.daoImplClasses.BookingDAOImpl;
import com.dcl.tours.daoImplClasses.LocationDAOImpl;
import com.dcl.tours.daoImplClasses.PackageDAOImpl;
import com.dcl.tours.daoInterfaces.BookingDAO;
import com.dcl.tours.daoInterfaces.LocationDAO;
import com.dcl.tours.daoInterfaces.PackageDAO;
import com.dcl.tours.dto.Booking;
import com.dcl.tours.dto.Location;
import com.dcl.tours.dto.Package;
import com.dcl.tours.dto.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/UserDashboard")
public class UserDashboard extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req,
            HttpServletResponse resp)
            throws ServletException, IOException {

        loadDashboard(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req,
            HttpServletResponse resp)
            throws ServletException, IOException {

        loadDashboard(req, resp);
    }

    private void loadDashboard(HttpServletRequest req,
            HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);

        if (session == null || session.getAttribute("user") == null) {
            resp.sendRedirect("index.jsp");
            return;
        }

        User user = (User) session.getAttribute("user");

        PackageDAO pdao = new PackageDAOImpl();
        LocationDAO ldao = new LocationDAOImpl();
        BookingDAO bdao = new BookingDAOImpl();

        List<Package> packages = pdao.getAllPackage();
        List<Location> locations = ldao.getAllLocation();

        // Logged in user's bookings
        List<Booking> bookings = bdao.getBookingByUserId(user.getUid());

        req.setAttribute("user", user);
        req.setAttribute("packages", packages);
        req.setAttribute("locations", locations);
        req.setAttribute("bookings", bookings);

        req.getRequestDispatcher("UserDashboard.jsp").forward(req, resp);
    }
}