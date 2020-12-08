<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="shopping.DB" %>

<%
	request.setCharacterEncoding("UTF-8");

	String product_name = request.getParameter("product_name");
	int amount = Integer.parseInt(request.getParameter("amount"));
	String sale_date = request.getParameter("sale_date");
	
	String[] id_data = {product_name};
	String[] price_datas = {Integer.toString(amount), product_name};
	
	try{
		String id_query = "SELECT PRODUCT_ID FROM PRODUCT WHERE NAME = ?";
		ResultSet rs_id = DB.fetch(id_query, id_data);
		rs_id.next();
		
		String price_query = "SELECT SUM(PRICE * ?) FROM PRODUCT, SALE WHERE PRODUCT.PRODUCT_ID = SALE.PRODUCT_ID AND PRODUCT.NAME = ?";
		ResultSet rs_price = DB.fetch(price_query, price_datas);
		rs_price.next();
		
		String query = "INSERT INTO SALE(SALE_ID, PRODUCT_ID, PURCHASE_DATE, SALE_PRICE, AMOUNT) " + 
					   " VALUES(SEQ_SALE.NEXTVAL, ?, ?, ?, ?)";
		
		String[] datas = {rs_id.getString(1), sale_date, Integer.toString(rs_price.getInt(1)), Integer.toString(amount)};
		DB.execute(query, datas);
		
		rs_id.close();
		rs_price.close();
	} catch (Exception e) {
		
	};
	
	response.sendRedirect("../index.jsp");
%>