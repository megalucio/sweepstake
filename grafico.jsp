<%@taglib uri='/WEB-INF/cewolf.tld' prefix='cewolf' %>

<%
if (session.getAttribute("idJ")==null)	response.sendRedirect("login.jsp");
%>

<html>
<head>
<title>EUROCUP SWEEPSTAKE 2012</title>
<link href="cewolf.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css" href="css/style.css" />
</head>


<body>



<%int opcion=2;%>
<%@ include file="header.jsp"%>

<div id="content"> 

<jsp:useBean id="pageViews" class="porra.Grafico"/>
<cewolf:chart 
    id="line" 
    title=""
    type="line" 
    xaxislabel="Games" 
    yaxislabel="Points">
    <cewolf:data>
        <cewolf:producer id="pageViews"/>
    </cewolf:data>
</cewolf:chart>
<p>
<cewolf:img chartid="line" renderer="/cewolf" width="1100" height="600">
    <cewolf:map linkgeneratorid="pageViews" tooltipgeneratorid="pageViews"/>
</cewolf:img>

<br/>
</div>

</body>
</html>