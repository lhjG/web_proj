<%@ page language="java" import="java.util.*,java.sql.*" 
         contentType="text/html; charset=utf-8"
%>
<%
    request.setCharacterEncoding("utf-8");
    String msg ="";
    String connectString = "jdbc:mysql://172.18.187.234:53306/nba15352188"
                    + "?autoReconnect=true&useUnicode=true"
                    + "&characterEncoding=UTF-8"; 
        StringBuilder table=new StringBuilder("");
        String password = request.getParameter("password");
        String name = request.getParameter("username");
        // Array<String> setting = request.getParameterValues("club");

    try{
      Class.forName("com.mysql.jdbc.Driver");
      Connection con=DriverManager.getConnection(connectString, 
                     "user", "123");
      if(request.getMethod().equalsIgnoreCase("post")){
        PreparedStatement pstmt = con.prepareStatement("select * from user where username = ?");
        if(name.isEmpty()||password.isEmpty()){
            msg = "用户名及密码不能为空";
        }
        else{
            pstmt.setString(1,name);
            ResultSet rs = pstmt.executeQuery();
             //not exist this username
            if(rs.next()){
                rs.previous();
               boolean flag = false;
               while(rs.next()){
                    if(rs.getString("password").equals(password)){
                        //home page
                        flag = true;
                        response.sendRedirect("home.jsp"); 
                        session.setAttribute("username",name);
                        msg = "登陆成功";
                        break;
                    }
                }
                if(flag == false){
                    msg = "用户名或密码错误";
                }   
            }   
            else{   
                 msg = "用户名不存在";
            }       
          }    



        }           
        con.close();
    }   
    catch (Exception e){
      msg = e.getMessage();
    }

%>
<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <title>login</title>
    <style>
        body {
            background-color: skyblue;
        }
        html {
            font-size: 16px;
        }
        *{box-sizing:border-box;}
        #box1 {
            width: 24rem;
            height: 18rem;
            margin: 150px auto;
            padding: 1rem;
            background-color: rgb(235,242,249);
             border-radius: 3px;
             box-shadow: inset 0px -2px 4px rgba(0,0,0,0.5),0px 4px 10px rgba(0,0,0,0.5),inset 0px 1px 1px white,inset 0px 0px 1px black;
        }
        .logo{
            width: 18rem;
            margin: 20px 30px 20px 30px;
            position: relative;
            z-index: 2;
        }
        .loginimg{
            width:15px;
            margin-left:30px; 

        }
        .input{
            border-radius:5px;
            width: 16rem;
            height:1.5rem;
        }

     
        .setting{
            margin-left: 100px;
        }

        #bg{
            position: relative;
            width: 24rem;   
            height: 8.5rem;
            top: -17rem;
            left: -1rem;
            z-index: 1;
        }
        #button{
            width: 20rem;
            height: 2rem;
            border-radius: 0.5rem;
            background-color: rgb(0,163,255);
            text-align: center;
            font-weight: bold;
            margin:0px 20px;
        }
        #button:hover{
            background-color: rgb(57,193,255);
        }
    </style>

</head>
<body>  
    <div id="box1">
        <img src="https://i.imgur.com/u1aCGCu.png" class="logo">
        <form action="login.jsp" method="post">
        <div id="userpart" class="edit">
            <img src="https://i.imgur.com/CILkzmx.png" class="loginimg">
            <input type="name" name="username" id="username" class="input">
        </div>
        <div id="passwordpart" class="edit">
            <img src="https://i.imgur.com/gHbLuDS.png" class="loginimg">
            <input type="password" name="password" id="password" class="input">
        </div>
        <p><label for="setting" class="setting"> </label>
        <input name="setting"  type="checkbox" value="remember">记住密码
        <input name="setting"  type="checkbox" value="auto">自动登录
      </p>
        <input type="submit" id="button" value="登录">
        </form>
        <img src="https://i.imgur.com/Zzgdzvw.jpg" id="bg">
    <script type="text/javascript">
        alert("十分抱歉，Beta版暂不支持第三方帐号关联登录！");
    </script>
    <%=msg%>
    </div>
</body>
</html>
