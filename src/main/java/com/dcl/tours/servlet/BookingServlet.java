package com.dcl.tours.servlet;

import java.io.IOException;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;

import com.dcl.tours.daoImplClasses.BookingDAOImpl;
import com.dcl.tours.daoImplClasses.PackageDAOImpl;
import com.dcl.tours.daoInterfaces.BookingDAO;
import com.dcl.tours.daoInterfaces.PackageDAO;
import com.dcl.tours.dto.Booking;
import com.dcl.tours.dto.Package;
import com.dcl.tours.dto.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/booking")
public class BookingServlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		System.out.println("BookingServlet doPost called");

		HttpSession session = req.getSession();
		User user = (User) session.getAttribute("user");

		if (user == null) {
			resp.sendRedirect("index.jsp");
			return;
		}

		int pid = Integer.parseInt(req.getParameter("pid"));

		String startDateStr = req.getParameter("startDate");
		String endDateStr = req.getParameter("endDate");

		LocalDate startDate = LocalDate.parse(startDateStr);
		LocalDate endDate = LocalDate.parse(endDateStr);

		// Validate end date
		if (!endDate.isAfter(startDate)) {
			req.setAttribute("error", "End date must be after Start date.");
			req.getRequestDispatcher("bookPackage.jsp?pid=" + pid).forward(req, resp);
			return;
		}

		// Get package details
		PackageDAO pdao = new PackageDAOImpl();
		Package pack = pdao.getPackageById(pid).get(0);

		// Calculate number of days
		long selectedDays = ChronoUnit.DAYS.between(startDate, endDate);

		// Validate duration
		if (selectedDays != pack.getNo_of_days()) {

			req.setAttribute("error", "This package can only be booked for exactly " + pack.getNo_of_days() + " days.");

			req.getRequestDispatcher("bookPackage.jsp?pid=" + pid).forward(req, resp);
			return;
		}

		Booking booking = new Booking();
		booking.setUid(user.getUid());
		booking.setPid(pid);
		booking.setStart_date(startDateStr);
		booking.setEnd_date(endDateStr);
		booking.setStatus("PENDING");

		BookingDAO bdao = new BookingDAOImpl();
		bdao.createBooking(booking);

		req.setAttribute("success", "Package Booked Successfully.");
		req.getRequestDispatcher("UserDashboard").forward(req, resp);
	}
}