<%@ page import= "java.sql.*" %>
<%@ page import = "java.util.Date,java.text.SimpleDateFormat,java.text.ParseException"%>


<%
if (request.getParameter("crear")!=null)
{
  String JDriver = "sun.jdbc.odbc.JdbcOdbcDriver";
  String connectDB="jdbc:odbc:porra";
 
  Class.forName(JDriver);
  Connection con = DriverManager.getConnection(connectDB);
  Statement stmt = con.createStatement();
	
	String sql2= "select idJug from usuarios where nombre='"+request.getParameter("nombre")+"'";
	stmt.execute(sql2);
	ResultSet rs = stmt.getResultSet();
	if (rs.next())
	{
		%>
		<p>Player already exists</p>
		<%
	}
	else
	{
		String sql3= "insert into usuarios (nombre,puesto,login,password) values ('"+request.getParameter("nombre")+"','"+request.getParameter("puesto")+"','"+request.getParameter("login")+"','"+request.getParameter("password")+"')";
		stmt.executeUpdate(sql3);
		String sql= "select idJug from usuarios where nombre='"+request.getParameter("nombre")+"'";
		stmt.execute(sql);
		%><p>User created</p><%
		rs = stmt.getResultSet();
		if (rs.next())
		{
			String idJug=rs.getString("idJug");
		  for (int i=1;i<=64;i++)
		  {
		  	String sql5= "insert into apuestas (idJug,idpartido,r1,r2) values ("+idJug+","+i+",0,0)";
				stmt.execute(sql5);
			}
		}
	} 
	stmt.close();
  con.close();
  
}
%>



<html>
<head>
<title>EUROCUP SWEEPSTAKE 2012</title>
<link rel="stylesheet" type="text/css" href="css/style.css" />
</head>


<body>


<%int opcion=1;%>
<%@ include file="header_admin.jsp"%>


<div id="content"> 

<form method="post" action="generarjugador.jsp">

<table>
<tr><td>Name:</td><td><input type="text" name="nombre" value="" style="width:100px;"></td></tr>
<tr><td>Position:</td><td><input type="text" name="puesto" value="" style="width:100px;"></td></tr>
<tr><td>Login:</td><td><input type="text" name="login" value="" style="width:100px;"></td></tr>
<tr><td>Password:</td><td><input type="text" name="password" value="" style="width:100px;"></td></tr>
<tr><td> </td><td><input type="submit" name="crear" value="crear"></td></tr>
</table>
</form>	


<br/>
</div>

</body>
</html>