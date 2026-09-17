package com.dcl.tours.daoInterfaces;

import java.util.List;

import com.dcl.tours.dto.Payment;

public interface PaymentDAO {
	
	public void createPayment(Payment p);
	
	public void deletePayment(Integer id);
	
	public List<Payment> getAllPayment();
	
	public List<Payment> getPaymentById(Integer id);
	
	

}
