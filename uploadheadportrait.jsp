<%@ page language="java" import="java.util.*,java.sql.*"
contentType="text/html; charset=utf-8"%>
<%@ page import="java.io.*,java.util.*,org.apache.commons.io.*"%>
<%@ page import="org.apache.commons.fileupload.*"%>
<%@ page import="org.apache.commons.fileupload.disk.*"%>
<%@ page import="org.apache.commons.fileupload.servlet.*"%>
<%request.setCharacterEncoding("utf-8");%>
<% 
	request.setCharacterEncoding("utf-8");
	String connectString = "jdbc:mysql://172.18.187.234:53306/nba15352188"+ "?autoReconnect=true&useUnicode=true&characterEncoding=UTF-8";
	String user="user"; 
	String pwd="123";
	String msg="";
	String fileName="";
	String id="";
	String sql="";
	Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection(connectString,user, pwd);
	Statement stmt = con.createStatement();
	String userName=session.getAttribute("username").toString();
	boolean isMultipart = ServletFileUpload.isMultipartContent(request);//检查表单中是否包含文件
	if(isMultipart) {
		FileItemFactory factory = new DiskFileItemFactory();
		//factory.setSizeThreshold(yourMaxMemorySize); //设置使用的内存最大值
		//factory.setRepository(yourTempDirectory); //设置文件临时目录
		ServletFileUpload upload = new ServletFileUpload(factory);
		//upload.setSizeMax(yourMaxRequestSize); //允许的最大文件尺寸
		List items = upload.parseRequest(request);
		for(int i = 0; i < items.size(); i++) {
			FileItem fi = (FileItem) items.get(i);
			if(fi.isFormField()) {//如果是表单字段
				if(fi.getFieldName().equals("id")){
				id=fi.getString("utf-8");}
				//out.print(fi.getFieldName()+":"+fi.getString("utf-8"));
			}
			else{//如果是文件
				DiskFileItem dfi = (DiskFileItem) fi;
					if(!dfi.getName().trim().equals("")) {//getName()返回文件名称或空串
						fileName="D:\\Tomcat 8.5\\webapps\\web_proj\\image"
						+ System.getProperty("file.separator")
						+ userName
						+ ".jpg";
						dfi.write(new File(fileName));
						sql="UPDATE user SET ifhaveheadportrait=1 WHERE username='"+userName+"';";
						int res=stmt.executeUpdate(sql);
						if(res>0){
							msg="修改成功！";
							stmt.close(); 
							con.close();
							response.sendRedirect("PersonalHomePage.jsp");
						}
					}
			} 
		} 
	} 
%>
<!-- %> -->
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="UTF-8">
<title>上传头像</title>
<style>
	#all{
		height: auto;
		width: auto;
		padding: 20px 50px 20px 50px;
		border-radius: 20px;
		background:#FFFFFF;
		box-shadow: -1px -2px 2px rgba(0,0,0,0.5) inset, 3px 2px 15px rgba(0,0,0,0.1);
	}
	#all:hover{
		padding: 20px 51.5px 21.5px 51.5px;
	}
	#tr1{
		margin:0px;
		padding: 0px;
		border: 0px;
		border-radius:10px;
		background: rgb(245,248,250);
		box-shadow: -1px -2px 2px rgba(0,0,0,0.5) inset, 1px 2px 2px rgba(0,0,0,0.1);
	}
	#text{
		padding-top:2px;
		color:rbg(245,248,250);
		position:relative;
		left:2px;
	}
	#filebutton input{
		height:inherit;
		width:auto;
		border-radius:20px;
		background: rgb(245,248,250);
		box-shadow: -1px -2px 2px rgba(0,0,0,0.5) inset, 1px 2px 2px rgba(0,0,0,0.1);
		transition-property: all;
		transition-duration: 0.5s;
		transition-timing-function: ease-out;
	}
	#filebutton input:hover{
		background: rgb(209,234,250);
		color: rgba(255,255,255,0.9);
	}
	#filebutton input:active{
		background: rgb(82, 207, 235);
		box-shadow: inset 0px 0px 5px rgba(0,0,0,0.3), inset 0px 3px 4px rgba(0,0,0,0.3);
		color: rgb(255,255,255);
	}
	#button {
		padding-top: 10px;
	}
	#button input {
		margin:10px;
		border:5px;
		height:30px;
		width:90px;
		border-radius:20px;
		background: rgb(245,248,250);
		box-shadow: -1px -2px 2px rgba(0,0,0,0.5) inset, 1px 2px 2px rgba(0,0,0,0.1);
		transition-property: all;
		transition-duration: 0.5s;
		transition-timing-function: ease-out;
	}
	#button input:hover{
		height: 32px;
		width: 92px;
		margin:9px;
		background: rgb(209,234,250);
		color: rgba(255,255,255,0.9);
	}
	#button input:active{
		background: rgb(82, 207, 235);
		box-shadow: inset 0px 0px 5px rgba(0,0,0,0.3), inset 0px 3px 4px rgba(0,0,0,0.3);
		color: rgb(255,255,255);
	}
</style>
</head>
<body>
 <form action="uploadheadportrait.jsp" method="post" enctype="multipart/form-data">
  <table id="all" align="center">
    <tr id="tr1">
      <td id="text">头像位置:</td>
      <td id="filebutton"><input type="file" name="file" id="file"/></td>
    </tr>
    <tr>
      <td colspan="2" align="center" id="button"><input id="submit" type="submit" value="提交" onclick="myfunction()" />
        &nbsp;&nbsp;&nbsp;&nbsp;
      <input type="button" onclick="javascript:window.location.href='PersonalHomePage.jsp';" value="返回"/></td>
    </tr>
    <%=msg %>
  </table>
</form>
</body>
</html>