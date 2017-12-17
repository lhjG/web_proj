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
	<title>Register</title>
	<style> 
		a:link,a:visited {color:blue;}
		.container{
			margin:0 auto;
			width:350px;
			height:300px;
			text-align:center;
			background:url(image/register_bk.jpg);
			background-size:cover;
			background-repeat:no-repeat;
			opacity:0.5;
			box-shadow:10px 10px 40px black, -10px 0px 40px black;
		}
		.loginimg{
			width:10%;
		}
		body{
			background-color:white;
		}
		.content{
			position:absolute;
			z-index:2;
		}
	</style>
</head>
<body>
	<div class="container">
		<div class="content" style="opacity:1;">
			<h1>Register</h1>
			<form action="register.jsp" method="post" name="form">
				<table align="center">
					<tr>
						<td><img src="https://i.imgur.com/CILkzmx.png" class="loginimg">Username:</td>
						<td><input style="background:transparent; border-width:0.5px; border-radius:10px;" name="username" type="text" value=<%=userName%>></td>
					</tr>
					<tr>
						<td><img src="https://i.imgur.com/gHbLuDS.png" class="loginimg">Password:</td>
						<td><input style="background:transparent; border-width:0.5px; border-radius:10px;" name="password" type="password" value=<%=password%>></td>
					</tr>
					<tr>
						<td><img src="https://i.imgur.com/gHbLuDS.png" class="loginimg">Confirmpassword:</td>
						<td><input style="background:transparent; border-width:0.5px; border-radius:10px;" name="confirmpassword" type="password" value=<%=password%>></td>
					</tr>
				</table>
				<p text-align:center><input style="background-color:rgba(248,243,212,0.5); border-radius:10px; width:200px" type="submit" name="register" value="Register"></p>
				<p text-align:center><input style="background-color:rgba(180,195,191,0.5); border-radius:10px; width:200px" type="button" onclick="javascript:window.location.href='home.jsp';" value="Return"/>
			</form>
			<%=msg%>
		</div>
	</div>
</body>
</html>