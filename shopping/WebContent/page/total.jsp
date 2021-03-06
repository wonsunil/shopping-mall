<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="shopping.DB" %>
	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<%
	try {
		String query = "SELECT " +
        			"SALE.SALE_ID, " +
        			"NAME, " +
        			"PURCHASE_DATE, " + 
        			"SALE_PRICE, " +
        			"AMOUNT " +
        			"FROM PRODUCT, SALE " + 
        			"WHERE " + 
        				"PRODUCT.PRODUCT_ID = SALE.PRODUCT_ID " + 
        			"ORDER BY " + 
        				"PURCHASE_DATE";
        
        ResultSet rs = DB.fetch(query);
%>
	<table border=1>
		<thead>
			<tr>
				<td>판매 ID</td>
				<td>상품명</td>
				<td>구매 일자</td>
				<td>총 구매 금액</td>
				<td>구매 개수</td>
			</tr>
		</thead>
		<tbody>
<%
        while (rs.next()) {

        	%>
			<tr>
				<td><%=rs.getInt(1)%></td>
				<td><%=rs.getString(2)%></td>
				<td><%=rs.getString(3)%></td>
				<td><%=rs.getInt(4)%></td>
				<td><%=rs.getInt(5)%></td>
			</tr>
			<%	
		}; 
		
		rs.close();
		} catch (Exception ignord) {}
%>
		</tbody>
	</table>
</body>
</html>