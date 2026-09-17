<%@page import="com.dcl.tours.dto.User"%>
<%@page import="com.dcl.tours.dto.Payment"%>
<%@page import="com.dcl.tours.dto.Package"%>
<%@page import="com.dcl.tours.dto.Booking"%>
<%@ page language="java"
contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<%

User user = (User)session.getAttribute("user");

Booking booking = (Booking)request.getAttribute("booking");

Package pack = (Package)request.getAttribute("package");

Payment payment = (Payment)request.getAttribute("payment");

String success = (String)request.getAttribute("success");

if(user==null || booking==null || pack==null || payment==null){

    response.sendRedirect("UserDashboard");
    return;

}

Double gst = payment.getTotal_amount() - payment.getAmount();

%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Invoice #INV-<%=payment.getPay_id()%> | DCL Tours</title>

<link rel="preconnect" href="https://fonts.googleapis.com">
<link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@600;700;800&family=Manrope:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">
<link rel="stylesheet" href="assets/theme.css">

<style>

.bill-shell{
    max-width:820px;
    margin:0 auto;
    padding:60px 6% 110px;
}

.success-banner{
    display:flex;
    align-items:center;
    gap:12px;
    background:var(--success-bg);
    border:1px solid rgba(143,227,181,.3);
    color:var(--success);
    padding:16px 22px;
    border-radius:8px;
    margin-bottom:28px;
    font-weight:600;
}

.invoice{
    background:var(--panel);
    border:1px solid var(--line);
    border-radius:10px;
    padding:50px;
}

.inv-top{
    display:flex;
    justify-content:space-between;
    align-items:flex-start;
    border-bottom:1px solid var(--line);
    padding-bottom:30px;
    margin-bottom:30px;
}
.inv-top .brand{
    font-family:'Playfair Display', serif;
    font-size:24px;
    font-weight:700;
    color:#fff;
}
.inv-top .brand span{ color:var(--gold); }
.inv-top .brand small{
    display:block;
    color:var(--muted);
    font-size:12px;
    font-family:'Manrope';
    font-weight:400;
    margin-top:6px;
}
.inv-top .inv-num{ text-align:right; }
.inv-top .inv-num h3{ color:var(--gold-bright); font-size:20px; }
.inv-top .inv-num p{ color:var(--muted); font-size:12.5px; margin-top:4px; }

.inv-parties{
    display:grid;
    grid-template-columns:1fr 1fr;
    gap:24px;
    margin-bottom:34px;
}
.inv-parties h4{
    color:var(--gold);
    font-size:11.5px;
    letter-spacing:.15em;
    text-transform:uppercase;
    margin-bottom:10px;
}
.inv-parties p{ color:#dfe4e8; font-size:14.5px; line-height:1.6; }
.inv-parties p.muted{ color:var(--muted); font-size:13px; }

table.inv-table{
    width:100%;
    border-collapse:collapse;
    margin-bottom:10px;
}
table.inv-table th{
    text-align:left;
    color:var(--muted);
    font-size:11.5px;
    letter-spacing:.1em;
    text-transform:uppercase;
    padding:10px 0;
    border-bottom:1px solid var(--line);
}
table.inv-table td{
    padding:16px 0;
    border-bottom:1px solid var(--line);
    color:#e4e9ec;
    font-size:14.5px;
}
table.inv-table td.right{ text-align:right; }

.totals{
    margin-top:20px;
    margin-left:auto;
    width:280px;
}
.totals .r{
    display:flex; justify-content:space-between;
    padding:10px 0;
    font-size:14px;
    color:#c9d0d5;
}
.totals .r.grand{
    border-top:1px solid var(--line);
    margin-top:6px;
    padding-top:16px;
    font-size:19px;
    font-weight:800;
    color:#fff;
}

.paid-stamp{
    display:inline-block;
    margin-top:26px;
    color:var(--success);
    border:1px solid rgba(143,227,181,.4);
    background:rgba(143,227,181,.08);
    padding:8px 18px;
    border-radius:4px;
    font-weight:700;
    font-size:13px;
    letter-spacing:.08em;
    text-transform:uppercase;
}

.action-row{
    display:flex;
    gap:16px;
    margin-top:36px;
}

/* ---------------- Print styles ---------------- */
@media print{
    body{ background:#fff !important; }
    .topnav, .action-row{ display:none !important; }
    .bill-shell{ padding:0; max-width:100%; }
    .invoice{
        background:#fff !important;
        border:none !important;
        color:#111 !important;
        box-shadow:none !important;
    }
    .invoice *{ color:#111 !important; }
    .inv-top, .inv-parties h4, table.inv-table th, table.inv-table td, .totals .r{
        border-color:#ddd !important;
    }
    .paid-stamp{ border-color:#111 !important; background:none !important; color:#111 !important; }
}
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

<div class="bill-shell">

    <% if (success != null) { %>
    <div class="success-banner"><i class="fa-solid fa-circle-check"></i> <%=success%></div>
    <% } %>

    <div class="invoice" id="invoice">

        <div class="inv-top">
            <div class="brand">
                <span>&#9670;</span>&nbsp;DCL Tours
                <small>Journeys Through South India</small>
            </div>
            <div class="inv-num">
                <h3>#INV-<%=payment.getPay_id()%></h3>
                <p>Booking #<%=booking.getBid()%></p>
            </div>
        </div>

        <div class="inv-parties">
            <div>
                <h4>Billed To</h4>
                <p><%=user.getUname()%></p>
                <p class="muted"><%=user.getEmail()%></p>
                <p class="muted"><%=user.getPhno()%></p>
            </div>
            <div>
                <h4>Trip Details</h4>
                <p><%=pack.getPname()%></p>
                <p class="muted"><%=booking.getStart_date()%> &rarr; <%=booking.getEnd_date()%></p>
                <p class="muted"><%=pack.getNo_of_days()%> Days</p>
            </div>
        </div>

        <table class="inv-table">
            <tr>
                <th>Description</th>
                <th>Payment Mode</th>
                <th style="text-align:right;">Amount</th>
            </tr>
            <tr>
                <td><%=pack.getPname()%> Package</td>
                <td><%=payment.getPay_mode()%></td>
                <td class="right">&#8377; <%=String.format("%.2f", payment.getAmount())%></td>
            </tr>
        </table>

        <div class="totals">
            <div class="r"><span>Subtotal</span><span>&#8377; <%=String.format("%.2f", payment.getAmount())%></span></div>
            <div class="r"><span>GST (18%)</span><span>&#8377; <%=String.format("%.2f", gst)%></span></div>
            <div class="r grand"><span>Total Paid</span><span>&#8377; <%=String.format("%.2f", payment.getTotal_amount())%></span></div>
        </div>

        <div class="paid-stamp"><i class="fa-solid fa-circle-check"></i>&nbsp; Payment Successful</div>

    </div>

    <div class="action-row">
        <a href="UserDashboard" class="btn-outline"><i class="fa-solid fa-arrow-left"></i>&nbsp; Back to Dashboard</a>
        <button onclick="window.print();" class="btn-gold"><i class="fa-solid fa-print"></i>&nbsp; Print Invoice</button>
    </div>

</div>

</body>
</html>
