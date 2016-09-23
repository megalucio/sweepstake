<%@ page import= "java.sql.*" %>

<%
if ((request.getParameter("entrar")!=null)&& (request.getParameter("log")!=""))
{ 
	if ((request.getParameter("log")!="") != (request.getParameter("pas")!=""))
	{
	%>
	<p id="nota">Login and Password must be filled</p>
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
<title>EUROCUP SWEEPSTAKE 2012</title>
<link rel="stylesheet" type="text/css" href="/css/style.css" />
</head>

<body>
<%int opcion=0;%>
<%@ include file="header.jsp"%>

<div id="content"> 
<br/>
<p>
PRICES:<BR/>1st=45&euro; | 2nd=10&euro; | 3rd=5&euro;
</p>


<form method="post" action="login.jsp">
<table id="rounded-corner">



<tbody>
<tr><td>login:</td>
		<td><input type="text" name="log"></td></tr>
<tr><td>password:</td>
		<td><input type="password" name="pas"></td></tr>
</tbody>

<tfoot><tr><td colspan="2"><input type="submit" name="entrar" value="entrar"></td></tr></tfoot>

</table>
</form>



<p>
Score:<br/>
<ul><li>6 points: Guess the exact result of the game</li>
<li>3 points: Guess the winner.</li>
<li>1 point: Guess the number of goals of any of the teams.</li>
<!--<li>+1 extra point for guessing the winner in games from 49 to 56</li>-->
<li>+2 extra points for guessing the winner in quarter finals</li>
<li>+3 extra points for guessing the winner in semifinals</li>
<li>+5 extra points for guessing the winner in the final</li>
</ul>
</p>


<p>
Terms:<br/>
<ul><li>The exact result won't have into consideration the penalties.</li>
<li>You can only bet until 4PM the day of the game.</li>
<li>On Friday you'll need to complete the bets for Friday, Saturday and Sunday.</li>
<li>The enrollment fee will be 5 Euros</li>
</ul>
</p>
<br/>
</div>
</body>
</html>