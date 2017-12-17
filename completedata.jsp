<%@ page language="java" import="java.util.*,java.sql.*"
contentType="text/html; charset=utf-8"%>
<%@ page import="java.io.*,java.util.*,org.apache.commons.io.*"%>
<%@ page import="org.apache.commons.fileupload.*"%>
<%@ page import="org.apache.commons.fileupload.disk.*"%>
<%@ page import="org.apache.commons.fileupload.servlet.*"%>
<%request.setCharacterEncoding("utf-8");
String connectString = "jdbc:mysql://172.18.187.234:53306/nba15352188"+ "?autoReconnect=true&useUnicode=true&characterEncoding=UTF-8";
String user="user"; 
String pwd="123";
String msg="";
Class.forName("com.mysql.jdbc.Driver");
Connection con = DriverManager.getConnection(connectString,user, pwd);
Statement stmt = con.createStatement();
String userName=session.getAttribute("username").toString();
ResultSet rs = stmt.executeQuery("select * from user WHERE username= '" + userName + "';");
String nickname = "";
String region = "";
String status = "";
String team="";
String other = "";
String motto = "";
String submit1 = "";
String submit2 = "";
String headPortraitPath="";
String fileName="";
int ifHaveHeadPortrait;
int ifHaveNickname;
int ifHaveMotto;
int id;
String Id="";
while(rs.next()){
	motto = rs.getString("motto");
	ifHaveHeadPortrait=rs.getInt("ifhaveheadportrait");
	ifHaveNickname=rs.getInt("ifhavenickname");
	ifHaveMotto=rs.getInt("ifhavemotto");
	id=rs.getInt("id");
	status = rs.getString("status");
	team = rs.getString("team");
	region = rs.getString("region");
	if(ifHaveHeadPortrait==1){
		headPortraitPath="image/"+userName+".jpg";
	}
	else{
		headPortraitPath="image/defaulthead.jpg";
	}
	if(ifHaveNickname==1){
		nickname=rs.getString("nickname");
	}
	else{
		nickname="用户"+id;
	}
	if(ifHaveMotto==1){
		motto=rs.getString("motto");
	}
	else{
		motto="您暂时还没有自己的签名，快快添加吧";
	}
}		
if(request.getMethod().equalsIgnoreCase("post")){
	nickname = request.getParameter("nickname");
	status = request.getParameter("status");
	team = request.getParameter("team");
	other = request.getParameter("other");
	region = request.getParameter("region");
	motto = request.getParameter("motto");
	submit1 = request.getParameter("save");
	submit2 = request.getParameter("exit");
	String sql="";
	if(submit2!=null) response.sendRedirect("PersonalHomePage.jsp");
	if(!motto.equals("") && nickname.equals("")){
		sql="UPDATE user SET motto='"+motto+"', ifhavemotto=1 WHERE username='"+userName+"';";
	}
	if(!nickname.equals("")&&!motto.equals("")){
		sql="UPDATE user SET nickname='"+nickname+"', motto='"+motto+"', ifhavemotto=1, ifhavenickname=1 WHERE username='"+userName+"';";
	}
	if(!nickname.equals("")&&motto.equals("")){
		sql="UPDATE user SET nickname='"+nickname+"', ifhavenickname=1 WHERE username='"+userName+"';";
	}
	if(nickname.equals("")&&motto.equals("")){
		
	}
	int res=stmt.executeUpdate(sql);
	if(res>0){
		msg="修改成功！";
		response.sendRedirect("PersonalHomePage.jsp");
	}
	stmt.close(); 
	con.close();
} %>
<!DOCTYPEHTML>
<html>
<head><title>postInput</title></head>
<body>
	<form action="completedata.jsp" method="post">
		<input type="hidden"name="id"value="12345"/><br><br>
		昵称: <input type="text"name="nickname" value="<%=nickname %>"/><br><br>
		身份: 小学生<input type="radio"name="status"value="小学生" <%=status.equals("小学生")?"checked":"" %>/>
		中学生<input type="radio"name="status"value="中学生" <%=status.equals("中学生")?"checked":"" %>/>
		大学生<input type="radio"name="status"value="大学生" <%=status.equals("大学生")?"checked":"" %>/>
		社会人士<input type="radio"name="status"value="社会人士" <%=status.equals("社会人士")?"checked":"" %>/>
		资深球友<input type="radio"name="status"value="资深球友" <%=status.equals("资深球友")?"checked":"" %>/><br><br>
		居住地：<select name="region">
				<option value="Guangdong" <%=region.equals("Guangdong")?"selected":"" %>>广东</option>
				<option value="Beijing" <%=region.equals("Beijing")?"selected":"" %>>北京</option>
				<option value="Hebei" <%=region.equals("Hebei")?"selected":"" %>>河北</option>
				<option value="Shanghai" <%=region.equals("Shanghai")?"selected":"" %>>上海</option>
				<option value="Shenzhen" <%=region.equals("Shenzhen")?"selected":"" %>>深圳</option>
			</select><br><br>
		我喜欢的球队: 骑士<input type="checkbox"name="team" value="cle" <%=team.equals("cle")?"selected":"" %>/>
			 勇士<input type="checkbox"name="team" value="gsw" <%=team.equals("gsw")?"selected":"" %>/>
			 马刺<input type="checkbox"name="team" value="sas" <%=team.equals("sas")?"selected":"" %>/><br><br>
		个性签名: <textarea rows="5"cols="30" name="motto"><%=motto %></textarea><br><br>
		<input type="submit"name="submit1"value="保存"/>
		<input type="submit"name="submit2"value="退出"/>
	</form>
	<%=msg %>
</body>
</html>