<%@ page language="java" import="java.util.*,java.sql.*" 
         contentType="text/html; charset=utf-8"
%>
<%
    request.setCharacterEncoding("utf-8");
    String msg="6";
    String details="";
    String content="";
    String hasimg=""; 
    String imgres="";
    String comment = "1";
    String title = request.getParameter("title");
    String username= (String) session.getAttribute("username");
    String connectString = "jdbc:mysql://172.18.187.234:53306/nba15352188"
                    + "?autoReconnect=true&useUnicode=true"
                    + "&characterEncoding=UTF-8"; 
    StringBuilder table=new StringBuilder("");
    try{
        msg="0";
        Class.forName("com.mysql.jdbc.Driver");
        Connection con=DriverManager.getConnection(connectString, 
                     "user", "123");
         PreparedStatement pstmt = con.prepareStatement("select * from article where title = ?");     
         pstmt.setString(1,title);
         ResultSet rs = pstmt.executeQuery();
         rs.next(); 
         content = rs.getString("content");
         details = rs.getString("author")+"  "+rs.getString("time");    
         hasimg = rs.getString("haveimage");
         imgres = rs.getString("imageres");
         //discussion
         pstmt=con.prepareStatement("select * from comment where article_title = ?");
         pstmt.setString(1,title);
        rs=pstmt.executeQuery();
         table.append("<table>");
         while(rs.next()) {
             table.append(String.format(
                "<tr><td class='cmtc'>%s</td><td class='cmta'>%s</td></tr>",
                rs.getString("content"),rs.getString("author")
                ));
        }
        table.append("</table>");
        if(request.getMethod().equalsIgnoreCase("post")){
            msg=username;
         if(username==null){
             out.println("<script type='text/javascript'>alert('Please login first');self.location=document.referrer;</script>");
             msg="2";
         }
         else{  
             msg="3";
            pstmt = con.prepareStatement("insert into comment(author,content,article_title) values(?,?,?)");
            comment = request.getParameter("editcom");
            pstmt.setString(1,username);
            pstmt.setString(2,comment);
            pstmt.setString(3,title);
            int cnt = pstmt.executeUpdate();
            if(cnt>0){
             out.println("<script type='text/javascript'>alert('comment successful')</script>");
            }
         }
        }
         con.close(); 
    }   
    catch (Exception e){
        e.getMessage(); 
    }
%>
<!doctype html>
<html>
<head>
<meta content="text/html;charset=utf-8">
<title><%=title%></title>   
<style>
    body{background-color: rgb(246,246,246);}
    #news{
        width: 800px;
        height: 3000px;
        background-color: white;
        padding: 1rem;
        margin-left: 20%;
    }
    #news h1{
        padding-bottom: 16px;
        font-family: "微软雅黑";
        font-size: 26px;
        margin-bottom: 0px;
    }
    #details{
        border-bottom: dotted 1px #dbdbdb;
        color:#dbdbdb;
    }
    #content{
        text-indent: 2em;
        white-space: pre-wrap;
    }
    #comment{
        border-top: dotted 1px #dbdbdb;
    }
    #editcom{
        height: 80px;
        padding: 10px;
        margin-left: 10%;
        outline: none;
        resize: none;
        width: 600px;
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
        font-size: 1.5rem;
        color: black;

    }
    .cmta{
        font-size: 1rem;
        color: grey;
        width: 20%;
    }
</style>  
</head>
<body>
    <form action="news.jsp?title=<%=title%>" method="post" name="f">
    <div id = "news">
     <h1><%=title%></h1>
     <div id="details">
     <%=details%>
      </div>
      <% if (hasimg.equals("1")) { %>
         <img style="width: 500px; margin:30px 150px;" src=<%=imgres%> >   
       <% } %>
      <div id="content"><%=content%></div>
      <img src="https://i.imgur.com/RFWflBH.png" style="margin: 40px 250px;"> 
      <div id="comment">
        <p><label for="editcom">网友评论:</label></p>
        <p><textarea id="editcom" name="editcom" placeholder="请在此输入评论"></textarea></p>   
        <input type="submit" name="comt" style="margin-left: 700px; width: 4rem; text-align: center;" value="评论">
        <%=table%>
        <p><a href="showcomment.jsp?title=<%=title%>">查看更多评论</a></p>
      </div>

    </div>
    </form>

    <%=msg%>
</body>
</html>

     