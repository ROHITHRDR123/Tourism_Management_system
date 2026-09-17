package com.dcl.tours.servlet;

import java.io.IOException;

import com.dcl.tours.daoImplClasses.BookingDAOImpl;
import com.dcl.tours.daoInterfaces.BookingDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/rejectBooking")
public class RejectBookingServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req,
            HttpServletResponse resp)
            throws ServletException, IOException {

        int bid = Integer.parseInt(req.getParameter("bid"));

        BookingDAO dao = new BookingDAOImpl();

        dao.rejectBooking(bid);

        resp.sendRedirect("admin");
    }
}