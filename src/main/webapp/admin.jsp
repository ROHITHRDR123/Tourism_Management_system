<%@page import="java.util.List"%>
<%@page import="com.dcl.tours.dto.User"%>
<%@page import="com.dcl.tours.dto.Package"%>
<%@page import="com.dcl.tours.dto.Booking"%>
<%@page import="com.dcl.tours.dto.Payment"%>

<%
User admin = (User) request.getAttribute("admin");
List<User> users = (List<User>) request.getAttribute("users");
List<Package> packages = (List<Package>) request.getAttribute("packages");
List<Booking> bookings = (List<Booking>) request.getAttribute("bookings");
List<Payment> payments = (List<Payment>) request.getAttribute("payments");

if (admin == null) {
	response.sendRedirect("login.jsp");
	return;
}

double totalRevenue = 0;
for (Payment pay : payments) {
	if (pay.getTotal_amount() != null) {
		totalRevenue += pay.getTotal_amount();
	}
}
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Admin Dashboard | DCL Tours</title>

<link
	href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@600;700;800&family=Manrope:wght@300;400;500;600;700;800&display=swap"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">

<style>
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
	font-family: 'Manrope', sans-serif;
}

body {
	background: #0a0d10;
	color: #e2e8f0;
	display: flex;
	min-height: 100vh;
}

/* ---------- Sidebar ---------- */
.sidebar {
	width: 270px;
	background: #11151a;
	padding: 30px 22px;
	flex-shrink: 0;
	border-right: 1px solid rgba(255, 255, 255, .06);
}

.brand {
	display: flex;
	align-items: center;
	gap: 12px;
	font-size: 22px;
	font-weight: 700;
	color: #fff;
	margin-bottom: 40px;
}

.brand i {
	color: #e6c874;
	font-size: 26px;
}

.sidebar a {
	display: flex;
	align-items: center;
	gap: 12px;
	color: #94a3b8;
	text-decoration: none;
	padding: 13px 16px;
	border-radius: 12px;
	margin-bottom: 8px;
	font-weight: 500;
	transition: .25s;
}

.sidebar a:hover, .sidebar a.active {
	background: rgba(16, 185, 129, .12);
	color: #e6c874;
}

/* ---------- Main ---------- */
.main {
	flex: 1;
	padding: 36px 42px;
	overflow-x: hidden;
}

.topbar {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 34px;
}

.topbar h1 {
	font-size: 28px;
	font-weight: 700;
	color: #fff;
}

.topbar p {
	color: #94a3b8;
	margin-top: 4px;
}

.admin-chip {
	background: rgba(16, 185, 129, .12);
	color: #e6c874;
	padding: 10px 20px;
	border-radius: 999px;
	font-weight: 600;
	font-size: 14px;
}

/* ---------- Stat cards ---------- */
.stats {
	display: grid;
	grid-template-columns: repeat(4, 1fr);
	gap: 22px;
	margin-bottom: 40px;
}

@media ( max-width :1100px) {
	.stats {
		grid-template-columns: repeat(2, 1fr);
	}
}

.stat-card {
	background: #11151a;
	border-radius: 18px;
	padding: 24px;
	border: 1px solid rgba(255, 255, 255, .06);
}

.stat-card i {
	font-size: 26px;
	color: #e6c874;
	margin-bottom: 14px;
	display: block;
}

.stat-card h3 {
	font-size: 30px;
	font-weight: 800;
	color: #fff;
}

.stat-card p {
	color: #94a3b8;
	font-size: 14px;
	margin-top: 4px;
}

/* ---------- Panels ---------- */
.panel {
	background: #11151a;
	border-radius: 18px;
	padding: 26px;
	border: 1px solid rgba(255, 255, 255, .06);
	margin-bottom: 34px;
}

.panel h2 {
	font-size: 19px;
	font-weight: 700;
	color: #fff;
	margin-bottom: 20px;
}

table {
	width: 100%;
	border-collapse: collapse;
}

th {
	text-align: left;
	color: #64748b;
	font-size: 12.5px;
	text-transform: uppercase;
	letter-spacing: .05em;
	padding: 10px 14px;
	border-bottom: 1px solid rgba(255, 255, 255, .08);
}

td {
	padding: 14px;
	border-bottom: 1px solid rgba(255, 255, 255, .05);
	font-size: 14.5px;
	color: #e2e8f0;
}

tr:hover td {
	background: rgba(255, 255, 255, .02);
}

.badge-admin {
	background: #c9a24b;
	color: #111;
	padding: 3px 10px;
	border-radius: 999px;
	font-size: 11px;
	font-weight: 700;
}

.empty-row td {
	text-align: center;
	color: #64748b;
	padding: 26px;
}
</style>
</head>

<body>

	<aside class="sidebar">

		<div class="brand">
			<i class="fa-solid fa-earth-asia"></i> DCL Tours Admin
		</div>

		<a href="admin" class="active"><i class="fa-solid fa-gauge"></i>
			Overview</a> <a href="#users"><i class="fa-solid fa-users"></i> Users</a>
		<a href="#packages"><i class="fa-solid fa-suitcase-rolling"></i>
			Packages</a> <a href="#bookings"><i
			class="fa-solid fa-calendar-check"></i> Bookings</a> <a href="#payments"><i
			class="fa-solid fa-credit-card"></i> Payments</a> <a href="index.jsp"><i
			class="fa-solid fa-house"></i> Visit Site</a> <a href="logout"><i
			class="fa-solid fa-right-from-bracket"></i> Logout</a>

	</aside>

	<main class="main">

		<div class="topbar">
			<div>
				<h1>Overview</h1>
				<p>
					Welcome back,
					<%=admin.getUname()%></p>
			</div>
			<div class="admin-chip">
				<i class="fa-solid fa-shield-halved"></i> Administrator
			</div>
		</div>

		<div class="stats">

			<div class="stat-card">
				<i class="fa-solid fa-users"></i>
				<h3><%=users.size()%></h3>
				<p>Registered Users</p>
			</div>

			<div class="stat-card">
				<i class="fa-solid fa-suitcase-rolling"></i>
				<h3><%=packages.size()%></h3>
				<p>Tour Packages</p>
			</div>

			<div class="stat-card">
				<i class="fa-solid fa-calendar-check"></i>
				<h3><%=bookings.size()%></h3>
				<p>Bookings Made</p>
			</div>

			<div class="stat-card">
				<i class="fa-solid fa-indian-rupee-sign"></i>
				<h3>
					&#8377;
					<%=String.format("%.0f", totalRevenue)%></h3>
				<p>Total Revenue</p>
			</div>

		</div>

		<div class="panel" id="users">
			<h2>
				<i class="fa-solid fa-users"></i>&nbsp; Registered Users
			</h2>
			<table>
				<tr>
					<th>UID</th>
					<th>Name</th>
					<th>Phone</th>
					<th>Email</th>
					<th>Role</th>
				</tr>
				<%
				if (users.isEmpty()) {
				%>
				<tr class="empty-row">
					<td colspan="5">No users registered yet.</td>
				</tr>
				<%
				} else {
				for (User u : users) {
				%>
				<tr>
					<td>#<%=u.getUid()%></td>
					<td><%=u.getUname()%></td>
					<td><%=u.getPhno()%></td>
					<td><%=u.getEmail()%></td>
					<td><%=u.getUid() == 1 ? "<span class=\"badge-admin\">ADMIN</span>" : "Traveler"%></td>
				</tr>
				<%
				}
				}
				%>
			</table>
		</div>

		<div class="panel" id="packages">

			<div
				style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px;">

				<h2>
					<i class="fa-solid fa-suitcase-rolling"></i>&nbsp; Tour Packages
				</h2>

				

			</div>
			<table>
				<tr>
					<th>PID</th>
					<th>Package Name</th>
					<th>Price</th>
					<th>Duration</th>
					<th>Action</th>
				</tr>
				<%
				for (Package p : packages) {
				%>
				<tr>
					<td>#<%=p.getPid()%></td>
					<td><%=p.getPname()%></td>
					<td>&#8377; <%=String.format("%.0f", p.getPrice())%></td>
					<td><%=p.getNo_of_days()%> Days</td>

					<td>
    <a href="editPackage.jsp?pid=<%=p.getPid()%>">Edit</a>
</td>
				</tr>
				<%
				}
				%>
			</table>
		</div>

		<div class="panel" id="bookings">
			<h2>
				<i class="fa-solid fa-calendar-check"></i>&nbsp; Bookings
			</h2>
			<table>
				<tr>
					<th>BID</th>
					<th>User ID</th>
					<th>Package ID</th>
					<th>Start Date</th>
					<th>End Date</th>
					<th>Status</th>
					<th>Action</th>
				</tr>
				<%
				if (bookings.isEmpty()) {
				%>
				<tr class="empty-row">
					<td colspan="5">No bookings yet.</td>
				</tr>
				<%
				} else {
				for (Booking b : bookings) {
				%>
				<tr>

					<td>#<%=b.getBid()%></td>
					<td>#<%=b.getUid()%></td>
					<td>#<%=b.getPid()%></td>
					<td><%=b.getStart_date()%></td>
					<td><%=b.getEnd_date()%></td>

					<td><%=b.getStatus()%></td>

					<td>
						<%
						if ("PENDING".equals(b.getStatus())) {
						%> <a href="approveBooking?bid=<%=b.getBid()%>"
						style="color: green; font-weight: bold;"> Approve </a> | <a
						href="rejectBooking?bid=<%=b.getBid()%>"
						style="color: red; font-weight: bold;"> Reject </a> <%
 } else {
 %> <%=b.getStatus()%> <%
 }
 %>

					</td>

				</tr>
				<%
				}
				}
				%>
			</table>
		</div>

		<div class="panel" id="payments">
			<h2>
				<i class="fa-solid fa-credit-card"></i>&nbsp; Payments
			</h2>
			<table>
				<tr>
					<th>Pay ID</th>
					<th>User ID</th>
					<th>Package ID</th>
					<th>Mode</th>
					<th>Amount</th>
					<th>Total</th>
				</tr>
				<%
				if (payments.isEmpty()) {
				%>
				<tr class="empty-row">
					<td colspan="6">No payments recorded yet.</td>
				</tr>
				<%
				} else {
				for (Payment pay : payments) {
				%>
				<tr>
					<td>#<%=pay.getPay_id()%></td>
					<td>#<%=pay.getUid()%></td>
					<td>#<%=pay.getPid()%></td>
					<td><%=pay.getPay_mode()%></td>
					<td>&#8377; <%=String.format("%.2f", pay.getAmount())%></td>
					<td>&#8377; <%=String.format("%.2f", pay.getTotal_amount())%></td>
				</tr>
				<%
				}
				}
				%>
			</table>
		</div>

	</main>

</body>
</html>
