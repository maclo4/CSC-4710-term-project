package com.luv2code.jsp;

import java.util.ArrayList;
import java.util.List;

public class ItemClass {

	private List<String> price = new ArrayList<>();
	private List<String> itemID = new ArrayList<>();
	private List<String> title = new ArrayList<>();
	private List<String> description = new ArrayList<>();
	private List<String> datePosted = new ArrayList<>();
	private List<String> category = new ArrayList<>();
	
	public List<String> getTitle(){
		
		return title;
	}
	public void setTitle(List<String> p_title) {
		if(!title.isEmpty()) {
			title.clear();
		}
		title.addAll(p_title);
		System.out.println(title.get(0));
	}

	public List<String> getCategory(){
		
		return category;
	}
	public void setCategory(List<String> p_category) {
		if(!category.isEmpty()) {
			category.clear();
		}
		category.addAll(p_category);
		System.out.println(category.get(0) + ": it should be here");
	}
	public List<String> getPrice(){
	
		return price;
	}
	public void setPrice(List<String> p_price) {
		if(!price.isEmpty()) {
			price.clear();
		}
		price.addAll(p_price);
		System.out.println(price.get(0));
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
