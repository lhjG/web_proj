<%@ page language="java" import="java.util.*,java.sql.*" 
         contentType="text/html; charset=utf-8"
%><%
	request.setCharacterEncoding("utf-8");
	String msg ="";
	Integer pgno = 0; //当前页号
	Integer pgcnt = 4; //每页行数
	String param = request.getParameter("pgno");
	if(param != null && !param.isEmpty()){
		pgno = Integer.parseInt(param);
	}
	param = request.getParameter("pgcnt");
	if(param != null && !param.isEmpty()){
		pgcnt = Integer.parseInt(param);
	}
	int pgprev = (pgno>0)?pgno-1:0;
	int pgnext = pgno+1;
	String title = request.getParameter("title");
	String username= (String) session.getAttribute("username");
	String isadmin="";
	String connectString = "jdbc:mysql://172.18.187.234:53306/nba15352188"
					+ "?autoReconnect=true&useUnicode=true"
					+ "&characterEncoding=UTF-8"; 
    StringBuilder table=new StringBuilder("");
	try{
	  Class.forName("com.mysql.jdbc.Driver");
	  Connection con=DriverManager.getConnection(connectString, 
	                 "user", "123");
	  PreparedStatement pstmt1=con.prepareStatement("select * from user where username = ?");
	  pstmt1.setString(1,username);
	  ResultSet rs1=pstmt1.executeQuery();
	  rs1.next();
	  isadmin=rs1.getString("isadmin");
	  PreparedStatement pstmt=con.prepareStatement("select * from comment where article_title = ? limit ?,? ");
	  pstmt.setInt(2,pgcnt*pgno);
	  pstmt.setInt(3,pgcnt);
	  pstmt.setString(1,title);
	  ResultSet rs=pstmt.executeQuery();
      table.append("<table>");
        while(rs.next()) {
         if(isadmin=="0"){
            table.append(String.format(
              "<tr><td class='cmtc'>%s</td><td class='cmta'>%s</td></tr>",
              rs.getString("content"),rs.getString("author")
             ));
         }
         else{
         	  table.append(String.format(
              "<tr><td class='cmtc'>%s</td><td class='cmta'>%s</td><td>%s</td></tr>",
              rs.getString("content"),rs.getString("author"),
              "<a href='delete.jsp?id="+rs.getString("id")+"'>删除</a>"
             ));
     	 }
        }
	table.append("</table>");
	  rs.close();
	  pstmt.close();
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
	table{
		border: solid black 1px;
		border-collapse: collapse;
		width: 500px;
	}
	td,th{
		border: solid black 1px;
		padding: 5px 5px 5px 5px;
	}
	a:link,a:visited {
		color: blue;
	}
    table{
        width: 700px;
        margin: 20px 7%;
        
    }
    td{
        border-top: dotted 1px black; 
        margin: 10px 20px;
        min-height: 200px;
    }
    tr{
        min-height: 200px;
    }
    .cmtc{
        font-size: 1rem;
        color: black;

    }
    .cmta{
        font-size: 1rem;
        color: grey;
        width: 20%;
    }
</style>
<title>查看评论</title>
</head>
<body>
  <div class="container">
	  <h1>评论区</h1>  
	  <%=table%><br><br>  
	  <a href="showcomment.jsp?title=<%=title%>&pgno=<%=pgprev%>&pgcnt=<%=pgcnt%>">上一页</a>
	  <a href="showcomment.jsp?title=<%=title%>&pgno=<%=pgnext%>&pgcnt=<%=pgcnt%>">下一页</a>
	  <%=msg%>
  </div>
</body>
</html>