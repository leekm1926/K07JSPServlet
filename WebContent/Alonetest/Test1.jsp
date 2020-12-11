<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
    	Date today = new Date();
    %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>test1</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</head>
<body>
<%-- <%
	String bookTitle = "JSP프로그래밍"; 
	String author = "이강민";
%>
<b><%= bookTitle %></b>[<%= author %>]입니다.  --%>

<%-- <%
	Calendar cal = Calendar.getInstance();
%>
<%=cal.get(Calendar.YEAR) %>년
<%=cal.get(Calendar.MONTH)+1 %>월
<%=cal.get(Calendar.DATE) %>일 --%>

<%
	int sum = 0;
	
	for(int i=1; i<=10; i++){
		sum = sum + i;
	}
%>

1~10까지의 합 : <%= sum %>
<br />
<%=1+2+3+43 %>


</body>
</html>