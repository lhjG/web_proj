<%@ page language="java" import="java.util.*,java.sql.*"
contentType="text/html; charset=utf-8"%>
<%
	request.setCharacterEncoding("utf-8");
	String connectString = "jdbc:mysql://172.18.187.234:53306/nba15352188"+ "?autoReconnect=true&useUnicode=true&characterEncoding=UTF-8";
	String user="user"; 
	String pwd="123";
	String msg="";
	String pw1="";
	String pw2="";
	Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection(connectString,user, pwd);
	Statement stmt = con.createStatement();
	String userName=session.getAttribute("username").toString();
	if(request.getMethod().equalsIgnoreCase("post")){
		pw1=request.getParameter("pw1");
		pw2=request.getParameter("pw1");
		String sql="UPDATE user SET password='"+pw1+"' WHERE username='"+userName+"';";
		int res=stmt.executeUpdate(sql);
		if(res>0){
			response.sendRedirect("PersonalHomePage.jsp");
		}
	}
%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="UTF-8">
<title>修改密码</title>
</head>
<body>
 <form action="modifypassword.jsp" method="post">
  <table align="center">
    <tr>
      <td>新密码：</td>
      <td><input type="password" name="pwd1" id="pwd1"/></td>
    </tr>
    <tr>
      <td>确认密码：</td>
      <td><input type="password" name="pwd2" id='pwd2' onchange="test1()"></td>
    </tr>
    <tr>
      <td colspan="2" align="center"><input type="submit" value="提交" onclick="myfunction()" />
        &nbsp;&nbsp;&nbsp;&nbsp;
        <input type="reset" value="清空"/></td>
    </tr>
    <%=userName %>
  </table>
</form>
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
 	    return　false; 
	}
</script>
</body>
</html>