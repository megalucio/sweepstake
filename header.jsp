<%@ page contentType="text/html;charset=UTF-8" %>

<h1 style="font-type:arial;">EUROCUP SWEEPSTAKE 2012</h1>
<!--<img src="images/cerner.gif" style="position:absolute; top:25; right:0;">-->

<img src="images/cerner.gif" width="90" height="30" style="position:absolute; top:25; right:20;">
<img src="images/euro2012.jpg" width="110" height="66" style="position:absolute; top:5; right:110;">

<div id="header">
<ul> 
<%if (opcion!=0) {%>
	<li <%if (opcion==1) {%>id="selected"<%}%>
><a href="listado.jsp">Ranking</a></li> 
	<li <%if (opcion==2) {%>id="selected"<%}%>
><a href="grafico.jsp">Follow-up</a></li> 
	<li <%if (opcion==3) {%>id="selected"<%}%>
><a href="apuesta.jsp">Your bets</a></li> 
	<li <%if (opcion==4) {%>id="selected"<%}%>
><a href="options.jsp">Change password</a></li> 
<%}%>

</ul> 
</div>
