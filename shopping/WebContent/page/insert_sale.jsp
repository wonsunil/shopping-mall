<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
	try {
		Class.forName("oracle.jdbc.OracleDriver");
		Connection conn = DriverManager.getConnection("jdbc:oracle:thin:@//localhost:1521/xe", "center_jsp", "1234");
%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form action="action/insert_sale.jsp" method="POST">
		<table border=1>
			<tr>
				<td>판매한 상품</td>
				<td>
					<select name="product_name">
						<%
							Statement stmt= conn.createStatement();
							ResultSet rs = stmt.executeQuery("SELECT NAME FROM PRODUCT");
						
							while(rs.next()) {
								%>
									<option value="<%=rs.getString(1) %>"><%=rs.getString(1) %></option>
								<%
							};
						%>
					</select>
				</td>
			</tr>
			<tr>
				<td>수량</td>
				<td><input name="amount" type="number"></td>
			</tr>
			<tr>
				<td>판매날짜</td>
				<td><input name="sale_date" type="date"></td>
			</tr>
			<tr>
				<td><input type="submit" value="등록하기"></td>
				<td><input type="button" value="다시쓰기" onclick="resetForm();"></td>
			</tr>
		</table>
	</form>
</body>
<script>
	window.onload = () => {
		document.forms[0].addEventListener("click", event => {
			if(document.querySelector("input[type=submit]") !== event.target) return event.preventDefault();
			
			if(submitForm()) return document.forms[0].submit();
		});
		
	};
	function submitForm() {
		event.preventDefault();
		
		if(document.forms[0].amount.value === "") {
			alert("판매 수량을 입력해야 합니다");
			return document.forms[0].amount.focus();
		};
		if(document.forms[0].sale_date.value === "") {
			alert("판매 일자를 입력해야 합니다");
			return document.forms[0].sale_date.focus();
		};
		
		alert("정상적으로 처리되었습니다");
		return true;	
	};
	function resetForm() {
		document.forms[0].reset();
	};
</script>

<%
		conn.commit();
		stmt.close();
		
		conn.close();
	} catch (Exception e) {
		e.printStackTrace();
	};	
%>