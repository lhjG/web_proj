<%@ page language="java" import="java.util.*,java.sql.*"
contentType="text/html; charset=utf-8"%>
<% 
	request.setCharacterEncoding("utf-8");
	String connectString = "jdbc:mysql://172.18.187.234:53306/nba15352188"+ "?autoReconnect=true&useUnicode=true&characterEncoding=UTF-8";
	String user="user"; 
	String pwd="123";
	String userName="";
	String news1="";
	String news2="";
	String news3="";
	String news4="";
	String news5="";
	String news6="";
	String news7="";
	String content1="";
	String content2="";
	String content3="";
	String content4="";
	String content5="";
	String content6="";
	String content7="";
	if(session.getAttribute("username")!=null)
		userName=session.getAttribute("username").toString();
	String headPortraitPath="image/user1.png";
	String nickname="";
	int ifHaveHeadPortrait=0;
	Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection(connectString,user,pwd);
	Statement stmt = con.createStatement();
	try{
		ResultSet rs = stmt.executeQuery("select * from user WHERE username= '" + userName + "';");
		while(rs.next()){
			ifHaveHeadPortrait=rs.getInt("ifhaveheadportrait");
			if(ifHaveHeadPortrait==1){
				headPortraitPath="image/"+userName+".jpg";
			}
		}
		rs=stmt.executeQuery("select * from article");
		while(rs.next()){
			int i=rs.getInt("id");
			if(i==1){
				news1=rs.getString("title");
				content1=rs.getString("content");
			}
			if(i==2){
				news2=rs.getString("title");
				content2=rs.getString("content");
			}
			if(i==3){
				news3=rs.getString("title");
				content3=rs.getString("content");
			}
			if(i==4){
				news4=rs.getString("title");
				content4=rs.getString("content");
			}
			if(i==5){
				news5=rs.getString("title");
				content5=rs.getString("content");
			}
			if(i==6){
				news6=rs.getString("title");
				content6=rs.getString("content");
			}
			if(i==7){
				news7=rs.getString("title");
				content7=rs.getString("content");
			}
		}
	}catch (Exception e){}
	stmt.close(); 
	con.close();
%>
<!doctype html>
<html>
<head>
	<meta charset="utf-8">
	<title>主页</title>
	<link href="主页.css" rel="stylesheet" type="text/css">
<script>
</script>
</head>
<body>
	<div id="header">
		<div id="menu">
			<a href="http://china.nba.com/"><img id="logo" src="image/篮球3.png"/></a>
			<div id="user">
				<a href="justify.jsp"><img src="<%=headPortraitPath%>"/></a>
				<div id="login">
					<a class="block2" href="register.jsp">注册</a>
					<button class="block2" onclick="test1()">登陆</button>
					<button class="block2" onclick="test2()">注销</button>
				</div>
			</div>
		</div>
		<div id="animation">
			<img src="image/ball4.gif"/>
		</div>
		<div class="line"></div>
	</div>
	<div id="main-content">
		<div class="section1">
			<div id="scrolling">
				<ul id="pic" type="none">
					<li id="p1"><img src="image/lbt1.jpg" alt="轮播图1" width="369" height="250"/></li>
					<li id="p2"><img src="image/lbt2.jpg" alt="轮播图2"/></li>
					<li id="p3"><img src="image/lbt3.jpg" alt="轮播图3"/></li>
				</ul>
				<ul id="scr-nav">
					<li id="b1"><a href="#p1">·</a></li>
					<li id="b2"><a href="#p2">·</a></li>
					<li id="b3"><a href="#p3">·</a></li>
				</ul>
			</div>
			<div id="news">
				<div id="news-header">
					<div id="newslogo"><a href=""><img src="image/篮球4.png"/></a></div>
					<div class="block1">
						要闻
					</div>
					<div class="line"></div>
				</div>
				<div id="news-main">
					<ul type="none">
						<li><a href=""><%=news1 %></a></li>
						<li class="summary"><%=content1 %></li>
						<li><a href=""><%=news2 %></a></li>
						<li class="summary"><%=content2 %></li>
						<li><a href=""><%=news3 %></a></li>
						<li class="summary"><%=content3 %></li>
						<li><a href=""><%=news4 %></a></li>
						<li class="summary"><%=content4 %></li>
						<li><a href=""><%=news5 %></a></li>
						<li class="summary"><%=content5%></li>
						<li><a href=""><%=news6 %></a></li>
						<li class="summary"><%=content6 %></li>
						<li><a href=""><%=news7 %></a></li>
						<li class="summary"><%=content7 %></li>
					</ul>
					<ul type="none" id="jump">
						<li><a href="news.jsp?title=<%=news1 %>">    </a></li>
						<li><a href="news.jsp?title=<%=news2 %>">    </a></li>
						<li><a href="news.jsp?title=<%=news3 %>">    </a></li>
						<li><a href="news.jsp?title=<%=news4 %>">    </a></li>
						<li><a href="news.jsp?title=<%=news5 %>">    </a></li>
						<li><a href="news.jsp?title=<%=news6 %>">    </a></li>
						<li><a href="news.jsp?title=<%=news7 %>">    </a></li>
					</ul>
				</div>
			</div>
		</div>
		<div class="section2">
			<div id="rank">
				<div id="area">
					<table  class="head">	
					  <tr>
					    <th colspan="1" rowspan="8">东部</th>
					  </tr>
					</table>
					<div id="rt1">
						<table>
						  <thead>
						  </thead>
						  <tfoot></tfoot>
						  <tbody>
							<tr>
							  <td colspan="1">排名</td>
							  <td colspan="1"></td>
							  <td colspan="2">姓名</td>
							  <td colspan="1">胜</td>
							  <td colspan="1">负</td>
							  <td colspan="2">胜场差</td>
							</tr>
							<tr>
							  <td colspan="1">01</td>
							  <td colspan="1"><img src="image/Celtics.png"/></td>
							  <td colspan="2"><a href="http://china.nba.com/celtics/">凯尔特人</a></td>
							  <td colspan="1">24</td>
							  <td colspan="1">6</td>
							  <td colspan="2">0</td>
							</tr>
							<tr>
							  <td colspan="1">02</td>
							  <td colspan="1"><img src="image/Cleveland.png"/></td>
							  <td colspan="2"><a href="http://china.nba.com/cavaliers/">骑士</a></td>
							  <td colspan="1">21</td>
							  <td colspan="1">8</td>
							  <td colspan="2">2.5</td>
							</tr>
							<tr>
							  <td colspan="1">03</td>
							  <td colspan="1"><img src="image/raptor.png"/></td>
							  <td colspan="2"><a href="http://china.nba.com/teams/#!/raptors">猛龙</a></td>
							  <td colspan="1">18</td>
							  <td colspan="1">8</td>
							  <td colspan="2">4</td>
							</tr>
							<tr>
							  <td colspan="1">04</td>
							  <td colspan="1"><img src="image/east4.png"/></td>
							  <td colspan="2"><a href="http://china.nba.com/teams/#!/bucks">雄鹿</a></td>
							  <td colspan="1">15</td>
							  <td colspan="1">11</td>
							  <td colspan="2">7</td>
							</tr>
							<tr>
							  <td colspan="1">05</td>
							  <td colspan="1"><img src="image/east5.png"/></td>
							  <td colspan="2"><a href="http://china.nba.com/pacers/">步行者</a></td>
							  <td colspan="1">16</td>
							  <td colspan="1">12</td>
							  <td colspan="2">7</td>
							</tr>
							<tr>
							  <td colspan="1">06</td>
							  <td colspan="1"><img src="image/east6.png"/></td>
							  <td colspan="2"><a href="http://china.nba.com/teams/#!/wizards">奇才</a></td>
							  <td colspan="1">15</td>
							  <td colspan="1">13</td>
							  <td colspan="2">8</td>
							</tr>
							<tr>
							  <td colspan="1">07</td>
							  <td colspan="1"><img src="image/east7.png"/></td>
							  <td colspan="2"><a href="http://china.nba.com/pistons/">活塞</a></td>
							  <td colspan="1">15</td>
							  <td colspan="1">13</td>
							  <td colspan="2">8</td>
							</tr>
							<tr>
							  <td colspan="1">08</td>
							  <td colspan="1"><img src="image/east8.png"/></td>
							  <td colspan="2"><a href="http://china.nba.com/teams/#!/knicks">尼克斯</a></td>
							  <td colspan="1">15</td>
							  <td colspan="1">13</td>
							  <td colspan="2">8</td>
							</tr>
						  </tbody>
						</table>
					</div>
				</div>
			</div>
			<div id="rank2">
				<div id="area2">
					<table class="head">	
					  <tr>
					    <th colspan="1" rowspan="8">西部</th>
					  </tr>
					</table>
					<div id="rt2">
						<table>
						  <thead>
						  </thead>
						  <tfoot></tfoot>
						  <tbody>
							<tr>
							  <td colspan="1">排名</td>
							  <td colspan="1"></td>
							  <td colspan="2">姓名</td>
							  <td colspan="1">胜</td>
							  <td colspan="1">负</td>
							  <td colspan="2">胜场差</td>
							</tr>
							<tr>
							  <td colspan="1">01</td>
							  <td colspan="1"><img src="image/west1.png"/></td>
							  <td colspan="2"><a href="http://china.nba.com/rockets/">火箭</a></td>
							  <td colspan="1">22</td>
							  <td colspan="1">4</td>
							  <td colspan="2">0</td>
							</tr>
							<tr>
							  <td colspan="1">02</td>
							  <td colspan="1"><img src="image/west2.png"/></td>
							  <td colspan="2"><a href="http://china.nba.com/warriors/">勇士</a></td>
							  <td colspan="1">23</td>
							  <td colspan="1">6</td>
							  <td colspan="2">0.5</td>
							</tr>
							<tr>
							  <td colspan="1">03</td>
							  <td colspan="1"><img src="image/west3.png"/></td>
							  <td colspan="2"><a href="http://china.nba.com/spurs/">马刺</a></td>
							  <td colspan="1">19</td>
							  <td colspan="1">9</td>
							  <td colspan="2">4</td>
							</tr>
							<tr>
							  <td colspan="1">04</td>
							  <td colspan="1"><img src="image/west4.png"/></td>
							  <td colspan="2"><a href="http://china.nba.com/timberwolves/">森林狼</a></td>
							  <td colspan="1">17</td>
							  <td colspan="1">12</td>
							  <td colspan="2">6.5</td>
							</tr>
							<tr>
							  <td colspan="1">05</td>
							  <td colspan="1"><img src="image/west5.png"/></td>
							  <td colspan="2"><a href="http://china.nba.com/nuggets/">掘金</a></td>
							  <td colspan="1">15</td>
							  <td colspan="1">13</td>
							  <td colspan="2">8</td>
							</tr>
							<tr>
							  <td colspan="1">06</td>
							  <td colspan="1"><img src="image/west6.png"/></td>
							  <td colspan="2"><a href="http://china.nba.com/blazers/">开拓者</a></td>
							  <td colspan="1">14</td>
							  <td colspan="1">13</td>
							  <td colspan="2">8.5</td>
							</tr>
							<tr>
							  <td colspan="1">07</td>
							  <td colspan="1"><img src="image/west7.png"/></td>
							  <td colspan="2"><a href="http://china.nba.com/pelicans/">鹈鹕</a></td>
							  <td colspan="1">15</td>
							  <td colspan="1">14</td>
							  <td colspan="2">8.5</td>
							</tr>
							<tr>
							  <td colspan="1">08</td>
							  <td colspan="1"><img src="image/west8.png"/></td>
							  <td colspan="2"><a href="http://china.nba.com/thunder/">雷霆</a></td>
							  <td colspan="1">13</td>
							  <td colspan="1">14</td>
							  <td colspan="2">9.5</td>
							</tr>
						  </tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div id="footer">
		footer
	</div>
	<script type="text/javascript">
			function test1(){
				var x="<%=userName%>"
				if(x!=""){
					alert("您已经登陆")
					return false;
				}
				window.location.href='login.jsp';
				return true;
			}
			function test2(){
				var x="<%=userName%>"
		 	    if(x==""){
		 	    	alert("您还未登陆")
		 	    	return false;
		 	    }
		 	    window.location.href='logoutsuccessfully.jsp';
		 		return true;
			}
	</script>
</body>
</html>
