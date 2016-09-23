<%@ page contentType="text/html;"%>
<%@ page import= "java.sql.*" %>
<%@ page import = "java.util.Date,java.text.SimpleDateFormat,java.text.ParseException"%>


<%
if ((request.getParameter("actualizar")!=null)&&(request.getParameter("idpartido")!=null)) 
{
  String JDriver = "sun.jdbc.odbc.JdbcOdbcDriver";
  String connectDB="jdbc:odbc:porra";
 
  Class.forName(JDriver);
  Connection con = DriverManager.getConnection(connectDB);
  Statement stmt = con.createStatement();
	
	String id=request.getParameter("idpartido");
	
	String sql2= "update Admin set partido_abierto_hasta="+id;
	stmt.executeUpdate(sql2);
	ResultSet rs = stmt.getResultSet();

	%><p>Cambiado el partido_abierto_hasta</p><%
	stmt.close();
	con.close();
  
}
%>



<html>
<head>
<title>PORRA MUNDIAL 2010</title>
<meta http-equiv="Content-Type" contentType="text/html;">
<link rel="stylesheet" type="text/css" href="css/style.css" />
</head>


<body>


<%int opcion=4;%>
<%@ include file="header_admin.jsp"%>


<div id="content"> 

<form method="post" action="admin_opciones.jsp">

<table>
<tr><td>Partidos abiertos hasta el Id:</td>
		<td><input type="text" name="idpartido" value="" style="width:30px;"></td></tr>
<tr><td> </td><td><input type="submit" name="actualizar" value="actualizar"></td></tr>
</table>
</form>	


<br/>
</div>

</body>
</html>