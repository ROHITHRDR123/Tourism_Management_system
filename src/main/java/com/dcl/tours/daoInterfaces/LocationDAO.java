package com.dcl.tours.daoInterfaces;

import java.util.List;

import com.dcl.tours.dto.Location;

public interface LocationDAO {
	
	public void createLocation(Location l);
	
	public void updateLocation(Location l);
	
	public void deleteLocation(Integer id);
	
	public List<Location> getAllLocation();
	
	public List<Location> getLocationById(Integer id);

}
