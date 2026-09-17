<%@page import="java.util.List"%>
<%@page import="com.dcl.tours.dto.Package"%>
<%@page import="com.dcl.tours.dto.Location"%>
<%@page import="com.dcl.tours.dto.User"%>
<%@page import="com.dcl.tours.dto.Booking"%>

<%
User user = (User) request.getAttribute("user");
List<Package> packages = (List<Package>) request.getAttribute("packages");
List<Location> locations = (List<Location>) request.getAttribute("locations");
List<Booking> bookings = (List<Booking>) request.getAttribute("bookings");
String success = (String) request.getAttribute("success");
String error = (String) request.getAttribute("error");
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>My Dashboard | DCL Tours</title>

<link rel="preconnect" href="https://fonts.googleapis.com">
<link
	href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@600;700;800&family=Manrope:wght@300;400;500;600;700;800&display=swap"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">
<link rel="stylesheet" href="assets/theme.css">

<style>
.dash-hero {
	background: linear-gradient(180deg, rgba(10, 13, 16, .55) 0%,
		rgba(10, 13, 16, .92) 100%), url('images/c2k.jpg') center/cover;
	padding: 70px 6% 50px;
	text-align: center;
}

.dash-hero span.eyebrow {
	color: var(--gold-bright);
	font-size: 12px;
	letter-spacing: .3em;
	text-transform: uppercase;
	font-weight: 700;
}

.dash-hero h1 {
	color: #fff;
	font-size: clamp(28px, 4vw, 42px);
	margin-top: 14px;
}

.dash-hero p {
	color: var(--muted);
	margin-top: 10px;
	font-size: 15px;
}

.section {
	padding: 60px 6% 100px;
	max-width: 1300px;
	margin: 0 auto;
}

.sec-head {
	margin-bottom: 44px;
}

.sec-head span.eyebrow {
	color: var(--gold);
	font-size: 12px;
	font-weight: 700;
	letter-spacing: .28em;
	text-transform: uppercase;
}

.sec-head h2 {
	color: #fff;
	font-size: 32px;
	margin-top: 12px;
}

.pkg-grid {
	display: grid;
	grid-template-columns: repeat(3, 1fr);
	gap: 30px;
}

@media ( max-width :1100px) {
	.pkg-grid {
		grid-template-columns: repeat(2, 1fr);
	}
}

@media ( max-width :680px) {
	.pkg-grid {
		grid-template-columns: 1fr;
	}
}

.pkg-card {
	background: var(--panel);
	border: 1px solid var(--line);
	border-radius: 8px;
	overflow: hidden;
	transition: .35s;
}

.pkg-card:hover {
	transform: translateY(-6px);
	border-color: rgba(201, 162, 75, .45);
}

.pkg-card img {
	width: 100%;
	height: 210px;
	object-fit: cover;
	display: block;
}

.pkg-card-body {
	padding: 24px;
}

.pkg-card-body .city {
	color: var(--gold-bright);
	font-size: 11.5px;
	letter-spacing: .15em;
	text-transform: uppercase;
	font-weight: 700;
}

.pkg-card-body h3 {
	color: #fff;
	font-size: 21px;
	margin: 8px 0 14px;
}

.pkg-meta {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 18px;
}

.pkg-meta .price {
	color: #fff;
	font-size: 20px;
	font-weight: 800;
}

.pkg-meta .days {
	color: var(--muted);
	font-size: 13px;
}

.banner {
	margin-left: 0;
	margin-right: 0;
	max-width: none;
}
</style>
</head>

<body class="theme">

	<nav class="topnav">
		<a href="UserDashboard" class="logo"><span>&#9670;</span>&nbsp;DCL
			Tours</a>
		<div class="links">
			<a href="UserDashboard">Dashboard</a> <a href="index.jsp">Visit
				Site</a> <a href="logout" class="pill">Logout</a>
		</div>
	</nav>

	<div class="dash-hero">
		<span class="eyebrow">Welcome Back</span>
		<h1><%=user.getUname()%></h1>
		<p>Pick your next journey and let us handle the rest.</p>
	</div>

	<div class="section">

		<%
		if (success != null) {
		%>
		<div class="banner banner-success"><%=success%></div>
		<%
		}
		%>

		<%
		if (error != null) {
		%>
		<div class="banner banner-error"><%=error%></div>
		<%
		}
		%>

		<div class="sec-head">
			<span class="eyebrow">My Trips</span>
			<h2>My Bookings</h2>
		</div>

		<%
		if (bookings != null && !bookings.isEmpty()) {
		%>

		<table
			style="width: 100%; border-collapse: collapse; margin-bottom: 60px; background: #1b1b1b; color: white;">

			<tr style="background: #c9a24b; color: black;">
				<th style="padding: 12px;">Booking ID</th>
				<th>Package</th>
				<th>Start Date</th>
				<th>End Date</th>
				<th>Status</th>
				<th>Payment</th>
			</tr>
			<%
			for (Booking b : bookings) {

				Package bookedPackage = null;

				for (Package p : packages) {
					if (p.getPid().equals(b.getPid())) {
				bookedPackage = p;
				break;
					}
				}
			%>

			<tr style="text-align: center;">

				<td style="padding: 12px;"><%=b.getBid()%></td>

				<td><%=bookedPackage != null ? bookedPackage.getPname() : ""%></td>

				<td><%=b.getStart_date()%></td>

				<td><%=b.getEnd_date()%></td>

				<td><%=b.getStatus()%></td>

				<td>
					<%
					if ("APPROVED".equals(b.getStatus())) {
					%> <a href="payment?bid=<%=b.getBid()%>" class="btn-gold"> Pay
						Now </a> <%
 } else if ("PENDING".equals(b.getStatus())) {
 %> Waiting for Approval <%
 } else {
 %> Booking Rejected <%
 }
 %>

				</td>

			</tr>

			<%
			}
			%>

		</table>

		<%
		} else {
		%>

		<p style="color: white; margin-bottom: 60px;">No bookings yet.</p>

		<%
		}
		%>
		<div class="sec-head">
			<span class="eyebrow">Available Now</span>
			<h2>Tour Packages</h2>
		</div>

		<div class="pkg-grid">

			<%
			for (Package p : packages) {

				Location cover = null;

				if (locations != null) {
					for (Location l : locations) {
				if (l.getPid() != null && l.getPid().equals(p.getPid())) {
					cover = l;
					break;
				}
					}
				}
			%>

			<div class="pkg-card">

				<%
				if (cover != null) {
				%>
				<img src="<%=request.getContextPath()%>/<%=cover.getImage_path()%>"
					alt="<%=cover.getCity_name()%>">
				<%
				}
				%>

				<div class="pkg-card-body">

					<%
					if (cover != null) {
					%>
					<span class="city"><i class="fa-solid fa-location-dot"></i>&nbsp;
						<%=cover.getCity_name()%></span>
					<%
					}
					%>

					<h3><%=p.getPname()%></h3>

					<div class="pkg-meta">
						<span class="price">&#8377; <%=String.format("%.0f", p.getPrice())%></span>
						<span class="days">&nbsp;<%=p.getNo_of_days()%> Days
						</span>
					</div>

					<a href="bookPackage.jsp?pid=<%=p.getPid()%>" class="btn-gold"
						style="width: 100%; display: block;">Book Now</a>

				</div>

			</div>

			<%
			}
			%>

		</div>

	</div>

</body>
</html>
