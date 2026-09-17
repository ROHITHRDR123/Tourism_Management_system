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

@WebServlet("/bill")
public class BillServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {

		HttpSession session = req.getSession(false);

		if (session == null || session.getAttribute("user") == null) {
			resp.sendRedirect("index.jsp");
			return;
		}

		User user = (User) session.getAttribute("user");

		String bidValue = req.getParameter("bid");

		if (bidValue == null) {
			resp.sendRedirect("UserDashboard");
			return;
		}

		int bid = Integer.parseInt(bidValue);

		BookingDAO bdao = new BookingDAOImpl();
		PackageDAO pdao = new PackageDAOImpl();
		PaymentDAO paydao = new PaymentDAOImpl();

		/* ---------- Booking ---------- */

		Booking booking = null;

		List<Booking> bookingList = bdao.getBookingById(bid);

		if (!bookingList.isEmpty()) {
			booking = bookingList.get(0);
		}

		if (booking == null) {

			req.setAttribute("error", "Booking Not Found.");

			req.getRequestDispatcher("UserDashboard")
					.forward(req, resp);

			return;
		}

		/* ---------- Package ---------- */

		Package pack = null;

		List<Package> packageList = pdao.getPackageById(booking.getPid());

		if (!packageList.isEmpty()) {
			pack = packageList.get(0);
		}

		if (pack == null) {

			req.setAttribute("error", "Package Not Found.");

			req.getRequestDispatcher("UserDashboard")
					.forward(req, resp);

			return;
		}

		/* ---------- Payment ---------- */

		Payment payment = null;

		List<Payment> paymentList = paydao.getAllPayment();

		for (Payment p : paymentList) {

			if (p.getUid().equals(user.getUid())
					&& p.getPid().equals(pack.getPid())) {

				payment = p;
				break;
			}
		}

		if (payment == null) {

			req.setAttribute("error",
					"Payment Details Not Found.");

			req.getRequestDispatcher("UserDashboard")
					.forward(req, resp);

			return;
		}

		/* ---------- Send To JSP ---------- */

		req.setAttribute("user", user);
		req.setAttribute("booking", booking);
		req.setAttribute("package", pack);
		req.setAttribute("payment", payment);
		req.setAttribute("success", "Payment Successful.");

		req.getRequestDispatcher("bill.jsp")
				.forward(req, resp);

	}

}