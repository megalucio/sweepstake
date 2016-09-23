<%@ page import= "java.sql.*" %>
<%@taglib uri='/WEB-INF/cewolf.tld' prefix='cewolf' %>

<%
if (session.getAttribute("idJ")==null)	response.sendRedirect("login.jsp");
%>


<%
if (request.getParameter("guardar")!=null)
{
  String JDriver = "sun.jdbc.odbc.JdbcOdbcDriver";
  String connectDB="jdbc:odbc:porra";
 
  Class.forName(JDriver);
  Connection con = DriverManager.getConnection(connectDB);
  Statement stmt = con.createStatement();
	
	String sql2= "update usuarios set password='"+request.getParameter("pas")+"' where idJug="+session.getAttribute("idJ");
	stmt.executeUpdate(sql2);
	ResultSet rs = stmt.getResultSet();
	session.setAttribute("password",request.getParameter("pas"));
	%><p>Password changed</p><%
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

<%int opcion=4;%>
<%@ include file="header.jsp"%>

<div id="content"> 



<form method="post" action="options.jsp">
<table id="rounded-corner">
<tbody>
<tr><td>login:</td>
		<td><input type="text" name="log" readonly value="<%=session.getAttribute("login")%>"></td></tr>
<tr><td>new password:</td>
		<td><input type="password" name="pas"></td></tr>
</tbody>

<tfoot><tr><td colspan="2"><input type="submit" name="guardar" value="guardar"></td></tr></tfoot>

</table>
</form>


<br/>
</div>

</body>
</html>