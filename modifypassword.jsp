<%@ page language="java" import="java.util.*,java.sql.*"
contentType="text/html; charset=utf-8"%>
<%
	request.setCharacterEncoding("utf-8");
	String connectString = "jdbc:mysql://172.18.187.234:53306/nba15352188"+ "?autoReconnect=true&useUnicode=true&characterEncoding=UTF-8";
	String user="user"; 
	String pwd="123";
	String msg="";
	String pwd1="";
	Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection(connectString,user, pwd);
	Statement stmt = con.createStatement();
	String userName=session.getAttribute("username").toString();
	if(request.getMethod().equalsIgnoreCase("post")){
		pwd1=request.getParameter("pwd1");
		String sql="UPDATE user SET password='"+pwd1+"' WHERE username='"+userName+"';";
		int res=stmt.executeUpdate(sql);
		if(res>0){
 			response.sendRedirect("PersonalHomePage.jsp");
		}
	}
	stmt.close(); 
	con.close();
%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
	<meta charset="UTF-8">
	<title>修改密码</title>
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
		<div class="content">
			<h1>NEW PASSWORD</h1>
			 <form action="modifypassword.jsp" method="post">
				  <table align="center">
					    <tr>
					      <td>New Password：</td>
					      <td><input style="background:transparent; border-width:0.5px; border-radius:10px;" type="password" name="pwd1" id="pwd1"/></td>
					    </tr>
					    <tr>
					      <td>Confirm Password：</td>
					      <td><input style="background:transparent; border-width:0.5px; border-radius:10px;" type="password" name="pwd2" id='pwd2' onchange="test1()"></td>
					    </tr>
					    <%=msg %>
				  </table>
				  <p text-align:center><input style="background-color:rgba(248,243,212,0.5); border-radius:10px; width:200px" type="submit" name="register" value="Submit"></p>
				  <p text-align:center><input style="background-color:rgba(180,195,191,0.5); border-radius:10px; width:200px" type="button" onclick="javascript:window.location.href='PersonalHomePage.html';" value="Return"/>
			</form>
		</div>
		<script type="text/javascript">
			function myfunction(){
				var x=document.getElementById("pwd1").value;
				var y=document.getElementById("pwd2").value;
				if(x!=null&&x!=""&&y!=null&&y!=""){
				    return true;
				}
				alert("密码不能为空！")
				return false;
			}
			function test1(){
				var x=document.getElementById("pwd1").value;
				var y =document.getElementById("pwd2").value;
				if(y!=x){
				    alert("两次密码不一致！");
				    return false;
				}
				return true;
			}
			window.onsubmit=function(){
		 	    if(test1()&&myfunction()){
		 	        alert('修改密码成功');
		 	        return true;
		 	    }
		 	    return false;
			}
		</script>
	</div>
</body>
</html>