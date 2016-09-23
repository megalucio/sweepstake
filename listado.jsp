<%@ page import= "java.sql.*" %>
<%@ page import = "java.util.Date,java.text.SimpleDateFormat,java.text.ParseException"%>
<%@ page import = "java.text.DecimalFormat,java.text.NumberFormat"%>
<%@ page import = "java.lang.Math"%>

<%
if (session.getAttribute("idJ")==null)	response.sendRedirect("login.jsp");
%>


<%
  String JDriver = "sun.jdbc.odbc.JdbcOdbcDriver";
  String connectDB="jdbc:odbc:porra";
 
  Class.forName(JDriver);
  Connection con = DriverManager.getConnection(connectDB);
  Statement stmt = con.createStatement();
 
%>


<html>
<head>
<title>EUROCUP SWEEPSTAKE 2012</title>
<link rel="stylesheet" type="text/css" href="css/style.css" />
<style type="text/css"> 
/* hide from incapable browsers */
div#scrollbar { 
    display:none;
    }
 
/* below in external file */
div#wn	{ 
    position:relative; 
    width:184px; height:52px; 
    overflow:hidden;	
	}
div#scrollbar { 
    position:relative; 
    width:184px; height:11px;
    display:block; /* display:none initially */
    font-size:1px;  /* so no gap or misplacement due to image vertical alignment */
  }
 
div#track { 
    position:absolute; left:12px; top:0;
    width:160px; height:11px; 
    background: #336;
  }
div#dragBar {
    position:absolute; left:1px; top:1px;
    width:20px; height:9px; 
    background-color:#ceced6;
  }  
div#left { position:absolute; left:0; top:0; }  
div#right { position:absolute; right:0; top:0;  }
 
/* for safari, to prevent selection problem  */
div#scrollbar, div#track, div#dragBar, div#left, div#right {
    -moz-user-select: none;
    -khtml-user-select: none;
}
 
/* so no gap or misplacement due to image vertical alignment
font-size:1px in scrollbar has same effect (less likely to be removed, resulting in support issues) */
div#scrollbar img {
    display:block; 
    } 
 
</style>

</head>


<body>

<%int opcion=1;%>
<%@ include file="header.jsp"%>



<div id="content"> 



<p align="right">
<span style="font-size:15;background:#AAF200;border: 1 solid black;">&nbsp;&nbsp;&nbsp;&nbsp;</span><U>&nbsp;Exact result</U>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<span style="font-size:15;background:#CBFF53;border: 1 solid black;">&nbsp;&nbsp;&nbsp;&nbsp;</span><U>&nbsp;Winner + Goals</U>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<span style="font-size:15;background:#DEFF91;border: 1 solid black;">&nbsp;&nbsp;&nbsp;&nbsp</span><U>&nbsp;Winner</U>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<span style="font-size:15;background:#EFFFCA;border: 1 solid black;">&nbsp;&nbsp;&nbsp;&nbsp</span><U>&nbsp;Goals</U>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</p>

<table id="newspaper-b">
		<thead>
			<th scope="col">&nbsp;</th>
			<th scope="col">&nbsp;</th>
			<th scope="col"align="center">&nbsp;</th>
			<th scope="col" align="center">Total</th>

<% 
//  String sql3= "SELECT e1,e2,f1,f2 from Partidos where f1 is not null order by idPartido";
  String sql3= "SELECT e1,e2,f1,f2 from Partidos WHERE ((DateDiff ( 'd', Partidos.fecha, Now())>0)or ((DateDiff ( 'd', Partidos.fecha, Now())=0) and (DatePart('h',Now())>15)) ) order by idPartido desc";
	stmt.execute(sql3);
	ResultSet rs = stmt.getResultSet();
	while (rs.next())
	{
		String aux=rs.getString("f1");
	%>
		<%if (aux!=null){%>
			<th scope="col"align="center"><font size="1"><%=rs.getString("e1")%><br/><%=aux%>-<%=rs.getString("f2")%><br/><%=rs.getString("e2")%></font></th>
		<%}else{%>
			<th scope="col"align="center"><font size="1"><%=rs.getString("e1")%><br/>&nbsp;-&nbsp;<br/><%=rs.getString("e2")%></font></th>
		<%}%>
	<%
	}
	%>

		</thead>
		<tbody>
<% 
  String sql= "SELECT usuarios.idJug, usuarios.nombre, usuarios.posicion, Format (sum(apuestas.puntos),'General Number') as puntos FROM usuarios LEFT JOIN apuestas ON usuarios.idJug= apuestas.idJug group by usuarios.idJug, usuarios.nombre, usuarios.puesto, usuarios.posicion order by sum(apuestas.puntos) desc,usuarios.nombre";
	stmt.execute(sql);
	rs = stmt.getResultSet();
int i=1;
while (rs.next())
{
	String idjug=rs.getString("idJug");
	String nombre=rs.getString("nombre");
	String puntos=rs.getString("puntos");
	String posicion=rs.getString("posicion");
	String posNum = posicion;
	int pos = Integer.valueOf(posicion);

	%>
		<%if ((session.getAttribute("nombre")!=null) &&(session.getAttribute("nombre").equals(nombre))) {%>
		<tr style="border:1 solid;">
		<%}else{%>
		<tr>
		<%}%>
		<td><i><%=i%></i>.</td>
		<td><%=nombre%></td>
		<td>

	<%
	
	if (pos > 0) {
	%>
	<img src="images/arriba.gif"><font size="1"><%=posNum%></font>
	<%
	}else if (pos < 0) {	
	%>
	<img src="images/abajo.gif"><font size="1"><%=Math.abs(Integer.valueOf(posNum))%></font>
	<%
	}else  {
	%>
	<img src="images/igual.gif">
	<%
	}
	%>
			
	
			
	</td>
	<td align="center"><b><%=puntos%></b></td>


<%
//	String sql2="SELECT Partidos.e1, Partidos.e2, Partidos.f1, Partidos.f2, apuestas.r1, apuestas.r2, apuestas.puntos FROM Partidos INNER JOIN apuestas ON Partidos.idPartido = apuestas.idPartido WHERE (((apuestas.idJug)="+idjug+") and (Partidos.f1 is not null)) order by Partidos.idPartido";
  	String sql2="SELECT Partidos.idPartido,Partidos.e1, Partidos.e2, Partidos.f1, Partidos.f2, apuestas.r1, apuestas.r2, apuestas.puntos FROM Partidos INNER JOIN apuestas ON Partidos.idPartido = apuestas.idPartido WHERE (apuestas.idJug="+idjug+") and ((DateDiff ( 'd', Partidos.fecha, Now())>0)or ((DateDiff ( 'd', Partidos.fecha, Now())=0) and (DatePart('h',Now())>15)) ) order by Partidos.idPartido desc";
  Statement stmt2 = con.createStatement();
	stmt2.execute(sql2);
	ResultSet rs2 = stmt2.getResultSet();
	while (rs2.next())
  {
		int id=Integer.valueOf(rs2.getString("idPartido"));
		String e1=rs2.getString("e1");
		String e2=rs2.getString("e2");
		String f1=rs2.getString("f1");
		String f2=rs2.getString("f2");
		String r1=rs2.getString("r1");
		String r2=rs2.getString("r2");
		String puntos2=rs2.getString("puntos");
	%>
		<%if (f1!=null){		
			if (((id<=24)&&(puntos2.equals("6")))
				||((id>24)&&(puntos2.equals("8")))
				||((id>28)&&(puntos2.equals("9")))
				||((id>30)&&(puntos2.equals("11")))
				) {
			%>
			<td align="center" bgcolor="#AAF200">			
			<%			
			}else if (((id<=24)&&(puntos2.equals("4")))
				||((id>24)&&(puntos2.equals("6")))
				||((id>28)&&(puntos2.equals("7")))
				||((id>30)&&(puntos2.equals("9")))
				) {
			%>
			<td align="center" bgcolor="#CBFF53">			
			<%			
			}else if (((id<=24)&&(puntos2.equals("3")))
				||((id>24)&&(puntos2.equals("5")))
				||((id>28)&&(puntos2.equals("6")))
				||((id>30)&&(puntos2.equals("8")))
				) {
			%>
			<td align="center" bgcolor="#DEFF91">			
			<%			
			}else 
			
			if (puntos2.equals("1")) {
			%>
			<td align="center" bgcolor="#EFFFCA">
			<%			
			}else
			{
			
			%>
			<td align="center" bgcolor="#FFFFFF">			
			
			<%			
			}		
			%>			
			<font size="1"><%=r1%>-<%=r2%></font><div style="position: relative; left:18px;width:15;top:11px; height: 12px;font-size:9;color:gray;font-family:arial;">+<%=puntos2%></div></td>
		<%}else{%>
			<td align="center"><font size="1"><!-- &nbsp;<hr> --><%=r1%>-<%=r2%></font></td>
		<%}%>
	<%
  
  }
  stmt2.close();
%>




		</tr>
<%
i++;
}
%>
</tbody>
</table>
<%

  stmt.close();
  con.close();
%>
<br/>

</div>

</body>
</html>