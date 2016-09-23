<%@ page contentType="text/html;"%>
<%@ page import= "java.sql.*" %>
<%@ page import = "java.util.Date,java.text.SimpleDateFormat,java.text.ParseException"%>


<%
if ((request.getParameter("renombrar")!=null)&&(request.getParameter("idpartido")!=null)) 
{
  String JDriver = "sun.jdbc.odbc.JdbcOdbcDriver";
  String connectDB="jdbc:odbc:porra";
 
  Class.forName(JDriver);
  Connection con = DriverManager.getConnection(connectDB);
  Statement stmt = con.createStatement();
	
//	request.setCharacterEncoding("UTF-8");
	String nombre1=request.getParameter("e1");
	String nombre2=request.getParameter("e2");
	
	String sql2= "update partidos set e1='"+nombre1+"', e2='"+nombre2+"' where idPartido="+request.getParameter("idpartido");
	stmt.executeUpdate(sql2);
	ResultSet rs = stmt.getResultSet();

	%><p>Game renamed</p><%


	stmt.close();
	con.close();
  
}
%>



<html>
<head>
<title>EUROCUP SWEEPSTAKE 2012</title>
<meta http-equiv="Content-Type" contentType="text/html;">
<link rel="stylesheet" type="text/css" href="css/style.css" />
</head>


<body>


<%int opcion=3;%>
<%@ include file="header_admin.jsp"%>


<div id="content"> 

<form method="post" action="renombrar.jsp">

<table>
<tr><td>idPartido:</td>
		<td><input type="text" name="idpartido" value="" style="width:30px;"></td></tr>
<tr><td>Name 1</td><td><input type="text" name="e1" value="" style="width:200px;"></td></tr>
<tr><td>Name 2</td><td><input type="text" name="e2" value="" style="width:200px;"></td></tr>
<tr><td> </td><td><input type="submit" name="renombrar" value="renombrar"></td></tr>
</table>
</form>	


<br/>
</div>

</body>
</html>