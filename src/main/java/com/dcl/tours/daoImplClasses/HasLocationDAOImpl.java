package com.dcl.tours.daoImplClasses;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.dcl.tours.daoInterfaces.HasLocationDAO;
import com.dcl.tours.dto.HasLocation;
import com.dcl.tours.utility.Connector;

public class HasLocationDAOImpl implements HasLocationDAO {

	Connection con = null;

	public HasLocationDAOImpl() {
		con = Connector.requestConnection();
	}

	@Override
	public void createHasLocation(HasLocation hl) {

		String query = "INSERT INTO has_location VALUE(0,?,?)";

		try {
			PreparedStatement ps = con.prepareStatement(query);

			ps.setInt(1, hl.getPid());
			ps.setInt(2, hl.getLid());

			ps.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		}

	}

	@Override
	public void updateHasLocation(HasLocation hl) {

		String query = "UPDATE has_location SET pid = ?, lid = ? WHERE hlid = ?";

		try {
			PreparedStatement ps = con.prepareStatement(query);

			ps.setInt(1, hl.getPid());
			ps.setInt(2, hl.getLid());
			ps.setInt(3, hl.getHlid());

			ps.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		}

	}

	@Override
	public void deleteHasLocation(Integer id) {

		String query = "DELETE FROM has_location WHERE hlid = ?";

		try {
			PreparedStatement ps = con.prepareStatement(query);

			ps.setInt(1, id);

			ps.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		}

	}

	@Override
	public List<HasLocation> getAllHasLocation() {

		String query = "SELECT * FROM has_location";

		HasLocation hl = null;
		List<HasLocation> hasLocationList = new ArrayList<>();

		try {

			PreparedStatement ps = con.prepareStatement(query);

			ResultSet rs = ps.executeQuery();

			while (rs.next()) {

				hl = new HasLocation();

				hl.setHlid(rs.getInt("hlid"));
				hl.setPid(rs.getInt("pid"));
				hl.setLid(rs.getInt("lid"));

				hasLocationList.add(hl);

			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return hasLocationList;
	}

	@Override
	public List<HasLocation> getHasLocationById(Integer id) {

		String query = "SELECT * FROM has_location WHERE hlid = ?";

		HasLocation hl = null;
		List<HasLocation> hasLocationList = new ArrayList<>();

		try {

			PreparedStatement ps = con.prepareStatement(query);

			ps.setInt(1, id);

			ResultSet rs = ps.executeQuery();

			while (rs.next()) {

				hl = new HasLocation();

				hl.setHlid(rs.getInt("hlid"));
				hl.setPid(rs.getInt("pid"));
				hl.setLid(rs.getInt("lid"));

				hasLocationList.add(hl);

			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return hasLocationList;
	}

}