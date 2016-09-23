<%@ page import= "java.sql.*" %>
<%@ page import = "java.util.Date,java.text.SimpleDateFormat,java.text.ParseException"%>




<%
if (session.getAttribute("idJ")==null)	response.sendRedirect("login.jsp");
%>

<%
if ((request.getParameter("enviar")!=null)&& (session.getAttribute("idJ")!=null))
{
  String JDriver = "sun.jdbc.odbc.JdbcOdbcDriver";
  String connectDB="jdbc:odbc:porra";
 
  Class.forName(JDriver);
  Connection con = DriverManager.getConnection(connectDB);
  Statement stmt = con.createStatement();
	
/*
	String sql2= "delete from apuestas where idJug="+session.getAttribute("idJ");
	stmt.executeUpdate(sql2);
  for (int i=1;i<=64;i++)
  {
  	String sql= "insert into apuestas (idJug,idpartido,r1,r2) values ("+session.getAttribute("idJ")+","+i+","+request.getParameter("ap1_"+i)+","+request.getParameter("ap2_"+i)+")";
		stmt.execute(sql);
  }
 */
  for (int i=1;i<=64;i++) {
	if (request.getParameter("ap1_"+i)!=null) {
		String sql= "update apuestas set r1="+request.getParameter("ap1_"+i)+", r2="+request.getParameter("ap2_"+i)+" where idJug="+session.getAttribute("idJ") + " and idpartido="+i;
		stmt.executeUpdate(sql);
	}
  }
	stmt.close();
  con.close();
  
%><p>Bet updated</p>
<%
}

int partido_abierto_hasta=1000;

  String JDriver = "sun.jdbc.odbc.JdbcOdbcDriver";
  String connectDB="jdbc:odbc:porra";
 
  Class.forName(JDriver);
  Connection con = DriverManager.getConnection(connectDB);


	Statement stmt5 = con.createStatement();
	stmt5.execute("select partido_abierto_hasta from Admin");
	ResultSet rs5 = stmt5.getResultSet();
	if (rs5.next()) {
		partido_abierto_hasta=Integer.valueOf(rs5.getString("partido_abierto_hasta"));
	}
	stmt5.close();

  Statement stmt = con.createStatement();
 
  String sql= "SELECT distinct Partidos.idPartido, Partidos.e1, Partidos.e2, Partidos.fecha,Partidos.f1,Partidos.f2, apuestas.r1, apuestas.r2,apuestas.puntos FROM Partidos LEFT JOIN apuestas ON Partidos.idPartido = apuestas.idPartido WHERE (((apuestas.idJug)="+session.getAttribute("idJ")+"));";
%>




<html>
<head>
<title>EUROCUP SWEEPSTAKE 2012</title>
<link rel="stylesheet" type="text/css" href="css/style.css" />
</head>

<body>

<%int opcion=3;%>
<%@ include file="header.jsp"%>


<div id="content"> 

<form method="post" action="apuesta.jsp">
<table id="newspaper-b">

<thead>
	<th scope="col"> </th>
	<th scope="col" align="center">Date</th>
	<th scope="col"></th>
	<th scope="col"></th>
	<th scope="col"></th>
	<th scope="col"></th>
	<th scope="col"></th>
	<th scope="col" align="center" width="70">Results</th>
	<th scope="col" align="center" width="50">Points</th>
	<th scope="col" align="center" width="100">Bets to 1</th>
	<th scope="col" align="center" width="100">Bets to X</th>
	<th scope="col" align="center" width="100">Bets to 2</th>
</thead>
		<tbody>
 <%
	stmt.execute(sql);
	ResultSet rs = stmt.getResultSet();
	ResultSetMetaData md = rs.getMetaData();
	int colCount = md.getColumnCount();

for (int i = 1; i <= colCount; i++) {
}
String elimp="";
while (rs.next())
{


	SimpleDateFormat formater = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	Date fecha2 = formater.parse(rs.getString("fecha"));
	String id=rs.getString("idPartido");
	String r1=rs.getString("r1");
	if (r1==null) r1="10";
	String r2=rs.getString("r2");
	if (r2==null) r2="10";
	SimpleDateFormat fmt = new SimpleDateFormat("dd/MM");
	String fecha = fmt.format(fecha2);
	Date ahora=new Date();
	
	int activo=1;
	int cerrado=0;
	
	
	// Comprobación partidos abiertos -------------------
	// *******************************************************************
	// *******************************************************************
	// *******************************************************************
	// *******************************************************************

	if (Integer.parseInt(id)>partido_abierto_hasta) activo=0;

	// *******************************************************************
	// *******************************************************************
	// *******************************************************************
	// *******************************************************************
	// *******************************************************************
	// *******************************************************************
	// ---------------------------------------------------


	// Comprobación fecha actual--------------------------
	if (ahora.getMonth()>fecha2.getMonth())
		activo=0;
	else
		if (ahora.getMonth()==fecha2.getMonth())
			if (ahora.getDate()>fecha2.getDate())
				activo=0;
			else
				if (ahora.getDate()==fecha2.getDate())
					if (ahora.getHours()>15)
						activo=0;

	// ---------------------------------------------------

	

	int uno=0;
	int equis=0;
	int dos=0;
	stmt5 = con.createStatement();
	stmt5.execute("select Format (count(idPartido),'General Number') as uno from apuestas where ((r1>r2) and (idPartido="+id+"))");
	rs5 = stmt5.getResultSet();
	if (rs5.next()) {uno=Integer.valueOf(rs5.getString("uno"));}
	stmt5.execute("select Format (count(idPartido),'General Number') as equis from apuestas where ((r1=r2) and (idPartido="+id+"))");
	rs5 = stmt5.getResultSet();
	if (rs5.next()) {equis=Integer.valueOf(rs5.getString("equis"));}
	stmt5.execute("select Format (count(idPartido),'General Number') as dos from apuestas where ((r1<r2) and (idPartido="+id+"))");
	rs5 = stmt5.getResultSet();
	if (rs5.next()) {dos=Integer.valueOf(rs5.getString("dos"));}

	stmt5.close();

	String f1=rs.getString("f1");
	if (f1==null) f1="-";
	String f2=rs.getString("f2");
	if (f2==null) f2="-";	
%>

			<%if (Integer.parseInt(id)>30) {%>
		<tr class="final">
			<%}else if (Integer.parseInt(id)>28) {%>
		<tr class="semis">
			<%}else if (Integer.parseInt(id)>24) {%>
		<tr class="cuartos">
			<%}else{%>
		<tr>
			<%}%>			
			
			
			<td id="columna" width="50" align="right"><%=id%>.</td>
			<td id="columna" width="100">[<%=fecha%>]</td>
			<td id="columna" align="right" width="150">
				<%if (ahora.getMonth()==fecha2.getMonth() && ahora.getDate()==fecha2.getDate()) {%><b><%}%>
				<%=rs.getString("e1")%>
				<%if (ahora.getMonth()==fecha2.getMonth() && ahora.getDate()==fecha2.getDate()) {%></b><%}%>
				</td>
			<td id="columna" align="right">
				<%if (activo==1){%>
				<input type="text" name="ap1_<%=id%>" value="<%=r1%>" style="width:30px;">
				<%}else if (f1!=null){%>
				<%=r1%>
				<%}else{%>
				<%=r1%><input type="hidden" name="ap1_<%=id%>" value="<%=r1%>" style="width:30px;">
				<%}%>
			</td>
			<td id="columna">-</td>
			<td id="columna">
				<%if (activo==1){%>
				<input type="text" name="ap2_<%=id%>" value="<%=r2%>" style="width:30px;">
				<%}else if (f2!=null){%>
				<%=r2%>
				<%}else{%>
				<%=r2%><input type="hidden" name="ap2_<%=id%>" value="<%=r2%>" style="width:30px;">
				<%}%>
			</td>
			<td width="150">
				<%if (ahora.getMonth()==fecha2.getMonth() && ahora.getDate()==fecha2.getDate()) {%><b><%}%>
				<%=rs.getString("e2")%>
				<%if (ahora.getMonth()==fecha2.getMonth() && ahora.getDate()==fecha2.getDate()) {%></b><%}%>
				</td>
			<td id="columna" align="center">[<%=f1%>-<%=f2%>]</td>
			<td id="columna" align="center">
				<%if (activo==1){%>
				--
				<%}else{%>
				<%=rs.getString("puntos")%>
				<%}%>
			</td>
			<td align="center" bgcolor="silver"><%=uno%></td>
			<td align="center" bgcolor="silver"><%=equis%></td>
			<td align="center" bgcolor="silver"><%=dos%></td>
		</tr>
<%
}
%>
</tbody>
</table>
<%
  stmt.close();
  con.close();
%>
<input type="submit" name="enviar" value="Bet">
</form>





</div>

<br/>
</body>
</html>