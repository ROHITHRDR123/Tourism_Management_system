<%@page import="com.dcl.tours.dto.Package"%>
<%@page import="com.dcl.tours.daoImplClasses.PackageDAOImpl"%>
<%@page import="com.dcl.tours.daoInterfaces.PackageDAO"%>
<%@page import="com.dcl.tours.dto.Location"%>
<%@page import="java.util.List"%>
<%@page import="com.dcl.tours.daoImplClasses.LocationDAOImpl"%>
<%@page import="com.dcl.tours.daoInterfaces.LocationDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	int lid = Integer.parseInt(request.getParameter("package_id"));

	LocationDAO ldao = new LocationDAOImpl();
	List<Location> allLocations = ldao.getAllLocation();

	PackageDAO pdao = new PackageDAOImpl();
	List<Package> packageList = pdao.getPackageById(lid);
	Package pack = packageList.isEmpty() ? null : packageList.get(0);

	Location cover = null;
	List<Location> spots = new java.util.ArrayList<Location>();

	for (Location l : allLocations) {
		if (l.getPid() != null && l.getPid() == lid) {
			spots.add(l);
			if (cover == null) {
				cover = l;
			}
		}
	}

	String cityName = (cover != null) ? cover.getCity_name() : "South India";
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title><%=cityName%> Tour | DCL Tours</title>

<link rel="preconnect" href="https://fonts.googleapis.com">
<link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@600;700;800&family=Manrope:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">
<link rel="stylesheet" href="assets/theme.css">

<style>

.loc-hero{
	position:relative;
	height:56vh;
	min-height:400px;
	display:flex;
	align-items:flex-end;
	<% if (cover != null) { %>
	background:
		linear-gradient(180deg, rgba(10,13,16,.25) 0%, rgba(10,13,16,.95) 100%),
		url('<%=request.getContextPath()%>/<%=cover.getImage_path()%>') center/cover;
	<% } %>
}
.loc-hero-inner{
	padding:0 6% 50px;
	max-width:1300px;
	margin:0 auto;
	width:100%;
}
.loc-hero span.eyebrow{
	color:var(--gold-bright);
	font-size:12px;
	letter-spacing:.3em;
	text-transform:uppercase;
	font-weight:700;
}
.loc-hero h1{
	color:#fff;
	font-size:clamp(34px,5vw,58px);
	margin-top:14px;
}
.loc-hero p.tag{
	color:#cfd6db;
	font-size:15px;
	margin-top:10px;
	max-width:560px;
}

.info-strip{
	max-width:1300px;
	margin:-40px auto 0;
	position:relative;
	z-index:3;
	padding:0 6%;
	display:grid;
	grid-template-columns:repeat(4,1fr);
	gap:20px;
}
@media (max-width:800px){ .info-strip{ grid-template-columns:repeat(2,1fr); } }
.info-box{
	background:var(--panel);
	border:1px solid var(--line);
	border-radius:8px;
	padding:22px;
	text-align:center;
}
.info-box i{ color:var(--gold-bright); font-size:20px; margin-bottom:10px; display:block; }
.info-box h3{ color:var(--muted); font-size:11.5px; letter-spacing:.12em; text-transform:uppercase; margin-bottom:6px; }
.info-box p{ color:#fff; font-weight:700; font-size:15px; }

.section{ max-width:1300px; margin:0 auto; padding:80px 6% 100px; }
.sec-head{ margin-bottom:44px; display:flex; justify-content:space-between; align-items:flex-end; flex-wrap:wrap; gap:16px;}
.sec-head span.eyebrow{ color:var(--gold); font-size:12px; font-weight:700; letter-spacing:.28em; text-transform:uppercase; }
.sec-head h2{ color:#fff; font-size:32px; margin-top:12px; }

.places-grid{
	display:grid;
	grid-template-columns:repeat(2,1fr);
	gap:28px;
}
@media (max-width:800px){ .places-grid{ grid-template-columns:1fr; } }

.place-card{
	background:var(--panel);
	border:1px solid var(--line);
	border-radius:8px;
	overflow:hidden;
	display:flex;
	flex-direction:column;
}
.place-card img{ width:100%; height:230px; object-fit:cover; }
.place-card .pc-body{ padding:26px; }
.place-card h3{ color:#fff; font-size:20px; margin-bottom:8px; }
.place-card .rating{ color:var(--gold); font-size:13px; margin-bottom:12px; }
.place-card p.desc{ color:#c3cad0; font-size:14px; line-height:1.7; }

.back-fixed{
	position:fixed;
	top:22px; left:22px;
	z-index:60;
	background:rgba(10,13,16,.7);
	backdrop-filter:blur(6px);
	border:1px solid var(--line);
	color:#fff;
	padding:10px 20px;
	border-radius:30px;
	font-size:13.5px;
	text-decoration:none;
	display:inline-flex;
	align-items:center;
	gap:8px;
}
.back-fixed:hover{ border-color:var(--gold); color:var(--gold-bright); }

.cta-strip{
	background:var(--panel);
	border:1px solid var(--line);
	border-radius:10px;
	padding:50px 6%;
	text-align:center;
	margin-top:20px;
}
.cta-strip h2{ color:#fff; font-size:26px; margin-bottom:10px; }
.cta-strip p{ color:var(--muted); margin-bottom:26px; font-size:14.5px; }

</style>
</head>

<body class="theme">

<a href="index.jsp" class="back-fixed"><i class="fa-solid fa-arrow-left"></i> Back To Packages</a>

<section class="loc-hero">
	<div class="loc-hero-inner">
		<span class="eyebrow">South India &bull; <%=cityName%></span>
		<h1><%=(pack != null) ? pack.getPname() : cityName%></h1>
		<p class="tag">"One's destination is never a place, but rather a new way of seeing things."</p>
	</div>
</section>

<div class="info-strip">
	<div class="info-box">
		<i class="fa-solid fa-location-dot"></i>
		<h3>Destination</h3>
		<p><%=cityName%></p>
	</div>
	<div class="info-box">
		<i class="fa-solid fa-calendar-days"></i>
		<h3>Duration</h3>
		<p><%=(pack != null) ? pack.getNo_of_days() + " Days" : "-"%></p>
	</div>
	<div class="info-box">
		<i class="fa-solid fa-tag"></i>
		<h3>Price</h3>
		<p><%=(pack != null) ? "\u20B9 " + String.format("%.0f", pack.getPrice()) : "-"%></p>
	</div>
	<div class="info-box">
		<i class="fa-solid fa-map-location-dot"></i>
		<h3>Places Covered</h3>
		<p><%=spots.size()%></p>
	</div>
</div>

<section class="section">

	<div class="sec-head">
		<div>
			<span class="eyebrow">Itinerary</span>
			<h2>Places You'll Visit</h2>
		</div>
	</div>

	<div class="places-grid">
<%
	for (Location loc : spots) {
%>
		<div class="place-card">
			<img src="<%=request.getContextPath()%>/<%=loc.getImage_path()%>" alt="<%=loc.getLname()%>">
			<div class="pc-body">
				<h3><%=loc.getLname()%></h3>
				<div class="rating">&#9733;&#9733;&#9733;&#9733;&#9733; 4.8</div>
				<p class="desc"><%=loc.getDescription()%></p>
			</div>
		</div>
<%
	}
%>
	</div>

	<div class="cta-strip">
		<h2>Ready to explore <%=cityName%>?</h2>
		<p>Lock in your dates and let us take care of the rest.</p>
		<a href="bookPackage.jsp?pid=<%=lid%>" class="btn-gold"><i class="fa-solid fa-ticket"></i>&nbsp; Book This Package</a>
	</div>

</section>

</body>
</html>
