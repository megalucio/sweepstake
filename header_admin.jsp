
<h1 style="font-type:arial;">EUROCUP SWEEPSTAKE 2012</h1>
<img src="images/indra.jpg" style="position:absolute; top:25; right:0;">
<img src="images/2010.jpg" width="110" height="66" style="position:absolute; top:10; right:100;">

<div id="header">
<ul> 

	<li <%if (opcion==1) {%>id="selected"<%}%>
><a href="generarjugador.jsp">Generate Player</a></li> 
	<li <%if (opcion==2) {%>id="selected"<%}%>
><a href="generarpartido.jsp">Update Game</a></li> 
	<li <%if (opcion==3) {%>id="selected"<%}%>
><a href="renombrar.jsp">Rename Game</a></li> 
	<li <%if (opcion==4) {%>id="selected"<%}%>
><a href="admin_opciones.jsp">Other</a></li> 


</ul> 
</div>
