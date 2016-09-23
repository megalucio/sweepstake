<%@ page import= "java.sql.*" %>
<%@ page import= "java.io.*" %>


<% session.setAttribute("idJ",12); %>



<html>
<head>
<title>PORRA MUNDIAL 2010</title></head><body>

<body>
<h1>Apuesta</h1>

<%
  String JDriver = "sun.jdbc.odbc.JdbcOdbcDriver";
  String connectDB="jdbc:odbc:porra";
 
  Class.forName(JDriver);
  Connection con = DriverManager.getConnection(connectDB);
  Statement stmt = con.createStatement();
 
  String sql= "select * from bet where idJugador="+session.getAttribute("idJ");
%>


<% 
	stmt.execute(sql);
	ResultSet rs = stmt.getResultSet();
	ResultSetMetaData md = rs.getMetaData();
	int colCount = md.getColumnCount();
%>

 <%
for (int i = 1; i <= colCount; i++) {
}
while (rs.next())
{
%>
		<p id="linea">
<%
	for (int i = 1; i <= colCount; i++)
  {
%>
		<span id="columna"><%=rs.getObject(i).toString()%></span>
<%
	}
%>
</p>
<%
}
%>

<%
  stmt.close();
  con.close();
%>

</body>
</html>