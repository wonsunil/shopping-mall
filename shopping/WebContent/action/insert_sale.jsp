<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
	request.setCharacterEncoding("UTF-8");

	String product_name = request.getParameter("product_name");
	int amount = Integer.parseInt(request.getParameter("amount"));
	String sale_date = request.getParameter("sale_date");
	
	try{
		Class.forName("oracle.jdbc.OracleDriver");
		Connection conn = DriverManager.getConnection("jdbc:oracle:thin:@//localhost:1521/xe", "center_jsp", "1234");
		
		Statement stmt = conn.createStatement();
		Statement stmt_id = conn.createStatement();
		Statement stmt_price = conn.createStatement();
		
		String id_query = "SELECT PRODUCT_ID FROM PRODUCT WHERE NAME = '%s'";
		ResultSet rs_id = stmt_id.executeQuery(String.format(id_query, product_name));;
		rs_id.next();
		
		String price_query = "SELECT SUM(PRICE * '%d') FROM PRODUCT, SALE WHERE PRODUCT.PRODUCT_ID = SALE.PRODUCT_ID AND PRODUCT.NAME = '%s'";
		ResultSet rs_price = stmt_price.executeQuery(String.format(price_query, amount, product_name));
		rs_price.next();
		
		String query = "INSERT INTO SALE(SALE_ID, PRODUCT_ID, PURCHASE_DATE, SALE_PRICE, AMOUNT) " + 
					   " VALUES(SEQ_SALE.NEXTVAL, '%s', '%s', '%d', '%d')";
		
		out.println(rs_id.getString(1));
		out.println(String.format(query, rs_id.getString(1), sale_date, rs_price.getInt(1), amount));
		ResultSet rs = stmt.executeQuery(String.format(query, rs_id.getString(1), sale_date, rs_price.getInt(1), amount));
		
		conn.commit();
		
		stmt.close();
		conn.close();
		
	} catch (Exception e) {
		
	};
	
	response.sendRedirect("../index.jsp");
%>