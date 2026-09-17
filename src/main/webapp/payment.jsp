<%@page import="com.dcl.tours.dto.Package"%>
<%@page import="com.dcl.tours.dto.Booking"%>
<%@page import="com.dcl.tours.dto.User"%>
<%@page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
User user = (User) session.getAttribute("user");
Booking booking = (Booking) request.getAttribute("booking");
Package pack = (Package) request.getAttribute("package");

if (user == null || booking == null || pack == null) {
    response.sendRedirect("UserDashboard");
    return;
}

Double amount = pack.getPrice();
Double gst = amount * 0.18;
Double totalAmount = amount + gst;
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Payment | DCL Tours</title>

<link rel="preconnect" href="https://fonts.googleapis.com">
<link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@600;700;800&family=Manrope:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">
<link rel="stylesheet" href="assets/theme.css">

<style>

.pay-shell{
    max-width:1080px;
    margin:0 auto;
    padding:60px 6% 110px;
    display:grid;
    grid-template-columns:1.4fr 1fr;
    gap:34px;
    align-items:flex-start;
}
@media (max-width:900px){ .pay-shell{ grid-template-columns:1fr; } }

.pay-head{
    grid-column:1 / -1;
    margin-bottom:10px;
}
.pay-head span.eyebrow{
    color:var(--gold);
    font-size:12px;
    letter-spacing:.28em;
    text-transform:uppercase;
    font-weight:700;
}
.pay-head h1{ color:#fff; font-size:32px; margin-top:12px; }

.pay-shell form{ display:contents; }

.panel-card{ padding:32px; }

.method-list{ display:flex; flex-direction:column; gap:12px; margin:20px 0 28px; }
.method{
    display:flex;
    align-items:center;
    gap:14px;
    background:var(--panel-2);
    border:1px solid var(--line);
    border-radius:6px;
    padding:16px 18px;
    cursor:pointer;
    transition:.25s;
}
.method:hover{ border-color:rgba(201,162,75,.4); }
.method input{ accent-color:var(--gold); width:18px; height:18px; }
.method i{ color:var(--gold-bright); font-size:18px; width:22px; text-align:center; }
.method span{ color:#fff; font-size:14.5px; font-weight:600; }

.dummy-note{
    display:flex;
    align-items:center;
    gap:10px;
    background:rgba(201,162,75,.08);
    border:1px solid rgba(201,162,75,.25);
    color:var(--gold-bright);
    font-size:12.5px;
    padding:12px 16px;
    border-radius:6px;
    margin-bottom:24px;
}

.field{ margin-bottom:18px; }
.row2{ display:grid; grid-template-columns:1fr 1fr; gap:16px; }

/* order summary */
.summary-card h2{ color:#fff; font-size:19px; margin-bottom:22px; }
.summary-row{
    display:flex; justify-content:space-between;
    padding:12px 0;
    border-bottom:1px solid var(--line);
    font-size:14px;
    color:#d6dbe0;
}
.summary-row.total{
    border-bottom:none;
    padding-top:18px;
    font-size:19px;
    font-weight:800;
    color:#fff;
}
.summary-row .val{ color:#fff; font-weight:600; }
.summary-card .pkg-name{ color:var(--gold-bright); font-weight:700; font-size:15.5px; margin-bottom:4px; }
.summary-card .pkg-meta{ color:var(--muted); font-size:12.5px; margin-bottom:20px; }

.pay-btn{ width:100%; margin-top:24px; font-size:15px; }
</style>
</head>

<body class="theme">

<nav class="topnav">
    <a href="UserDashboard" class="logo"><span>&#9670;</span>&nbsp;DCL Tours</a>
    <div class="links">
        <a href="UserDashboard">Dashboard</a>
        <a href="logout" class="pill">Logout</a>
    </div>
</nav>

<div class="pay-shell">

    <div class="pay-head">
        <span class="eyebrow">Secure Checkout</span>
        <h1>Complete Your Payment</h1>
    </div>

    <form action="payment" method="post">

    <div class="panel-card">

        <h2 style="color:#fff; font-size:19px; margin-bottom:6px;"><i class="fa-solid fa-credit-card"></i>&nbsp; Select Payment Method</h2>

        <div class="dummy-note">
            <i class="fa-solid fa-circle-info"></i>
            This is a simulated checkout for demo purposes &mdash; no real transaction is processed.
        </div>

        <div class="method-list">
            <label class="method">
                <input type="radio" name="pay_mode" value="UPI" checked>
                <i class="fa-brands fa-google-pay"></i>
                <span>UPI Payment</span>
            </label>

            <label class="method">
                <input type="radio" name="pay_mode" value="CARD">
                <i class="fa-solid fa-credit-card"></i>
                <span>Credit / Debit Card</span>
            </label>

            <label class="method">
                <input type="radio" name="pay_mode" value="NET BANKING">
                <i class="fa-solid fa-building-columns"></i>
                <span>Net Banking</span>
            </label>

            <label class="method">
                <input type="radio" name="pay_mode" value="CASH">
                <i class="fa-solid fa-money-bill-wave"></i>
                <span>Cash Payment</span>
            </label>
        </div>

        <h2 style="color:#fff; font-size:16px; margin-bottom:16px;"><i class="fa-solid fa-address-card"></i>&nbsp; Card Details <span style="color:var(--muted); font-weight:400; font-size:12px;">(optional, for demo)</span></h2>

        <div class="field">
            <label>Card Holder Name</label>
            <input type="text" placeholder="Name on card">
        </div>

        <div class="field">
            <label>Card Number</label>
            <input type="text" placeholder="XXXX XXXX XXXX XXXX" maxlength="19">
        </div>

        <div class="row2">
            <div class="field">
                <label>Expiry Date</label>
                <input type="text" placeholder="MM / YY">
            </div>
            <div class="field">
                <label>CVV</label>
                <input type="text" placeholder="&bull;&bull;&bull;" maxlength="3">
            </div>
        </div>

    </div>

    <div class="panel-card summary-card">

        <h2>Order Summary</h2>

        <div class="pkg-name"><%=pack.getPname()%></div>
        <div class="pkg-meta">Booking #<%=booking.getBid()%> &middot; <%=pack.getNo_of_days()%> Days</div>

        <div class="summary-row"><span>Package Price</span><span class="val">&#8377; <%=String.format("%.2f", amount)%></span></div>
        <div class="summary-row"><span>GST (18%)</span><span class="val">&#8377; <%=String.format("%.2f", gst)%></span></div>
        <div class="summary-row total"><span>Total</span><span>&#8377; <%=String.format("%.2f", totalAmount)%></span></div>

        <input type="hidden" name="bid" value="<%=booking.getBid()%>">

        <button type="submit" class="btn-gold pay-btn"><i class="fa-solid fa-lock"></i>&nbsp; Pay &#8377; <%=String.format("%.2f", totalAmount)%></button>

    </div>

    </form>

</div>

</body>
</html>
