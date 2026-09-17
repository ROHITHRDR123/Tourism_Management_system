<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Sign In | DCL Tours</title>

<link rel="preconnect" href="https://fonts.googleapis.com">
<link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@600;700;800&family=Manrope:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">
<link rel="stylesheet" href="assets/theme.css">

<style>

.auth-wrap{
    min-height:100vh;
    display:flex;
}

.auth-visual{
    flex:1.1;
    position:relative;
    background:
        linear-gradient(180deg, rgba(10,13,16,.35) 0%, rgba(10,13,16,.9) 100%),
        url('images/h1k.jpg') center/cover;
    display:flex;
    flex-direction:column;
    justify-content:flex-end;
    padding:60px;
}
.auth-visual .logo{
    position:absolute;
    top:40px; left:60px;
    font-family:'Playfair Display', serif;
    font-size:24px;
    font-weight:700;
    color:#fff;
}
.auth-visual .logo span{ color:var(--gold); }
.auth-visual h2{
    color:#fff;
    font-size:36px;
    max-width:420px;
    line-height:1.25;
    margin-bottom:16px;
}
.auth-visual p{
    color:#cfd6db;
    max-width:400px;
    font-size:14.5px;
    line-height:1.7;
}
@media (max-width:900px){ .auth-visual{ display:none; } }

.auth-form-side{
    flex:1;
    display:flex;
    align-items:center;
    justify-content:center;
    padding:60px 8%;
    position:relative;
}

.auth-box{
    width:100%;
    max-width:420px;
}

.tabs{
    display:flex;
    gap:6px;
    margin-bottom:36px;
    background:var(--panel-2);
    border:1px solid var(--line);
    border-radius:6px;
    padding:5px;
}
.tabs button{
    flex:1;
    background:transparent;
    border:none;
    color:var(--muted);
    font-family:'Manrope';
    font-weight:700;
    font-size:13.5px;
    letter-spacing:.03em;
    padding:12px 0;
    border-radius:4px;
    cursor:pointer;
    transition:.25s;
}
.tabs button.active{
    background:var(--gold);
    color:#100c02;
}

.auth-panel{ display:none; }
.auth-panel.active{ display:block; }

.auth-panel h1{
    color:#fff;
    font-size:30px;
    margin-bottom:8px;
}
.auth-panel .lead{
    color:var(--muted);
    font-size:14px;
    margin-bottom:30px;
}

.field{ margin-bottom:20px; }

.row2{ display:grid; grid-template-columns:1fr 1fr; gap:16px; }

.auth-panel .btn-gold{ width:100%; margin-top:6px; }

.small-links{
    display:flex;
    justify-content:space-between;
    margin-top:16px;
    font-size:13px;
}
.small-links a{ color:var(--muted); text-decoration:none; }
.small-links a:hover{ color:var(--gold-bright); }

.admin-link-row{
    margin-top:34px;
    text-align:center;
    font-size:13px;
    color:var(--muted);
}
.admin-link-row a{ color:var(--gold-bright); text-decoration:none; font-weight:600; cursor:pointer; }

/* Admin modal */
.modal-backdrop{
    display:none;
    position:fixed; inset:0;
    background:rgba(6,8,10,.75);
    backdrop-filter:blur(4px);
    z-index:200;
    align-items:center;
    justify-content:center;
}
.modal-backdrop.show{ display:flex; }
.modal-box{
    width:92%;
    max-width:380px;
    background:var(--panel);
    border:1px solid var(--line);
    border-radius:8px;
    padding:36px;
    position:relative;
}
.modal-box .close-x{
    position:absolute; top:16px; right:18px;
    color:var(--muted);
    background:none; border:none; font-size:18px; cursor:pointer;
}
.modal-box h2{ color:#fff; font-size:22px; margin-bottom:6px; }
.modal-box p.lead{ color:var(--muted); font-size:13px; margin-bottom:24px; }

</style>
</head>

<body class="theme">

<%
String loginError = (String) request.getAttribute("loginError");
String signupError = (String) request.getAttribute("signupError");
String signupSuccess = (String) request.getAttribute("signupSuccess");
%>

<div class="auth-wrap">

    <div class="auth-visual">
        <div class="logo"><span>&#9670;</span>&nbsp;DCL Tours</div>
        <h2>Every journey starts with an account.</h2>
        <p>Sign in to book curated South India itineraries, track your trips, and manage payments in one place.</p>
    </div>

    <div class="auth-form-side">
        <div class="auth-box">

            <% if (loginError != null) { %>
                <div class="banner banner-error"><%=loginError%></div>
            <% } %>
            <% if (signupError != null) { %>
                <div class="banner banner-error"><%=signupError%></div>
            <% } %>
            <% if (signupSuccess != null) { %>
                <div class="banner banner-success"><%=signupSuccess%></div>
            <% } %>

            <div class="tabs">
                <button type="button" class="active" onclick="showPanel('login', this)">Sign In</button>
                <button type="button" onclick="showPanel('signup', this)">Create Account</button>
            </div>

            <!-- ============ LOGIN ============ -->
            <div class="auth-panel active" id="panel-login">
                <h1>Welcome Back</h1>
                <p class="lead">Sign in to continue your journey.</p>

                <form action="login" method="post">

                    <div class="field">
                        <label>Email Address</label>
                        <input type="email" name="email" placeholder="you@example.com" required>
                    </div>

                    <div class="field">
                        <label>Password</label>
                        <input type="password" name="password" placeholder="&bull;&bull;&bull;&bull;&bull;&bull;&bull;&bull;" required>
                    </div>

                    <button type="submit" class="btn-gold">Sign In</button>

                    <div class="small-links">
                        <a href="forgotPassword.jsp">Forgot Password?</a>
                        <span></span>
                    </div>

                </form>

                <div class="admin-link-row">
                    Are you an administrator? <a onclick="openAdmin()">Admin Sign In</a>
                </div>
            </div>

            <!-- ============ SIGNUP ============ -->
            <div class="auth-panel" id="panel-signup">
                <h1>Create Account</h1>
                <p class="lead">Join us and start planning your next trip.</p>

                <form action="signup" method="post">

                    <div class="field">
                        <label>Full Name</label>
                        <input type="text" name="name" placeholder="Your full name" required>
                    </div>

                    <div class="row2">
                        <div class="field">
                            <label>Phone</label>
                            <input type="tel" name="phone" placeholder="9876543210" required>
                        </div>
                        <div class="field">
                            <label>Email</label>
                            <input type="email" name="email" placeholder="you@example.com" required>
                        </div>
                    </div>

                    <div class="row2">
                        <div class="field">
                            <label>Password</label>
                            <input type="password" name="password" required>
                        </div>
                        <div class="field">
                            <label>Confirm Password</label>
                            <input type="password" name="confirm" required>
                        </div>
                    </div>

                    <button type="submit" class="btn-gold">Create Account</button>

                </form>
            </div>

        </div>
    </div>

</div>

<!-- ============ ADMIN MODAL ============ -->
<div class="modal-backdrop" id="adminModal">
    <div class="modal-box">
        <button class="close-x" onclick="closeAdmin()"><i class="fa-solid fa-xmark"></i></button>
        <h2>Administrator Sign In</h2>
        <p class="lead">Restricted access &mdash; DCL Tours staff only.</p>

        <form action="adminLogin" method="post">

            <div class="field">
                <label>Admin ID</label>
                <input type="text" name="adminId" placeholder="admin@dcltours.com" required>
            </div>

            <div class="field">
                <label>Password</label>
                <input type="password" name="password" required>
            </div>

            <button type="submit" class="btn-gold">Sign In as Admin</button>

        </form>
    </div>
</div>

<script>
function showPanel(name, btn) {
    document.querySelectorAll('.auth-panel').forEach(function(p){ p.classList.remove('active'); });
    document.getElementById('panel-' + name).classList.add('active');
    document.querySelectorAll('.tabs button').forEach(function(b){ b.classList.remove('active'); });
    btn.classList.add('active');
}
function openAdmin(){ document.getElementById('adminModal').classList.add('show'); }
function closeAdmin(){ document.getElementById('adminModal').classList.remove('show'); }

<% if (signupSuccess != null) { %>
showPanel('login', document.querySelector('.tabs button'));
<% } %>
<% if (signupError != null) { %>
showPanel('signup', document.querySelectorAll('.tabs button')[1]);
<% } %>
</script>

</body>
</html>
