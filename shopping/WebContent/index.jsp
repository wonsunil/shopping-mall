<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<link rel="stylesheet" href="css/index.css">
	<%
	String section = request.getParameter("section") != null ? request.getParameter("section") : "";	
	%>
</head>
<body>
	<%@include file="static/header.jsp" %>
	<%@include file="static/nav.jsp" %>
	
	<%
		switch(section) {
		case "insert_sale" : %> <%@include file="page/insert_sale.jsp" %> <%
			break;
		case "total" : %> <%@include file="page/total.jsp" %> <%
			break;
		case "sales_by_product" : %> <%@include file="page/sales_by_product.jsp" %> <%
			break; 
		case "sales_by_category" : %> <%@include file="page/sales_by_category.jsp" %> <%
				break; 
		default : %> <%@include file="static/index.jsp" %>
	<%	
		}
	%>
	
	<%@include file="static/footer.jsp" %>
</body>
<script>
	document.querySelector("body > a").onclick = function(event) {
		if(event.target !== document.forms[0]) event.preventDefault();
	};
</script>
</html>