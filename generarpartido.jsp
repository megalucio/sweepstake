<%@ page import= "java.sql.*" %>
<%@ page import= "java.util.*" %>
<%@ page import = "java.util.Date,java.text.SimpleDateFormat,java.text.ParseException"%>

<%
if ((request.getParameter("generar")!=null)&&(request.getParameter("idpartido")!=null)) 
{
  String JDriver = "sun.jdbc.odbc.JdbcOdbcDriver";
  String connectDB="jdbc:odbc:porra";
 
  Class.forName(JDriver);
  Connection con = DriverManager.getConnection(connectDB);
  Statement stmt = con.createStatement();
	
	int resultado1=Integer.parseInt(request.getParameter("f1"));
	int resultado2=Integer.parseInt(request.getParameter("f2"));
	int ganador;
	if (resultado1>resultado2)
		ganador=1;
	else if (resultado1<resultado2)
		ganador=-1;
	else ganador=0;

	
	String sql2= "update partidos set f1="+resultado1+", f2="+resultado2+" where idPartido="+request.getParameter("idpartido");
	stmt.executeUpdate(sql2);
	ResultSet rs = stmt.getResultSet();

	%><p>Result</p><%
	
	
	
	
	
	
String sqlPos= "SELECT usuarios.idJug, usuarios.nombre,Format (sum(apuestas.puntos),'General Number') as puntos FROM usuarios LEFT JOIN apuestas ON usuarios.idJug= apuestas.idJug group by usuarios.idJug, usuarios.nombre, usuarios.puesto order by sum(apuestas.puntos) desc,usuarios.nombre";
	
Statement stmtPosicion = con.createStatement();
	
stmtPosicion.execute(sqlPos);
ResultSet rsPosicion = stmtPosicion.getResultSet();
int i=1;

HashMap posAnt = new HashMap();

while (rsPosicion.next()) {
	String idjug=rsPosicion.getString("idJug");
	String nombre=rsPosicion.getString("nombre");
	String puntos=rsPosicion.getString("puntos");
	posAnt.put(idjug, String.valueOf(i));
	i++;
}

	
	

	

	String sql= "select idApuesta,r1,r2 from apuestas where idPartido="+request.getParameter("idpartido");
  Statement stmt2 = con.createStatement();
  stmt2.execute(sql);
	ResultSet rs2 = stmt2.getResultSet();
	while (rs2.next())
	{
		int puntos=0;
		int ap_ganador;
		int apuesta1=Integer.parseInt(rs2.getString("r1"));
		int apuesta2=Integer.parseInt(rs2.getString("r2"));
		int idapuesta=Integer.parseInt(rs2.getString("idApuesta"));
		if (apuesta1>apuesta2)
			ap_ganador=1;
		else if (apuesta1<apuesta2)
			ap_ganador=-1;
		else ap_ganador=0;

		int extra=0;
		if (Integer.parseInt(request.getParameter("idpartido"))>30) { // Final
			extra=5;
    }
		else if (Integer.parseInt(request.getParameter("idpartido"))>28) { // Semis
			extra=3;
    }
		else if (Integer.parseInt(request.getParameter("idpartido"))>24) { // Cuartos
			extra=2;
    } 
			
		
		if (ap_ganador==ganador)
		{
			if ((apuesta1==resultado1)&&(apuesta2==resultado2)) puntos=6+extra;
			else
				{
				if ((apuesta1==resultado1)||(apuesta2==resultado2)) puntos=4+extra;
				else puntos=3+extra;
				} 
		}
		else if ((apuesta1==resultado1)||(apuesta2==resultado2)) puntos=1;
		
		String sql4="update apuestas set puntos="+puntos+" where idApuesta="+idapuesta;
		stmt.executeUpdate(sql4);
		%>
		<p>Bet made</p>
		<%
	}

	stmt.close();
	stmt2.close();
	
	

	
sqlPos= "SELECT usuarios.idJug, usuarios.nombre,Format (sum(apuestas.puntos),'General Number') as puntos FROM usuarios LEFT JOIN apuestas ON usuarios.idJug= apuestas.idJug group by usuarios.idJug, usuarios.nombre, usuarios.puesto order by sum(apuestas.puntos) desc,usuarios.nombre";
	
stmtPosicion.execute(sqlPos);
rsPosicion = stmtPosicion.getResultSet();
i=1;

HashMap posNueva = new HashMap();

while (rsPosicion.next()) {
	String idjug=rsPosicion.getString("idJug");
	String nombre=rsPosicion.getString("nombre");
	String puntos=rsPosicion.getString("puntos");
	posNueva.put(idjug, String.valueOf(i));
	i++;
}


	
	//System.out.println(posNueva);
	//System.out.println(posAnt);
	
int posicion = 0;	
	
	
	Statement stmtUsuarios = con.createStatement();
	
Iterator it = posAnt.entrySet().iterator();
while (it.hasNext()) {
Map.Entry e = (Map.Entry)it.next();
posicion = 0;

String idjugador = (String) e.getKey();
String posicionAnt = (String) e.getValue();
String posicionNueva = (String) posNueva.get(idjugador);

//System.out.println("id: " + idjugador);
//System.out.println("posicionAnt: " + posicionAnt);
//System.out.println("posicionNueva: " + posicionNueva);
//System.out.println("");

posicion = Integer.valueOf(posicionAnt) - Integer.valueOf(posicionNueva);


	if (Integer.valueOf(posicionAnt) < Integer.valueOf(posicionNueva)) {
	//posicion = 2;
	} else if (Integer.valueOf(posicionAnt) > Integer.valueOf(posicionNueva)) {
	//posicion = 1;
	}


 
	String sql5="update usuarios set posicion="+posicion+" where idJug="+idjugador;
	
	
	
	
	stmtUsuarios.executeUpdate(sql5);

}


stmtUsuarios.close();
stmtPosicion.close();


  con.close();
  
}
%>


<html>
<head>
<title>EUROCUP SWEEPSTAKE 2012</title></head><body>

<body>

<form method="post" action="generarpartido.jsp">

<table>
<tr><td>idPartido:</td>
		<td><input type="text" name="idpartido" value="" style="width:30px;"></td></tr>
<tr><td>Score 1</td><td><input type="text" name="f1" value="" style="width:30px;"></td></tr>
<tr><td>Score 2</td><td><input type="text" name="f2" value="" style="width:30px;"></td></tr>
<tr><td> </td><td><input type="submit" name="generar" value="generar"></td></tr>
</table>
</form>	
	
</body>
</html>