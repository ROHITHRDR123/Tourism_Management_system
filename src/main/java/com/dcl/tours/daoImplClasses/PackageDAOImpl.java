package com.dcl.tours.daoImplClasses;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.dcl.tours.daoInterfaces.PackageDAO;
import com.dcl.tours.dto.Package;
import com.dcl.tours.utility.Connector;

public class PackageDAOImpl implements PackageDAO {
	Connection con = null;
	public PackageDAOImpl() {
		con =  Connector.requestConnection();
	}
	

	@Override
	public void createPackage(Package p) {
		String query = "INSERT INTO PACKAGE VALUE(0,?,?,?)";
		try {
			PreparedStatement ps = con.prepareStatement(query);
			ps.setString(1, p.getPname());
			ps.setDouble(2, p.getPrice());
			ps.setInt(3, p.getNo_of_days());
			ps.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}

	@Override
	public void updatePackage(Package p) {
		String query = "Update package set pname = ?, price = ?, no_of_days = ? where pid = ?";
		try {
			PreparedStatement ps = con.prepareStatement(query);
			ps.setString(1, p.getPname());
			ps.setDouble(2, p.getPrice());
			ps.setInt(3, p.getNo_of_days());
			ps.setInt(4, p.getPid());
			ps.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@Override
	public void deletePackage(Integer id) {
		String query = "Delete from package where pid = ?";
		try {
			PreparedStatement ps = con.prepareStatement(query);
			ps.setInt(1, id);
			ps.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}

	@Override
	public List<Package> getAllPackage() {
		String query = "Select * from package";
		Package p = null;
		List<Package> packagelist = new ArrayList<>();
		try {
			
			PreparedStatement ps = con.prepareStatement(query);
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				p = new Package();
				p.setPid(rs.getInt("pid"));
				p.setPname(rs.getString("pname"));
				p.setPrice(rs.getDouble("price"));
				p.setNo_of_days(rs.getInt("no_of_days"));
				
				packagelist.add(p);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return packagelist;
	}

	@Override
	public List<Package> getPackageById(Integer id) {
		String query = "Select * from package where pid = ?";
		Package p = null;
		List<Package> packagelist = new ArrayList<>();
		try {
			
			PreparedStatement ps = con.prepareStatement(query);
			ps.setInt(1, id);
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				p = new Package();
				p.setPid(rs.getInt("pid"));
				p.setPname(rs.getString("pname"));
				p.setPrice(rs.getDouble("price"));
				p.setNo_of_days(rs.getInt("no_of_days"));
				
				packagelist.add(p);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return packagelist;
	}
		
}
