package com.dcl.tours.daoImplClasses;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.dcl.tours.daoInterfaces.PaymentDAO;
import com.dcl.tours.dto.Payment;
import com.dcl.tours.utility.Connector;

public class PaymentDAOImpl implements PaymentDAO{

	

	    private Connection con;

	    public PaymentDAOImpl() {
	        this.con = Connector.requestConnection();
	    }

	    @Override
	    public void createPayment(Payment p) {

	        String query = "INSERT INTO payment(pay_mode, uid, pid, amount, total_amt) VALUES(?,?,?,?,?)";

	        try (PreparedStatement ps = con.prepareStatement(query)) {

	            ps.setString(1, p.getPay_mode());
	            ps.setInt(2, p.getUid());
	            ps.setInt(3, p.getPid());
	            ps.setDouble(4, p.getAmount());
	            ps.setDouble(5, p.getTotal_amount());

	            ps.executeUpdate();

	            System.out.println("Payment Added Successfully");

	        } catch (SQLException e) {
	            System.out.println("Error Adding Payment : " + e.getMessage());
	        }

	    }

	    @Override
	    public void deletePayment(Integer id) {

	        String query = "DELETE FROM payment WHERE pay_id=?";

	        try (PreparedStatement ps = con.prepareStatement(query)) {

	            ps.setInt(1, id);

	            ps.executeUpdate();

	            System.out.println("Payment Deleted Successfully");

	        } catch (SQLException e) {
	            System.out.println("Error Deleting Payment : " + e.getMessage());
	        }

	    }

	    @Override
	    public List<Payment> getAllPayment() {

	        List<Payment> paymentList = new ArrayList<>();

	        String query = "SELECT * FROM payment";

	        try (PreparedStatement ps = con.prepareStatement(query)) {

	            ResultSet rs = ps.executeQuery();

	            while (rs.next()) {

	                Payment payment = new Payment();

	                payment.setPay_id(rs.getInt("pay_id"));
	                payment.setPay_mode(rs.getString("pay_mode"));
	                payment.setUid(rs.getInt("uid"));
	                payment.setPid(rs.getInt("pid"));
	                payment.setAmount(rs.getDouble("amount"));
	                payment.setTotal_amount(rs.getDouble("total_amt"));

	                paymentList.add(payment);
	            }

	        } catch (SQLException e) {

	            System.out.println("Error Fetching Payments : " + e.getMessage());

	        }

	        return paymentList;
	    }

	    @Override
	    public List<Payment> getPaymentById(Integer id) {

	        List<Payment> paymentList = new ArrayList<>();

	        String query = "SELECT * FROM payment WHERE pay_id=?";

	        try (PreparedStatement ps = con.prepareStatement(query)) {

	            ps.setInt(1, id);

	            ResultSet rs = ps.executeQuery();

	            while (rs.next()) {

	                Payment payment = new Payment();

	                payment.setPay_id(rs.getInt("pay_id"));
	                payment.setPay_mode(rs.getString("pay_mode"));
	                payment.setUid(rs.getInt("uid"));
	                payment.setPid(rs.getInt("pid"));
	                payment.setAmount(rs.getDouble("amount"));
	                payment.setTotal_amount(rs.getDouble("total_amt"));

	                paymentList.add(payment);

	            }

	        } catch (SQLException e) {

	            System.out.println("Error Fetching Payment : " + e.getMessage());

	        }

	        return paymentList;
	    }

	}