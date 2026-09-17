package com.dcl.tours.servlet;

import java.io.IOException;
import java.util.List;

import com.dcl.tours.daoImplClasses.BookingDAOImpl;
import com.dcl.tours.daoImplClasses.PackageDAOImpl;
import com.dcl.tours.daoImplClasses.PaymentDAOImpl;
import com.dcl.tours.daoInterfaces.BookingDAO;
import com.dcl.tours.daoInterfaces.PackageDAO;
import com.dcl.tours.daoInterfaces.PaymentDAO;
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

@WebServlet("/payment")
public class PaymentServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req,
            HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);

        if (session == null || session.getAttribute("user") == null) {
            resp.sendRedirect("index.jsp");
            return;
        }

        String bidValue = req.getParameter("bid");

        if (bidValue == null) {
            resp.sendRedirect("UserDashboard");
            return;
        }

        int bid = Integer.parseInt(bidValue);

        BookingDAO bdao = new BookingDAOImpl();
        PackageDAO pdao = new PackageDAOImpl();

        List<Booking> bookingList = bdao.getBookingById(bid);

        if (bookingList.isEmpty()) {
            resp.sendRedirect("UserDashboard");
            return;
        }

        Booking booking = bookingList.get(0);

        List<Package> packageList =
                pdao.getPackageById(booking.getPid());

        if (packageList.isEmpty()) {
            resp.sendRedirect("UserDashboard");
            return;
        }

        Package pack = packageList.get(0);

        req.setAttribute("booking", booking);
        req.setAttribute("package", pack);

        req.getRequestDispatcher("payment.jsp")
                .forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req,
            HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);

        if (session == null || session.getAttribute("user") == null) {

            resp.sendRedirect("index.jsp");
            return;
        }

        User user = (User) session.getAttribute("user");

        int bid = Integer.parseInt(req.getParameter("bid"));

        BookingDAO bdao = new BookingDAOImpl();
        PackageDAO pdao = new PackageDAOImpl();
        PaymentDAO paydao = new PaymentDAOImpl();

        List<Booking> bookingList =
                bdao.getBookingById(bid);

        if (bookingList.isEmpty()) {

            resp.sendRedirect("UserDashboard");
            return;
        }

        Booking booking = bookingList.get(0);

        List<Package> packageList =
                pdao.getPackageById(booking.getPid());

        if (packageList.isEmpty()) {

            resp.sendRedirect("UserDashboard");
            return;
        }

        Package pack = packageList.get(0);

        Payment payment = new Payment();

        payment.setPay_mode(req.getParameter("pay_mode"));

        payment.setUid(user.getUid());

        payment.setPid(pack.getPid());

        Double baseAmount = pack.getPrice();
        Double gst = baseAmount * 0.18;
        Double totalAmount = baseAmount + gst;

        payment.setAmount(baseAmount);

        payment.setTotal_amount(totalAmount);

        paydao.createPayment(payment);

        resp.sendRedirect("bill?bid=" + booking.getBid());

    }

}