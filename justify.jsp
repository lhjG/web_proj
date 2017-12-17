<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%
	String ses="";
	if(session.getAttribute("username")!=null){
		ses=session.getAttribute("username").toString();
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
</head>
<body>
	<script type="text/javascript">
		var x="<%=ses%>"
		if(x==""){
			alert("您还未登陆!")
			window.location.href='home.jsp';
		}
		else{
			window.location.href='PersonalHomePage.jsp';
		}
    </script>
</body>
</html>