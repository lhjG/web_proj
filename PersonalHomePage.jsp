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
	Connection con = DriverManager.getConnection(connectString,user,pwd);
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
	stmt.close(); 
	con.close();
%>
<!DOCTYPE HTML>
<html>
<head>
    <title>个人中心</title>
    <style>
        body {
           background:url(image/bk1.jpeg);
           background-repeat:no-repeat;
           background-size:cover;
/*            opacity:0.5; */
           font-family:造字工房力黑（非商用）常规体;
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
        	width:700px;
        	height:500px;
        	background-color:rgba(100,100,100,0.5);
/*         	position:absolute; */
/*         	z-index:2; */
        }
        .nav{
            float: right;
            font-size: 1em;
            line-height: 30px;
        }
        #title{
            width: 100%; 
            margin:0 auto;
            font-size:1.5em;          
        }
        #headportrait{
        	margin-top:50px;
            height:150px;
            width:150px;
            border-radius:50%;
        }
        #profile_head{margin:0 auto;}
        #sidenav{
        	position:absolute;
        	top:100px;
        	left:10px;
        	width:120px;
        	font-size:1.2em;
        	color:rgba(0,0,0,0.8);
        }
        #motto{font-size:1em;}
        #nickname{font-size:1.7em}
        a{color:white;text-decoration:none;}
        h1{color:rgba(255,255,255,1)}
    </style>
</head>
<body>
    <div id="header">
        <div id="header_inner">
            <div class="nav">
                <a href="home.jsp">主页</a>|<a href="logoutsuccessfully.jsp">注销</a>
            </div>
        </div>
    </div>
    <div id="title">
        <h1 style="text-align:center">Hi！你好呀</h1>
    </div>
    <div id="profile">
        <p style="text-align:center"><a href="uploadheadportrait.jsp"><img id="headportrait" src=<%=headPortraitPath%>></a></p>
        <p id="nickname" style="text-align:center"><%=nickname%></p>
        <p id="motto" style="text-align:center"><%=motto%></p>
    </div>
    <div id="sidenav">
    	<ul>
    		<li><a href="completedata.jsp">完善资料</a><br><br><br>
    		<li><a href="completedata.jsp">我的主队</a><br><br><br>
    		<li><a href="modifypassword.jsp">修改密码</a><br><br><br>
    		<li><a href="completedata.jsp">我的球星</a><br><br><br>
    		<li><a href="completedata.jsp">我的评论</a><br><br><br>
    		<li><a href="completedata.jsp">我的回复</a><br><br><br>
    		<li><a href="completedata.jsp">热点专区</a><br><br><br>
    		<li><a href="completedata.jsp">好友列表</a><br><br><br>
    	</ul>
    </div>
</body>
</html>
