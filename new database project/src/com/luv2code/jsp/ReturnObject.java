package com.luv2code.jsp;

import java.util.ArrayList;
import java.util.List;

public class ReturnObject {

	private List<String> categories = new ArrayList<>();
	private List<String> itemID = new ArrayList<>();
	
	public List<String> getCategories(){
	
		return categories;
	}
	public void setCategories(List<String> p_categories) {
		if(!categories.isEmpty()) {
			categories.clear();
		}
		categories.addAll(p_categories);
		System.out.println(categories.get(0));
	}
	
}
