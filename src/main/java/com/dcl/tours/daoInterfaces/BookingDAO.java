package com.dcl.tours.daoInterfaces;

import java.util.List;

import com.dcl.tours.dto.Booking;

public interface BookingDAO {
	
	public void createBooking(Booking b);
	
	public void updateBooking(Booking b);
	
	public void deleteBooking(Integer b);
	
	public List<Booking> getAllBooking();
	
	public List<Booking> getBookingById(Integer id);
	List<Booking> getBookingByUserId(Integer uid);
	
	public void approveBooking(Integer bid);

	public void rejectBooking(Integer bid);
	public boolean updateBookingStatus(int bid, String status);

}
