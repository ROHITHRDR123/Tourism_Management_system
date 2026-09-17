package com.dcl.tours.daoImplClasses;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.dcl.tours.daoInterfaces.LocationDAO;
import com.dcl.tours.dto.Location;
import com.dcl.tours.utility.Connector;

public class LocationDAOImpl implements LocationDAO {

	Connection con = null;

	public LocationDAOImpl() {
		con = Connector.requestConnection();
	}

	@Override
	public void createLocation(Location l) {
		String query = "Insert into location(lname, address, description, city_name, image_path, pid) value(?, ?, ?, ?, ?, ?)";
		try {
			PreparedStatement ps = con.prepareStatement(query);
			ps.setString(1, l.getLname());
			ps.setString(2, l.getAddress());
			ps.setString(3, l.getDescription());
			ps.setString(4, l.getCity_name());
			ps.setString(5, l.getImage_path());
			ps.setInt(6, l.getPid());
			ps.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

	@Override
	public void updateLocation(Location l) {
		String query = "Update location set Lname = ?, Address = ?, Description = ?, City_name = ?, image_path = ?, pid = ? where lid = ?";
		try {
			PreparedStatement ps = con.prepareStatement(query);
			ps.setString(1, l.getLname());
			ps.setString(2, l.getAddress());
			ps.setString(3, l.getDescription());
			ps.setString(4, l.getCity_name());
			ps.setString(5, l.getImage_path());
			ps.setInt(6, l.getPid());
			ps.setInt(7, l.getLid());
			ps.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

	@Override
	public void deleteLocation(Integer id) {
		String query = "delete from location where lid = ?";

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
	public List<Location> getAllLocation() {
		String query = "select * from location";
		List<Location> locationList = new ArrayList<>();
		Location l = null;
		try {
			PreparedStatement ps = con.prepareStatement(query);
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				l = new Location();
				l.setLid(rs.getInt("Lid"));
				l.setLname(rs.getString("lname"));
				l.setAddress(rs.getString("address"));
				l.setDescription(rs.getString("description"));
				l.setCity_name(rs.getString("city_name"));
				l.setImage_path(rs.getString("image_path"));
				l.setPid(rs.getInt("pid"));
				locationList.add(l);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return locationList;
	}

	@Override
	public List<Location> getLocationById(Integer id) {
		String query = "select * from location where lid = ?";
		List<Location> locationList = new ArrayList<>();
		Location l = null;
		try {
			PreparedStatement ps = con.prepareStatement(query);
			ps.setInt(1, id);
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				l = new Location();
				l.setLid(rs.getInt("Lid"));
				l.setLname(rs.getString("lname"));
				l.setAddress(rs.getString("address"));
				l.setDescription(rs.getString("description"));
				l.setCity_name(rs.getString("city_name"));
				l.setImage_path(rs.getString("image_path"));
				l.setPid(rs.getInt("pid"));
				locationList.add(l);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return locationList;
	}



}
