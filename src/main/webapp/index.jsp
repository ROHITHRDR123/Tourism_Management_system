<%@page import="com.dcl.tours.dto.Location"%>
<%@page import="com.dcl.tours.daoImplClasses.LocationDAOImpl"%>
<%@page import="com.dcl.tours.daoInterfaces.LocationDAO"%>
<%@page import="com.dcl.tours.dto.Package"%>
<%@page import="java.util.List"%>
<%@page import="com.dcl.tours.daoImplClasses.PackageDAOImpl"%>
<%@page import="com.dcl.tours.daoInterfaces.PackageDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">   
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>DCL Tours &mdash; Journeys Through South India</title>

<link rel="preconnect" href="https://fonts.googleapis.com">
<link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@500;600;700;800&family=Manrope:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">

<style>

:root{
    --gold:#c9a24b;
    --gold-bright:#e6c874;
    --ink:#0a0d10;
    --panel:#11151a;
    --panel-2:#161b21;
    --line:rgba(255,255,255,.08);
    --muted:#93a0ab;
    --text:#eef1f3;
}

*{ margin:0; padding:0; box-sizing:border-box; }

html{ scroll-behavior:smooth; }

body{
    background:var(--ink);
    color:var(--text);
    font-family:'Manrope', sans-serif;
    overflow-x:hidden;
}

h1,h2,h3, .display{
    font-family:'Playfair Display', serif;
}

::selection{ background:var(--gold); color:#0a0d10; }

/* scrollbar */
::-webkit-scrollbar{ width:9px; }
::-webkit-scrollbar-track{ background:var(--ink); }
::-webkit-scrollbar-thumb{ background:#2a3138; border-radius:10px; }

/* ================= NAV ================= */
.nav{
    position:fixed;
    top:0; left:0; right:0;
    z-index:100;
    padding:26px 6%;
    display:flex;
    align-items:center;
    justify-content:space-between;
    transition:.4s;
}
.nav.scrolled{
    padding:14px 6%;
    background:rgba(10,13,16,.78);
    backdrop-filter:blur(16px);
    border-bottom:1px solid var(--line);
}
.nav-logo{
    font-family:'Playfair Display', serif;
    font-size:24px;
    font-weight:700;
    color:#fff;
    letter-spacing:.02em;
    display:flex;
    align-items:center;
    gap:10px;
}
.nav-logo span{ color:var(--gold); }
.nav-links{
    display:flex;
    align-items:center;
    gap:38px;
}
.nav-links a{
    color:#dfe4e8;
    text-decoration:none;
    font-size:14.5px;
    font-weight:500;
    letter-spacing:.02em;
    position:relative;
    padding-bottom:4px;
}
.nav-links a:not(.nav-cta)::after{
    content:'';
    position:absolute;
    bottom:0; left:0;
    width:0%;
    height:1px;
    background:var(--gold);
    transition:.3s;
}
.nav-links a:not(.nav-cta):hover::after{ width:100%; }
.nav-cta{
    border:1px solid var(--gold);
    color:var(--gold-bright) !important;
    padding:10px 24px;
    border-radius:2px;
    transition:.3s;
}
.nav-cta:hover{
    background:var(--gold);
    color:var(--ink) !important;
}
@media (max-width:900px){
    .nav-links{ display:none; }
}

/* ================= HERO ================= */
.hero{
    position:relative;
    height:100vh;
    min-height:720px;
    display:flex;
    align-items:center;
    overflow:hidden;
}
.hero video, .hero .hero-fallback{
    position:absolute;
    inset:0;
    width:100%;
    height:100%;
    object-fit:cover;
    filter:saturate(1.05) contrast(1.05);
}
.hero::before{
    content:'';
    position:absolute;
    inset:0;
    background:
        linear-gradient(180deg, rgba(6,8,10,.55) 0%, rgba(6,8,10,.35) 35%, rgba(6,8,10,.75) 78%, #0a0d10 100%),
        linear-gradient(90deg, rgba(6,8,10,.65) 0%, rgba(6,8,10,.05) 55%);
    z-index:1;
}
.hero-inner{
    position:relative;
    z-index:2;
    width:100%;
    padding:0 6%;
}
.eyebrow{
    display:inline-flex;
    align-items:center;
    gap:10px;
    color:var(--gold-bright);
    font-size:12.5px;
    font-weight:700;
    letter-spacing:.35em;
    text-transform:uppercase;
    margin-bottom:26px;
    opacity:0;
    animation:riseIn .9s ease forwards;
    animation-delay:.2s;
}
.eyebrow::before{
    content:'';
    width:40px; height:1px;
    background:var(--gold);
    display:inline-block;
}
.hero h1{
    font-size:clamp(42px, 6.4vw, 92px);
    line-height:1.04;
    font-weight:700;
    color:#fff;
    max-width:950px;
}
.hero h1 .line{
    display:block;
    overflow:hidden;
}
.hero h1 .line span{
    display:inline-block;
    opacity:0;
    transform:translateY(110%);
    animation:riseIn .9s cubic-bezier(.2,.8,.2,1) forwards;
}
.hero h1 .line:nth-child(1) span{ animation-delay:.35s; }
.hero h1 .line:nth-child(2) span{ animation-delay:.5s; color:var(--gold-bright); font-style:italic; }

@keyframes riseIn{
    to{ opacity:1; transform:translateY(0); }
}

.hero p.sub{
    max-width:560px;
    margin-top:26px;
    color:#cfd6db;
    font-size:17.5px;
    line-height:1.75;
    font-weight:300;
    opacity:0;
    animation:riseIn .9s ease forwards;
    animation-delay:.7s;
}
.hero-cta-row{
    margin-top:44px;
    display:flex;
    gap:18px;
    align-items:center;
    opacity:0;
    animation:riseIn .9s ease forwards;
    animation-delay:.85s;
}
.btn-solid{
    background:var(--gold);
    color:#100c02;
    font-weight:700;
    font-size:14.5px;
    letter-spacing:.03em;
    padding:17px 34px;
    text-decoration:none;
    border-radius:2px;
    position:relative;
    overflow:hidden;
    transition:.35s;
}
.btn-solid:hover{ background:var(--gold-bright); transform:translateY(-2px); }
.btn-ghost{
    color:#fff;
    text-decoration:none;
    font-weight:600;
    font-size:14.5px;
    display:flex;
    align-items:center;
    gap:10px;
    border-bottom:1px solid rgba(255,255,255,.35);
    padding-bottom:5px;
    transition:.3s;
}
.btn-ghost i{
    width:38px; height:38px;
    border:1px solid rgba(255,255,255,.35);
    border-radius:50%;
    display:flex; align-items:center; justify-content:center;
    transition:.3s;
}
.btn-ghost:hover i{ background:#fff; color:var(--ink); transform:translateX(4px); }

.hero-scroll{
    position:absolute;
    bottom:38px;
    left:6%;
    z-index:2;
    display:flex;
    align-items:center;
    gap:14px;
    color:#c7cdd2;
    font-size:12px;
    letter-spacing:.2em;
    text-transform:uppercase;
}
.hero-scroll .bar{
    width:1px; height:46px;
    background:rgba(255,255,255,.25);
    position:relative;
    overflow:hidden;
}
.hero-scroll .bar::after{
    content:'';
    position:absolute;
    top:-40%; left:0; width:100%; height:40%;
    background:var(--gold-bright);
    animation:scrollLine 1.8s ease-in-out infinite;
}
@keyframes scrollLine{
    0%{ top:-40%; }
    100%{ top:100%; }
}

/* marquee ticker */
.ticker-wrap{
    position:absolute;
    bottom:0; left:0; right:0;
    z-index:3;
    background:rgba(10,13,16,.55);
    backdrop-filter:blur(6px);
    border-top:1px solid var(--line);
    overflow:hidden;
    white-space:nowrap;
    padding:14px 0;
}
.ticker{
    display:inline-block;
    animation:scrollTicker 28s linear infinite;
}
.ticker span{
    display:inline-block;
    padding:0 30px;
    font-size:13px;
    letter-spacing:.25em;
    text-transform:uppercase;
    color:#aeb7bd;
}
.ticker span i{ color:var(--gold); margin-right:14px; }
@keyframes scrollTicker{
    0%{ transform:translateX(0); }
    100%{ transform:translateX(-50%); }
}

/* ================= STAT STRIP ================= */
.stats-strip{
    position:relative;
    z-index:5;
    max-width:1180px;
    margin:-52px auto 0;
    background:var(--panel);
    border:1px solid var(--line);
    border-radius:6px;
    display:grid;
    grid-template-columns:repeat(4,1fr);
    box-shadow:0 30px 70px rgba(0,0,0,.5);
}
.stat{
    padding:30px 20px;
    text-align:center;
    border-right:1px solid var(--line);
}
.stat:last-child{ border-right:none; }
.stat h3{
    font-size:32px;
    color:var(--gold-bright);
    font-weight:700;
}
.stat p{
    color:var(--muted);
    font-size:12.5px;
    text-transform:uppercase;
    letter-spacing:.15em;
    margin-top:6px;
}
@media (max-width:800px){
    .stats-strip{ grid-template-columns:repeat(2,1fr); margin-top:0; }
    .stat{ border-bottom:1px solid var(--line); }
}

/* ================= SECTION HEADERS ================= */
.section{ padding:130px 6% 60px; max-width:1400px; margin:0 auto; }
.section.tight{ padding-top:90px; }
.sec-head{
    display:flex;
    justify-content:space-between;
    align-items:flex-end;
    margin-bottom:60px;
    flex-wrap:wrap;
    gap:20px;
}
.sec-eyebrow{
    color:var(--gold);
    font-size:12.5px;
    font-weight:700;
    letter-spacing:.3em;
    text-transform:uppercase;
}
.sec-head h2{
    font-size:clamp(30px,4vw,50px);
    color:#fff;
    margin-top:14px;
    max-width:600px;
}
.sec-head p{
    max-width:380px;
    color:var(--muted);
    font-size:15px;
    line-height:1.7;
}

.reveal{
    opacity:0;
    transform:translateY(40px);
    transition:opacity .8s ease, transform .8s ease;
}
.reveal.in{
    opacity:1;
    transform:translateY(0);
}

/* ================= PACKAGE CARDS ================= */
.pkg-grid{
    display:grid;
    grid-template-columns:repeat(3,1fr);
    gap:34px;
}
@media (max-width:1100px){ .pkg-grid{ grid-template-columns:repeat(2,1fr);} }
@media (max-width:680px){ .pkg-grid{ grid-template-columns:1fr;} }

.pkg-card{
    position:relative;
    border-radius:6px;
    overflow:hidden;
    height:460px;
    border:1px solid var(--line);
    background:var(--panel);
}
.pkg-card .ph{
    position:absolute; inset:0;
    background-size:cover;
    background-position:center;
    transition:transform 1.1s cubic-bezier(.2,.8,.2,1);
    transform:scale(1.06);
}
.pkg-card:hover .ph{ transform:scale(1.16); }
.pkg-card::after{
    content:'';
    position:absolute; inset:0;
    background:linear-gradient(180deg, rgba(10,13,16,0) 0%, rgba(10,13,16,.35) 45%, rgba(8,10,12,.96) 100%);
}
.pkg-days{
    position:absolute;
    top:22px; right:22px;
    z-index:3;
    background:rgba(10,13,16,.65);
    backdrop-filter:blur(4px);
    border:1px solid rgba(255,255,255,.25);
    color:#fff;
    font-size:12px;
    letter-spacing:.1em;
    padding:8px 14px;
    border-radius:2px;
    text-transform:uppercase;
}
.pkg-body{
    position:absolute;
    left:0; right:0; bottom:0;
    z-index:3;
    padding:30px 28px;
}
.pkg-city{
    color:var(--gold-bright);
    font-size:12px;
    letter-spacing:.2em;
    text-transform:uppercase;
    font-weight:700;
    margin-bottom:8px;
    display:block;
}
.pkg-body h3{
    color:#fff;
    font-size:25px;
    margin-bottom:10px;
}
.pkg-body p{
    color:#c3cad0;
    font-size:13.8px;
    line-height:1.6;
    margin-bottom:20px;
    max-height:0;
    opacity:0;
    overflow:hidden;
    transition:.4s;
}
.pkg-card:hover .pkg-body p{
    max-height:90px;
    opacity:1;
}
.pkg-foot{
    display:flex;
    align-items:center;
    justify-content:space-between;
    border-top:1px solid rgba(255,255,255,.14);
    padding-top:16px;
}
.pkg-price{
    color:#fff;
    font-size:22px;
    font-weight:700;
}
.pkg-price small{
    display:block;
    color:var(--muted);
    font-size:11px;
    font-weight:400;
    letter-spacing:.1em;
    text-transform:uppercase;
}
.pkg-arrow{
    width:44px; height:44px;
    border:1px solid var(--gold);
    border-radius:50%;
    display:flex; align-items:center; justify-content:center;
    color:var(--gold-bright);
    background:transparent;
    cursor:pointer;
    transition:.3s;
}
.pkg-card:hover .pkg-arrow{
    background:var(--gold);
    color:#0a0d10;
    transform:rotate(45deg);
}

/* ================= MOSAIC ================= */
.mosaic{
    display:grid;
    grid-template-columns:repeat(4, 1fr);
    grid-auto-rows:150px;
    gap:14px;
}
.mosaic a{
    position:relative;
    display:block;
    border-radius:4px;
    overflow:hidden;
    text-decoration:none;
}
.mosaic a img{
    width:100%; height:100%;
    object-fit:cover;
    transition:transform .8s;
}
.mosaic a:hover img{ transform:scale(1.12); }
.mosaic a::after{
    content:'';
    position:absolute; inset:0;
    background:linear-gradient(180deg, rgba(0,0,0,0) 40%, rgba(0,0,0,.82) 100%);
}
.mosaic a .lbl{
    position:absolute; left:14px; bottom:12px; z-index:2;
    color:#fff; font-size:14px; font-weight:700;
    letter-spacing:.03em;
}
.mosaic a:nth-child(1){ grid-column:span 2; grid-row:span 2; }
.mosaic a:nth-child(4){ grid-row:span 2; }
.mosaic a:nth-child(6){ grid-column:span 2; }
@media (max-width:900px){
    .mosaic{ grid-template-columns:repeat(2,1fr); }
    .mosaic a:nth-child(1){ grid-column:span 2; grid-row:span 1; }
    .mosaic a:nth-child(4){ grid-row:span 1; }
    .mosaic a:nth-child(6){ grid-column:span 1; }
}

/* ================= TESTIMONIALS ================= */
.testi-wrap{
    background:var(--panel);
    border:1px solid var(--line);
    border-radius:6px;
    padding:70px 6%;
    display:grid;
    grid-template-columns:repeat(3,1fr);
    gap:40px;
}
@media (max-width:900px){ .testi-wrap{ grid-template-columns:1fr; } }
.testi{
    padding-right:30px;
    border-right:1px solid var(--line);
}
.testi:last-child{ border-right:none; padding-right:0; }
.testi .stars{ color:var(--gold); margin-bottom:18px; letter-spacing:3px; }
.testi p{
    color:#d7dde1;
    font-size:15px;
    line-height:1.8;
    font-style:italic;
    margin-bottom:22px;
}
.testi .who{
    display:flex; align-items:center; gap:12px;
}
.testi .avatar{
    width:42px; height:42px;
    border-radius:50%;
    background:linear-gradient(135deg,var(--gold),#7a5a17);
    display:flex; align-items:center; justify-content:center;
    color:#100c02; font-weight:800; font-family:'Playfair Display',serif;
}
.testi .who h4{ color:#fff; font-size:14.5px; font-family:'Manrope'; font-weight:700; }
.testi .who span{ color:var(--muted); font-size:12.5px; }

/* ================= CTA BAND ================= */
.cta-band{
    margin:130px 6% 0;
    max-width:1400px;
    margin-left:auto; margin-right:auto;
    border-radius:8px;
    background:
        linear-gradient(120deg, rgba(10,13,16,.86), rgba(10,13,16,.55)),
        url('images/m1k.jpg') center/cover;
    padding:90px 8%;
    text-align:center;
    border:1px solid var(--line);
}
.cta-band h2{
    color:#fff;
    font-size:clamp(28px,4vw,46px);
    max-width:720px;
    margin:0 auto 22px;
}
.cta-band p{
    color:#cbd2d7;
    max-width:520px;
    margin:0 auto 36px;
    font-size:15.5px;
}

footer.site-footer{
    margin-top:110px;
    background:#07090b;
    border-top:1px solid var(--line);
    color:#9aa4ab;
}
footer.site-footer .foot-grid{
    max-width:1400px;
    margin:0 auto;
    padding:70px 6% 30px;
    display:grid;
    grid-template-columns:1.4fr 1fr 1fr 1fr;
    gap:40px;
}
footer.site-footer h4{
    color:#fff;
    font-family:'Playfair Display',serif;
    font-size:20px;
    margin-bottom:18px;
}
footer.site-footer a{
    color:#9aa4ab;
    text-decoration:none;
    display:block;
    margin-bottom:10px;
    font-size:14px;
    transition:.2s;
}
footer.site-footer a:hover{ color:var(--gold-bright); }
footer.site-footer .bottom{
    border-top:1px solid var(--line);
    text-align:center;
    padding:24px 6%;
    font-size:13px;
}
@media (max-width:900px){
    footer.site-footer .foot-grid{ grid-template-columns:1fr 1fr; }
}

</style>

</head>

<body>

<!-- ================= NAV ================= -->
<nav class="nav" id="mainNav">
    <div class="nav-logo"><span>&#9670;</span>&nbsp;DCL&nbsp;Tours</div>
    <div class="nav-links">
        <a href="#top">Home</a>
        <a href="#packages">Journeys</a>
        <a href="#destinations">Destinations</a>
        <a href="#testimonials">Stories</a>
        <a href="login.jsp" class="nav-cta">Sign In</a>
    </div>
</nav>

<!-- ================= HERO ================= -->
<section class="hero" id="top">

    <video autoplay muted loop playsinline
        poster="https://assets.mixkit.co/active_storage/video_items/100415/1724198576/100415-video-thumb-720-0.jpg">
        <source src="https://assets.mixkit.co/active_storage/video_items/100415/1724198576/100415-video-720.mp4" type="video/mp4">
        <source src="https://assets.mixkit.co/videos/1564/1564-720.mp4" type="video/mp4">
    </video>

    <div class="hero-inner">
        <span class="eyebrow">South India &bull; Curated Journeys</span>

        <h1>
            <span class="line"><span>Where the Ghats</span></span>
            <span class="line"><span>meet the horizon.</span></span>
        </h1>

        <p class="sub">
            Six unforgettable regions. Misted tea hills, sunlit shores, royal
            courtyards and ancient stone &mdash; handcrafted itineraries built
            around how you actually want to travel.
        </p>

        <div class="hero-cta-row">
            <a href="#packages" class="btn-solid">Explore Journeys</a>
            <a href="login.jsp" class="btn-ghost">Sign In <i class="fa-solid fa-arrow-right"></i></a>
        </div>
    </div>

    <div class="hero-scroll">
        <div class="bar"></div>
        Scroll
    </div>

    <div class="ticker-wrap">
        <div class="ticker">
            <span><i class="fa-solid fa-mountain-sun"></i>Munnar</span>
            <span><i class="fa-solid fa-umbrella-beach"></i>Goa</span>
            <span><i class="fa-solid fa-mug-hot"></i>Coorg</span>
            <span><i class="fa-solid fa-landmark"></i>Hampi</span>
            <span><i class="fa-solid fa-water"></i>Kochi</span>
            <span><i class="fa-solid fa-chess-rook"></i>Mysore</span>
            <span><i class="fa-solid fa-mountain-sun"></i>Munnar</span>
            <span><i class="fa-solid fa-umbrella-beach"></i>Goa</span>
            <span><i class="fa-solid fa-mug-hot"></i>Coorg</span>
            <span><i class="fa-solid fa-landmark"></i>Hampi</span>
            <span><i class="fa-solid fa-water"></i>Kochi</span>
            <span><i class="fa-solid fa-chess-rook"></i>Mysore</span>
        </div>
    </div>

</section>

<%
    String logoutSuccess = (String) request.getAttribute("logoutSuccess");
%>

<!-- ================= STAT STRIP ================= -->
<div class="stats-strip reveal">
    <div class="stat"><h3>6</h3><p>Regions Covered</p></div>
    <div class="stat"><h3>30+</h3><p>Curated Locations</p></div>
    <div class="stat"><h3>4.8&#9733;</h3><p>Traveler Rating</p></div>
    <div class="stat"><h3>24/7</h3><p>Trip Support</p></div>
</div>

<% if (logoutSuccess != null) { %>
<div style="max-width:900px;margin:30px auto 0;padding:14px 20px;border-radius:6px;background:#12261d;color:#8fe3b5;text-align:center;font-weight:600;">
    <%=logoutSuccess%>
</div>
<% } %>

<!-- ================= PACKAGES ================= -->
<section class="section" id="packages">
    <div class="sec-head reveal">
        <div>
            <span class="sec-eyebrow">Handpicked</span>
            <h2>Signature Journeys</h2>
        </div>
        <p>Every itinerary is built around a region's real character &mdash; not a generic checklist of stops.</p>
    </div>

    <div class="pkg-grid">
<%
    PackageDAO pdao = new PackageDAOImpl();
    List<Package> packages = pdao.getAllPackage();

    LocationDAO ldao = new LocationDAOImpl();
    List<Location> allLocations = ldao.getAllLocation();

    for (Package p : packages) {

        Location cover = null;

        for (Location l : allLocations) {
            if (l.getPid() != null && l.getPid().equals(p.getPid())) {
                cover = l;
                break;
            }
        }

        if (cover == null) {
            continue;
        }

        String shortDesc = cover.getDescription();
        if (shortDesc != null && shortDesc.length() > 110) {
            shortDesc = shortDesc.substring(0, 110) + "&hellip;";
        }
%>
        <div class="pkg-card reveal">
            <div class="ph" style="background-image:url('<%=request.getContextPath()%>/<%=cover.getImage_path()%>');"></div>
            <span class="pkg-days"><%=p.getNo_of_days()%> Days</span>

            <div class="pkg-body">
                <span class="pkg-city"><%=cover.getCity_name()%></span>
                <h3><%=p.getPname()%></h3>
                <p><%=shortDesc%></p>

                <div class="pkg-foot">
                    <div class="pkg-price">&#8377;<%=String.format("%.0f", p.getPrice())%><small>Per Person</small></div>

                    <form action="location.jsp" method="post">
                        <input type="hidden" name="package_id" value="<%=p.getPid()%>">
                        <button type="submit" class="pkg-arrow"><i class="fa-solid fa-arrow-up-right"></i></button>
                    </form>
                </div>
            </div>
        </div>
<%
    }
%>
    </div>
</section>

<!-- ================= DESTINATION MOSAIC ================= -->
<section class="section tight" id="destinations">
    <div class="sec-head reveal">
        <div>
            <span class="sec-eyebrow">Explore</span>
            <h2>Destinations at a Glance</h2>
        </div>
        <p>From the Western Ghats to the Arabian Sea coastline &mdash; a glimpse of what's waiting.</p>
    </div>

    <div class="mosaic reveal">
        <a href="#packages"><img src="<%=request.getContextPath()%>/images/m1k.jpg" alt="Munnar"><span class="lbl">Munnar</span></a>
        <a href="#packages"><img src="<%=request.getContextPath()%>/images/b3g.jpg" alt="Goa"><span class="lbl">Goa</span></a>
        <a href="#packages"><img src="<%=request.getContextPath()%>/images/c1k.jpg" alt="Coorg"><span class="lbl">Coorg</span></a>
        <a href="#packages"><img src="<%=request.getContextPath()%>/images/h1k.jpg" alt="Hampi"><span class="lbl">Hampi</span></a>
        <a href="#packages"><img src="<%=request.getContextPath()%>/images/k5k.jpg" alt="Kochi"><span class="lbl">Kochi</span></a>
        <a href="#packages"><img src="<%=request.getContextPath()%>/images/a1m.jpg" alt="Mysore"><span class="lbl">Mysore</span></a>
    </div>
</section>

<!-- ================= TESTIMONIALS ================= -->
<section class="section" id="testimonials">
    <div class="sec-head reveal">
        <div>
            <span class="sec-eyebrow">Traveler Stories</span>
            <h2>What Guests Are Saying</h2>
        </div>
    </div>

    <div class="testi-wrap reveal">

        <div class="testi">
            <div class="stars">&#9733;&#9733;&#9733;&#9733;&#9733;</div>
            <p>"The Munnar itinerary felt personal, not packaged. Every stop had a reason to be there."</p>
            <div class="who">
                <div class="avatar">A</div>
                <div><h4>Sagar S.</h4><span>Bengaluru</span></div>
            </div>
        </div>

        <div class="testi">
            <div class="stars">&#9733;&#9733;&#9733;&#9733;&#9733;</div>
            <p>"Hampi at sunrise, exactly as promised. Booking and support were effortless end to end."</p>
            <div class="who">
                <div class="avatar">S</div>
                <div><h4>Punith B.</h4><span>Hyderabad</span></div>
            </div>
        </div>

        <div class="testi">
            <div class="stars">&#9733;&#9733;&#9733;&#9733;&#9734;</div>
            <p>"Coastal Charms in Kochi was the highlight of our year. Already planning the next trip."</p>
            <div class="who">
                <div class="avatar">R</div>
                <div><h4>Kiran.</h4><span>Chennai</span></div>
            </div>
        </div>

    </div>
</section>

<!-- ================= CTA BAND ================= -->
<div class="cta-band reveal" style="background: linear-gradient(120deg, rgba(10,13,16,.86), rgba(10,13,16,.55)), url('<%=request.getContextPath()%>/images/m1k.jpg') center/cover;">
    <h2>Your next journey is one click away.</h2>
    <p>Create an account, pick a region, and let the itinerary do the rest.</p>
    <a href="login.jsp" class="btn-solid">Get Started</a>
</div>

<!-- ================= FOOTER ================= -->
<footer class="site-footer">
    <div class="foot-grid">
        <div>
            <h4>DCL Tours</h4>
            <p style="max-width:280px; line-height:1.7; font-size:14px;">
                Curated travel across South India &mdash; mountains, coastlines,
                heritage and everything between.
            </p>
        </div>
        <div>
            <h4>Explore</h4>
            <a href="#top">Home</a>
            <a href="#packages">Journeys</a>
            <a href="#destinations">Destinations</a>
        </div>
        <div>
            <h4>Regions</h4>
            <a href="#packages">Munnar</a>
            <a href="#packages">Goa</a>
            <a href="#packages">Coorg</a>
            <a href="#packages">Hampi</a>
        </div>
        <div>
            <h4>Contact</h4>
            <a href="#">info@dcltours.com</a>
            <a href="#">+91 98765 43210</a>
            <a href="login.jsp">Sign In</a>
        </div>
    </div>
    <div class="bottom">&copy; 2026 DCL Tours. All Rights Reserved.</div>
</footer>

<script>
// navbar shrink/blur on scroll
const nav = document.getElementById('mainNav');
window.addEventListener('scroll', function(){
    if (window.scrollY > 40) {
        nav.classList.add('scrolled');
    } else {
        nav.classList.remove('scrolled');
    }
});

// scroll-reveal
const revealEls = document.querySelectorAll('.reveal');
const io = new IntersectionObserver(function(entries){
    entries.forEach(function(entry){
        if (entry.isIntersecting) {
            entry.target.classList.add('in');
            io.unobserve(entry.target);
        }
    });
}, { threshold: 0.15 });
revealEls.forEach(function(el){ io.observe(el); });
</script>

</body>
</html>
