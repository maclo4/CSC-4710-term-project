package com.luv2code.jsp;

import java.util.ArrayList;
import java.util.List;

public class UserClass {

	private List<String> username = new ArrayList<>();
	private List<String> password = new ArrayList<>();
	private List<String> email = new ArrayList<>();
	private List<String> firstName = new ArrayList<>();
	private List<String> lastName = new ArrayList<>();
	private List<String> gender = new ArrayList<>();
	private List<String> age = new ArrayList<>();
	
	public List<String> getPassword(){
		
		return password;
	}
	public void setPassword(List<String> p_password) {
		if(!password.isEmpty()) {
			password.clear();
		}
		password.addAll(p_password);
		
	}
	public List<String> getUsername(){
		
		return username;
	}
	public void setUsername(List<String> p_username) {
		if(!username.isEmpty()) {
			username.clear();
		}
		username.addAll(p_username);
	}

	public List<String> getEmail(){
		
		return email;
	}
	public void setEmail(List<String> p_email) {
		if(!email.isEmpty()) {
			email.clear();
		}
		email.addAll(p_email);
		
	}
	public List<String> getFirstName(){
	
		return firstName;
	}
	public void setFirstName(List<String> p_first) {
		if(!firstName.isEmpty()) {
			firstName.clear();
		}
		firstName.addAll(p_first);
		
	}
	public List<String> getGender(){
		
		return gender;
	}
	public void setgender(List<String> p_gender) {
		if(!gender.isEmpty()) {
			gender.clear();
		}
		gender.addAll(p_gender);
		
	}
public List<String> getAge(){
		
		return age;
	}
	public void setAge(List<String> p_age) {
		if(!age.isEmpty()) {
			age.clear();
		}
		age.addAll(p_age);
		
	}
	
	
	
}
