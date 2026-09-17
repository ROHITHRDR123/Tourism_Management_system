<%
String error = (String) request.getAttribute("error");
String success = (String) request.getAttribute("success");
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Reset Password | DCL Tours</title>

<link rel="preconnect" href="https://fonts.googleapis.com">
<link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@600;700;800&family=Manrope:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">
<link rel="stylesheet" href="assets/theme.css">

<style>
.reset-wrap{
    min-height:100vh;
    display:flex;
    align-items:center;
    justify-content:center;
    padding:40px 6%;
}
.reset-box{
    width:100%;
    max-width:440px;
    background:var(--panel);
    border:1px solid var(--line);
    border-radius:10px;
    padding:48px 40px;
}
.reset-box .icon{
    width:56px; height:56px;
    border-radius:50%;
    background:rgba(201,162,75,.12);
    border:1px solid var(--gold);
    display:flex; align-items:center; justify-content:center;
    color:var(--gold-bright);
    font-size:22px;
    margin-bottom:24px;
}
.reset-box h1{ color:#fff; font-size:26px; margin-bottom:8px; }
.reset-box p.lead{ color:var(--muted); font-size:14px; margin-bottom:28px; }
.field{ margin-bottom:20px; }
.reset-box .btn-gold{ width:100%; }
.back-link{
    display:block;
    text-align:center;
    margin-top:22px;
    color:var(--muted);
    text-decoration:none;
    font-size:13.5px;
}
.back-link:hover{ color:var(--gold-bright); }
</style>
</head>

<body class="theme">

<div class="reset-wrap">
    <div class="reset-box">

        <div class="icon"><i class="fa-solid fa-key"></i></div>

        <h1>Reset Your Password</h1>
        <p class="lead">Enter your account email and a new password.</p>

        <% if (error != null) { %>
            <div class="banner banner-error"><%=error%></div>
        <% } %>

        <% if (success != null) { %>
            <div class="banner banner-success"><%=success%></div>
        <% } %>

        <form action="forgotPassword" method="post">

            <div class="field">
                <label>Email Address</label>
                <input type="email" name="email" placeholder="you@example.com" required>
            </div>

            <div class="field">
                <label>New Password</label>
                <input type="password" name="password" required>
            </div>

            <div class="field">
                <label>Confirm New Password</label>
                <input type="password" name="confirm" required>
            </div>

            <button type="submit" class="btn-gold">Update Password</button>

        </form>

        <a href="login.jsp" class="back-link"><i class="fa-solid fa-arrow-left"></i>&nbsp; Back to Sign In</a>

    </div>
</div>

</body>
</html>
