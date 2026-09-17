<%@page import="java.util.List"%>
<%@page import="com.dcl.tours.dto.Package"%>
<%@page import="com.dcl.tours.daoImplClasses.PackageDAOImpl"%>
<%@page import="com.dcl.tours.daoInterfaces.PackageDAO"%>

<%
int pid = Integer.parseInt(request.getParameter("pid"));

PackageDAO dao = new PackageDAOImpl();

List<Package> list = dao.getPackageById(pid);

Package p = list.get(0);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Edit Package</title>

<style>

body{
background:#111;
font-family:Arial;
color:white;
display:flex;
justify-content:center;
align-items:center;
height:100vh;
}

.box{
background:#222;
padding:30px;
width:400px;
border-radius:10px;
}

input{
width:100%;
padding:10px;
margin:10px 0;
}

button{
width:100%;
padding:12px;
background:gold;
border:none;
font-size:18px;
cursor:pointer;
}

a{
color:white;
text-decoration:none;
}

</style>

</head>

<body>

<div class="box">

<h2>Edit Package</h2>

<form action="UpdatePackageServlet" method="post">

<input
type="hidden"
name="pid"
value="<%=p.getPid()%>">

Package Name

<input
type="text"
name="pname"
value="<%=p.getPname()%>"
required>

Price

<input
type="number"
step="0.01"
name="price"
value="<%=p.getPrice()%>"
required>

Number Of Days

<input
type="number"
name="days"
value="<%=p.getNo_of_days()%>"
required>

<button type="submit">
Update Package
</button>

</form>

<br>

<a href="admin">← Back</a>

</div>

</body>
</html>