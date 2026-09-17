package com.dcl.tours.daoImplClasses;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.dcl.tours.daoInterfaces.BookingDAO;
import com.dcl.tours.dto.Booking;
import com.dcl.tours.utility.Connector;

public class BookingDAOImpl implements BookingDAO {

	private Connection con;

	public BookingDAOImpl() {
		this.con = Connector.requestConnection();
	}

	@Override
	public void createBooking(Booking b) {
		String query = "Insert into booking values(0,?,?,?,?,?)";
		int i = 0;
		try {
			PreparedStatement ps = con.prepareStatement(query);
			ps.setInt(1, b.getUid());
			ps.setInt(2, b.getPid());
			ps.setDate(3, Date.valueOf(b.getStart_date()));
			ps.setDate(4, Date.valueOf(b.getEnd_date()));
			ps.setString(5, b.getStatus());
			i = ps.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		if (i > 0) {
			System.out.println("booking added");
		}

	}

	@Override
	public void updateBooking(Booking b) {
		String query = "Update booking set UID=?,PID=?, START_DATE=?, END_DATE=? where BID=?";
		int i = 0;
		try {
			PreparedStatement ps = con.prepareStatement(query);
			ps.setInt(1, b.getUid());
			ps.setInt(2, b.getPid());
			ps.setDate(3, Date.valueOf(b.getStart_date()));
			ps.setDate(4, Date.valueOf(b.getEnd_date()));
			ps.setInt(5, b.getBid());
			i = ps.executeUpdate();

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		if (i > 0) {
			System.out.println("booking updated");
		}

	}

	@Override
	public void deleteBooking(Integer b) {
		String query = "DELETE FROM booking WHERE BID=?";
		int i = 0;
		try {
			PreparedStatement ps = con.prepareStatement(query);
			ps.setInt(1, b);
			i = ps.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		if (i > 0) {
			System.out.println("booking deleted!");
		}

	}

	@Override
	public List<Booking> getAllBooking() {
		List<Booking> bookingList = new ArrayList<Booking>();
		Booking b = null;
		String query = "SELECT * FROM booking";
		try {
			PreparedStatement ps = con.prepareStatement(query);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				b = new Booking();
				b.setBid(rs.getInt("BID"));
				b.setUid(rs.getInt("UID"));
				b.setPid(rs.getInt("PID"));
				b.setStart_date(String.valueOf(rs.getDate("START_DATE"))); // Converts SQL Date back to String
				b.setEnd_date(String.valueOf(rs.getDate("END_DATE")));
				b.setStatus(rs.getString("STATUS"));
				bookingList.add(b);
				System.out.println("booking added!");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return bookingList;
	}

	@Override
	public List<Booking> getBookingById(Integer id) {
		List<Booking> bookingList = new ArrayList<Booking>();
		Booking b = null;
		String query = "SELECT * FROM booking WHERE BID=?";
		try {
			PreparedStatement ps = con.prepareStatement(query);
			ps.setInt(1, id);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				b = new Booking();
				b.setBid(rs.getInt("BID"));
				b.setUid(rs.getInt("UID"));
				b.setPid(rs.getInt("PID"));
				b.setStart_date(String.valueOf(rs.getDate("START_DATE")));
				b.setEnd_date(String.valueOf(rs.getDate("END_DATE")));
				b.setStatus(rs.getString("STATUS"));
				bookingList.add(b);
				System.out.println(b.getBid());
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return bookingList;
	}
	@Override
	public List<Booking> getBookingByUserId(Integer uid) {

	    List<Booking> bookingList = new ArrayList<>();

	    String query = "SELECT * FROM booking WHERE UID=?";

	    try {
	        PreparedStatement ps = con.prepareStatement(query);
	        ps.setInt(1, uid);

	        ResultSet rs = ps.executeQuery();

	        while (rs.next()) {

	            Booking b = new Booking();

	            b.setBid(rs.getInt("BID"));
	            b.setUid(rs.getInt("UID"));
	            b.setPid(rs.getInt("PID"));
	            b.setStart_date(String.valueOf(rs.getDate("START_DATE")));
	            b.setEnd_date(String.valueOf(rs.getDate("END_DATE")));
	            b.setStatus(rs.getString("STATUS"));

	            bookingList.add(b);
	        }

	    } catch (SQLException e) {
	        e.printStackTrace();
	    }

	    return bookingList;
	}
	@Override
	public void approveBooking(Integer bid) {

	    String query = "UPDATE booking SET STATUS='APPROVED' WHERE BID=?";

	    try {

	        PreparedStatement ps = con.prepareStatement(query);
	        ps.setInt(1, bid);

	        if (ps.executeUpdate() > 0) {
	            System.out.println("Booking Approved");
	        }

	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	}
	@Override
	public void rejectBooking(Integer bid) {

	    String query = "UPDATE booking SET STATUS='REJECTED' WHERE BID=?";

	    try {

	        PreparedStatement ps = con.prepareStatement(query);
	        ps.setInt(1, bid);

	        if (ps.executeUpdate() > 0) {
	            System.out.println("Booking Rejected");
	        }

	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	}
	@Override
	public boolean updateBookingStatus(int bid, String status) {

	    String sql = "UPDATE booking SET status=? WHERE bid=?";

	    try {

//	        Connection con = DBConnection.getConnection();
	        PreparedStatement ps = con.prepareStatement(sql);

	        ps.setString(1, status);
	        ps.setInt(2, bid);

	        return ps.executeUpdate() > 0;

	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    return false;
	}

}
