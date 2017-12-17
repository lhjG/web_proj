<%@ page language="java" import="java.util.*,java.sql.*"
contentType="text/html; charset=utf-8"%>
<% request.setCharacterEncoding("utf-8");
	String connectString = "jdbc:mysql://172.18.187.234:53306/nba15352188"+ "?autoReconnect=true&useUnicode=true&characterEncoding=UTF-8";
	String user="user"; 
	String pwd="123";
	String userName = session.getAttribute("username").toString();
	String msg="";
	String motto = "";
	String headPortrait="";
	String headPortraitPath="";
	String nickname="";
	int ifHaveHeadPortrait=0;
	int ifHaveNickname=0;
	int ifHaveMotto=0;
	int id=0;
	Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection(connectString,user, pwd);
	Statement stmt = con.createStatement();
	try{
		ResultSet rs = stmt.executeQuery("select * from user WHERE username= '" + userName + "';");
		while(rs.next()){
			motto = rs.getString("motto");
			ifHaveHeadPortrait=rs.getInt("ifhaveheadportrait");
			ifHaveNickname=rs.getInt("ifhavenickname");
			ifHaveMotto=rs.getInt("ifhavemotto");
			id=rs.getInt("id");
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
	}catch (Exception e){}
%>
<!DOCTYPE HTML>
<html>
<head>
    <title>个人中心</title>
    <style>
    	#topimage{width:4%}
        html {
            font-family:宋体;
            font-size:20px;
        }
        body {
           background-image:url(image/bk.jpg);
           background-repeat:no-repeat;
           background-size:cover;
           color:white;
        }
        #header {
            position: fixed;
            background-color: rgba(0,0,0,0.1);
            height: 30px;
            width: 100%;
            left:0;
            top:0;
            z-index: 1;
        }
        #profile{
        	margin:0 auto;
        	width:400px;
        	height:200px;
        	background-color:rgba(100,100,100,0.1);
        }
        .nav{
            float: right;
            font-size: 0.5em;
            line-height: 30px;
        }
        #title{
            width: 100%; 
            margin:0 auto;          
        }
        #headportrait{
            width: 10%;
            border-radius:50%;
        }
        #profile_head{
        	margin:0 auto;
        }
        #sidenav{
        	position:absolute;
        	top:20px;
        	left:10px;
        	width:100px;
        	font-size:0.5em;
        }
        a{color:white;}
    </style>
</head>
<body>
    <div id="header">
        <div id="header_inner">
            <div class="nav">
                <a href="home.html">主页</a>|<a href="#">注销</a>
            </div>
        </div>
    </div>
    <div id="title">
        <h1 style="text-align:center">Hi！你好呀</h1>
    </div>
    <div id="profile">
        <p style="text-align:center"><img id="headportrait" src=<%=headPortraitPath%>></p>
        <p style="text-align:center"><%=nickname%></p><br><br>
        <p style="text-align:center"><%=motto%></p><br><br>
    </div>
    <div id="sidenav">
    	<ul>
    		<li><a href="completedata.jsp">完善资料</a>
    		<li><a href="completedata.jsp">我的关注</a>
    		<li><a href="modifypassword.jsp">修改密码</a>
    	</ul>
    </div>
</body>
</html>
