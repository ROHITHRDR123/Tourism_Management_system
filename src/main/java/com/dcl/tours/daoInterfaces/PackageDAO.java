package com.dcl.tours.daoInterfaces;

import java.util.List;

public interface PackageDAO {
	
	public void createPackage(com.dcl.tours.dto.Package p);
	
	public void updatePackage(com.dcl.tours.dto.Package p);
	
	public void deletePackage(Integer id);
	
	public List<com.dcl.tours.dto.Package> getAllPackage();
	
	public List<com.dcl.tours.dto.Package> getPackageById(Integer id);

}
