<%@page import="java.util.Map"%>
<%@page import="java.util.Enumeration"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
    	request.setCharacterEncoding("utf-8");
    %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</head>
<body>
	<strong>request.getParameter()메서드 사용</strong> <br />
	name 파라미터 = <%=request.getParameter("name")%> <br />
	address 파라미터 = <%=request.getParameter("address") %> <br />
	<p>
		<b>request.getParameterValues()메서드 사용</b> <br />
		<%
			String[] values = request.getParameterValues("pet");
		if(values != null){
			for(int i=0; i< values.length; i++){
				%>
				<%=values[i] %>
				<%
			}
		}
		%>
	</p>
	<b>request.getParameterNames()메서드 사용</b> <br />
	<%
		Enumeration paramEnum = request.getParameterNames();
	while(paramEnum.hasMoreElements()){
		String name = (String)paramEnum.nextElement();
		%>
		<%=name %>
		<% 
	}
	%>
	<p>
		<b>request.getParameterMap()메서드 사용</b> <br />
		<%
		Map parameterMap = request.getParameterMap();
		String[] nameParam = (String[])parameterMap.get("name");
		if(nameParam != null){
		%>
		name=<%= nameParam[0] %>
		<%
		}
		%>
	</p>
</body>
</html>