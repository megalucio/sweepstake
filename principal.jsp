<%@ page import= "java.sql.*" %>
<%@ page import = "java.util.Date,java.text.SimpleDateFormat,java.text.ParseException"%>





<%
  String JDriver = "sun.jdbc.odbc.JdbcOdbcDriver";
  String connectDB="jdbc:odbc:porra";
 
  Class.forName(JDriver);
  Connection con = DriverManager.getConnection(connectDB);
  Statement stmt = con.createStatement();
 
  String sql= "SELECT usuarios.idJug, usuarios.nombre, usuarios.puesto, sum(apuestas.puntos) as puntos FROM usuarios LEFT JOIN apuestas ON usuarios.idJug= apuestas.idJug group by usuarios.idJug, usuarios.nombre, usuarios.puesto order by sum(apuestas.puntos) desc,usuarios.nombre";
%>




<html>
<head>
<title>PORRA MUNDIAL 2010</title></head><body>

<body>




<form method="post" action="apuesta.jsp">
<% 
	stmt.execute(sql);
	ResultSet rs = stmt.getResultSet();
	ResultSetMetaData md = rs.getMetaData();
	int colCount = md.getColumnCount();
%>
<table>
 <%
String elimp="";
int i=1;
while (rs.next())
{
	String id=rs.getString("idJug");
	String nombre=rs.getString("nombre");
	int puntos=Integer.parseInt(rs.getString("puntos"));
	
%>


		<tr>
			<td id="columna" width="50" align="right"><%=i%>.</td>
			<td id="columna" width="150"><%=nombre%></td>
			<td id="columna" align="right" width="150"><%=puntos%></td>
		</tr>
<%
i++;
}
%>
</table>
<%
  stmt.close();
  con.close();
%>
</form>







</body>
</html>