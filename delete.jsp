<%@ page language="java" import="java.util.*,java.sql.*" 
         contentType="text/html; charset=utf-8"
%>
<%
    request.setCharacterEncoding("utf-8");
    String msg ="";
    String id= request.getParameter("id");
    String connectString = "jdbc:mysql://172.18.187.234:53306/nba15352188"
                    + "?autoReconnect=true&useUnicode=true"
                    + "&characterEncoding=UTF-8"; 
        StringBuilder table=new StringBuilder("");
    try{
      Class.forName("com.mysql.jdbc.Driver");
      Connection con=DriverManager.getConnection(connectString, 
                     "user", "123");
        PreparedStatement pstmt = con.prepareStatement("delete from comment where id=?");   
        pstmt.setString(1,id);
        int cnt = pstmt.executeUpdate();
        if(cnt>0)msg="delete successfully";
        else msg="delete failure";
        con.close();
    }
    catch (Exception e){
      msg = e.getMessage();
    }
%><!DOCTYPE HTML>
<html>
<head>
    <style>
    .container{
        text-align: center;
        margin: 0 auto;
        width: 500px;
    }
    a:link,a:visited {
        color: blue;
    }

</style>
<title>删除学生记录</title>
</head>
<body>
  <div class="container">
    <script type="text/javascript">
        alert("删除成功，点击确认返回");
        self.location=document.referrer;
    </script>
  </div>
</body>
</html>