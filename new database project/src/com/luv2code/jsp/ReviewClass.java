package com.luv2code.jsp;

import java.util.ArrayList;
import java.util.List;

public class ReviewClass {

	
	private List<String> itemID = new ArrayList<>();
	private List<String> title = new ArrayList<>();
	private List<String> description = new ArrayList<>();
	private List<String> datePosted = new ArrayList<>();
	private List<String> username = new ArrayList<>();
	private List<String> rating = new ArrayList<>();
	
	public List<String> getTitle(){
		
		return title;
	}
	public void setTitle(List<String> p_title) {
		if(!title.isEmpty()) {
			title.clear();
		}
		title.addAll(p_title);
		System.out.println("This the title that just got added to an itemClass object: " +title.get(0));
	}
public List<String> getRating(){
		
		return rating;
	}
	public void setRating(List<String> p_rating) {
		if(!rating.isEmpty()) {
			rating.clear();
		}
		rating.addAll(p_rating);
	
	}
	public List<String> getUsername(){
		
		return username;
	}
	public void setUsername(List<String> p_username) {
		if(!username.isEmpty()) {
			username.clear();
		}
		username.addAll(p_username);
		System.out.println(username.get(0));
	}

	
	public List<String> getID(){
		
		return itemID;
	}
	public void setID(List<String> p_ID) {
		if(!itemID.isEmpty()) {
			itemID.clear();
		}
		itemID.addAll(p_ID);
		System.out.println(itemID.get(0));
	}
	public List<String> getDescription(){
		
		return description;
	}
	public void setDescription(List<String> p_description) {
		if(!description.isEmpty()) {
			description.clear();
		}
		description.addAll(p_description);
		System.out.println(description.get(0));
	}
	
	public List<String> getDate(){
		
		return datePosted;
	}
	public void setDate(List<String> p_date) {
		if(!datePosted.isEmpty()) {
			datePosted.clear();
		}
		datePosted.addAll(p_date);
		System.out.println(datePosted.get(0));
	}
	
	
	
}

