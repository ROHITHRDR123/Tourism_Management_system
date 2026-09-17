package com.dcl.tours.daoInterfaces;

import java.util.List;

import com.dcl.tours.dto.User;

public interface UserDAO {
	
	public void createUser(User u);
	
	public void updateUser(User u);
	
	public void deleteUser(Integer u);
	
	public List<User> getAllUser();
	
	public List<User> getUserById(Integer id);
	
	public User getUserByEmail(String email);

	public User getUserByEmailAndPassword(String email,String password);
	
	boolean updatePassword(String email, String password);

}
