<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	try {
		Class.forName("oracle.jdbc.OracleDriver");
		Connection conn = DriverManager.getConnection("jdbc:oracle:thin:@//localhost/xe", "center_jsp", "1234");
        Statement stmt = conn.createStatement();
        String query = "SELECT " +
				"NAME, " +
				"SUM(SALE_PRICE), " +
				"SUM(AMOUNT) " + 
				"FROM " +
					"PRODUCT, " +
					"SALE WHERE PRODUCT.PRODUCT_ID = SALE.PRODUCT_ID " +
				"GROUP BY " +
					"PRODUCT.PRODUCT_ID, PRODUCT.NAME";
        ResultSet rs = stmt.executeQuery(String.format(query)); 
%>
	<table border=1>
		<thead>
			<tr>
				<td>상품명</td>
				<td>총 판매 금액</td>
				<td>판매 개수</td>
			</tr>
		</thead>
		<tbody>
<%
        while (rs.next()) {
        	%>
			<tr>
				<td><%=rs.getString(1)%></td>
				<td><%=rs.getInt(2)%></td>
				<td><%=rs.getInt(3)%></td>
			</tr>
			<%	
		}; 
 
		stmt.close();
		conn.close();
		
		} catch (Exception ignord) {}
%>
		</tbody>
	</table>
</body>
</html>