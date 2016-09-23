<%@ page import= "java.sql.*" %>

<%
if ((request.getParameter("entrar")!=null)&& (request.getParameter("log")!=""))
{ 
	if ((request.getParameter("log")!="") != (request.getParameter("pas")!=""))
	{
	%>
	<p id="nota">login y password no deben estar vacíos</p>
	<%
	} else {
	  
	  String JDriver = "sun.jdbc.odbc.JdbcOdbcDriver";
	  String connectDB="jdbc:odbc:porra";
	 
	  Class.forName(JDriver);
	  Connection con = DriverManager.getConnection(connectDB);
	  Statement stmt = con.createStatement();
	 
	  String sql= "select idJug,nombre,login,password from usuarios where login='"+request.getParameter("log")+"' and password='"+request.getParameter("pas")+"'";
	 
		stmt.execute(sql);
	 	ResultSet rs = stmt.getResultSet();
		if (rs.next())
		{
			session.setAttribute("idJ",rs.getString("idJug"));
			session.setAttribute("nombre",rs.getString("nombre"));
			session.setAttribute("login",rs.getString("login"));
			session.setAttribute("password",rs.getString("password"));
			response.sendRedirect("listado.jsp");
		}
		stmt.close();
	  con.close();
	}
}
%>


<html>
<head>
<title>PORRA MUNDIAL 2010</title>
<link rel="stylesheet" type="text/css" href="css/style.css" />
</head>


<body>

<%int opcion=0;%>
<%@ include file="header_admin.jsp"%>

<div id="content"> 
<br/>
<br/>
</div>
</body>
</html>