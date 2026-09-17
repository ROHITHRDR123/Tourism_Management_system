<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="com.dcl.tours.dto.User"%>
<%@page import="com.dcl.tours.dto.Package"%>
<%@page import="com.dcl.tours.daoInterfaces.PackageDAO"%>
<%@page import="com.dcl.tours.daoImplClasses.PackageDAOImpl"%>
<%@page import="java.util.List"%>

<%
User user = (User) session.getAttribute("user");

if (user == null) {
	response.sendRedirect("index.jsp");
	return;
}

String pid = request.getParameter("pid");

Package pack = null;
if (pid != null) {
	PackageDAO pdao = new PackageDAOImpl();
	List<Package> list = pdao.getPackageById(Integer.parseInt(pid));
	if (!list.isEmpty()) {
		pack = list.get(0);
	}
}
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Book Your Tour | DCL Tours</title>

<link rel="preconnect" href="https://fonts.googleapis.com">
<link
	href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@600;700;800&family=Manrope:wght@300;400;500;600;700;800&display=swap"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">
<link rel="stylesheet" href="assets/theme.css">

<style>
.book-wrap {
	min-height: 100vh;
	display: flex;
	align-items: center;
	justify-content: center;
	padding: 60px 6%;
}

.book-card {
	width: 100%;
	max-width: 520px;
	background: var(--panel);
	border: 1px solid var(--line);
	border-radius: 10px;
	padding: 48px 44px;
}

.book-card .icon {
	width: 58px;
	height: 58px;
	border-radius: 50%;
	background: rgba(201, 162, 75, .12);
	border: 1px solid var(--gold);
	display: flex;
	align-items: center;
	justify-content: center;
	color: var(--gold-bright);
	font-size: 22px;
	margin-bottom: 26px;
}

.book-card h1 {
	color: #fff;
	font-size: 28px;
	margin-bottom: 8px;
}

.book-card p.lead {
	color: var(--muted);
	font-size: 14px;
	margin-bottom: 26px;
}

.summary {
	background: var(--panel-2);
	border: 1px solid var(--line);
	border-radius: 6px;
	padding: 20px 22px;
	margin-bottom: 30px;
	display: flex;
	justify-content: space-between;
	align-items: center;
}

.summary .name {
	color: #fff;
	font-weight: 700;
	font-size: 16px;
}

.summary .meta {
	color: var(--muted);
	font-size: 12.5px;
	margin-top: 4px;
}

.summary .price {
	color: var(--gold-bright);
	font-size: 22px;
	font-weight: 800;
}

.row2 {
	display: grid;
	grid-template-columns: 1fr 1fr;
	gap: 16px;
}

.field {
	margin-bottom: 22px;
}

.book-card .btn-gold {
	width: 100%;
	margin-top: 6px;
}

.back-link {
	display: block;
	text-align: center;
	margin-top: 20px;
	color: var(--muted);
	text-decoration: none;
	font-size: 13.5px;
}

.back-link:hover {
	color: var(--gold-bright);
}
</style>
</head>

<body class="theme">

	<div class="book-wrap">
		<div class="book-card">

			<div class="icon">
				<i class="fa-solid fa-plane-departure"></i>
			</div>

			<h1>Book Your Tour</h1>
			<p class="lead">Complete the details below to confirm your
				booking.</p>

			<%
			if (pack != null) {
			%>
			<div class="summary">
				<div>
					<div class="name"><%=pack.getPname()%></div>
					<div class="meta">
						Package #<%=pack.getPid()%>
						&middot;
						<%=pack.getNo_of_days()%>
						Days
					</div>
				</div>
				<div class="price">
					&#8377;
					<%=String.format("%.0f", pack.getPrice())%></div>
			</div>
			<%
			}
			%>

			<%
			String error = (String) request.getAttribute("error");

			if (error != null) {
			%>

			<div
				style="background: #ffdddd; color: red; padding: 12px; margin-bottom: 20px; border-radius: 6px; border: 1px solid red;">
				<%=error%>
			</div>

			<%
			}
			%>

			<form action="booking" method="post">

				<input type="hidden" name="pid" value="<%=pid%>">

				<div class="row2">
					<div class="field">
						<label>Journey Start Date</label> <input type="date"
							name="startDate" required>
					</div>
					<div class="field">
						<label>Journey End Date</label> <input type="date" name="endDate"
							required>
					</div>
				</div>

				<button type="submit" class="btn-gold">
					<i class="fa-solid fa-ticket"></i>&nbsp; Confirm Booking
				</button>

			</form>

			<a href="UserDashboard" class="back-link"><i
				class="fa-solid fa-arrow-left"></i>&nbsp; Back to Dashboard</a>

		</div>
	</div>

</body>
</html>
