<%@ page language="java" import="java.util.*,java.sql.*"
contentType="text/html; charset=utf-8"%>
<% request.setCharacterEncoding("utf-8");
	String msg = "";
	String connectString = "jdbc:mysql://172.18.187.234:53306/nba15352188"+ "?autoReconnect=true&useUnicode=true&characterEncoding=UTF-8";
	String user="user"; 
	String pwd="123";
	String userName = "";
	String password = "";
	String confirmPassword = request.getParameter("confirmpassword");
	if(request.getMethod().equalsIgnoreCase("post")){
		userName = request.getParameter("username");
		password = request.getParameter("password");
		Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection(connectString,user, pwd);
		Statement stmt = con.createStatement();
		try{
			if(confirmPassword.equals(password)){
				ResultSet rs = stmt.executeQuery("select * from user WHERE username= '" + userName + "';");
				boolean ifUsed=false;
				while(rs.next()){
					ifUsed = true;
				}
				if(!ifUsed){
					String fmt2="insert into user(username,password) values('%s', '%s')";
					String sql2 = String.format(fmt2,userName,password);
					int cnt = stmt.executeUpdate(sql2);
					if(cnt>0)	msg = "欢迎加入我们!";
					session.setAttribute("username", userName);
					stmt.close(); 
					con.close();
					response.sendRedirect("PersonalHomePage.jsp");
				}
				else{
					userName="";
					msg="用户名已被占用";
				}
			}
			else{
				password="";
				msg = "两次密码输入不相同，请再次确认您的密码";
			}
		}
		catch (Exception e){
			msg = e.getMessage();
		}
	}
%>
<!DOCTYPE HTML>
<html>
<head>
	<title>用户注册</title>
	<style> 
		a:link,a:visited {color:blue;}
		.container{
			margin:0 auto;
			width:500px;
			text-align:center;
		}
	</style>
</head>
<body>
	<div class="container">
		<h1>新用户注册</h1>
		<form action="register.jsp" method="post" name="form">
			用户名:<input name="username" type="text" value=<%=userName%>><br><br>
			密码:<input name="password" type="password" value=<%=password%>><br><br>
			确认密码:<input name="confirmpassword" type="password" value=<%=password%>><br><br>
			<input type="submit" name="register" value="注册">
			<input type="button" onclick="javascript:window.location.href='home.html';" value="返回"/><br><br><br><br>
		</form>
		<%=msg%>
	</div>
</body>
</html>