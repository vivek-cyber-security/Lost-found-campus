<?php
/**
 * index.php — Home / Landing Page
 * Lost & Found Campus System
 */
session_start();
?>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>CampusFind — Lost & Found System</title>
  <link rel="stylesheet" href="css/style.css">
  <!-- Poppins font -->
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
</head>
<body class="bg-campus">

  <!-- ===== NAVBAR ===== -->
  <header class="navbar">
    <div class="logo">
      🔍 <span>Campus</span>Find
    </div>
    <nav>
      <a href="index.php" class="active">Home</a>
      <?php if (isset($_SESSION['user_id'])): ?>
        <a href="dashboard.php">Dashboard</a>
        <a href="logout.php">Logout</a>
      <?php else: ?>
        <a href="login.php">Login</a>
        <a href="register.php">Register</a>
      <?php endif; ?>
    </nav>
  </header>

  <!-- ===== HERO SECTION ===== -->
  <section class="hero fade-in">
    <div class="hero-badge">🎓 Campus Lost & Found Portal</div>
    <h1>Lost Something on<br><span>Campus?</span> We'll Help!</h1>
    <p>
      Report lost or found items on your campus. Our smart matching system
      automatically pairs lost items with found ones — helping reunite students
      with their belongings faster.
    </p>
    <div class="hero-btns">
      <a href="report_lost.php" class="btn btn-primary">📋 Report Lost Item</a>
      <a href="report_found.php" class="btn btn-outline">📦 Report Found Item</a>
    </div>
  </section>

  <!-- ===== FEATURES SECTION ===== -->
  <section class="features">
    <h2>How It Works</h2>
    <p class="sub">Simple, fast, and smart — built for students.</p>
    <div class="features-grid">

      <div class="feature-card fade-in">
        <div class="feature-icon">📋</div>
        <h3>Report Your Loss</h3>
        <p>Fill in a quick form with item details, location, and date. Takes less than a minute.</p>
      </div>

      <div class="feature-card fade-in" style="animation-delay:0.1s">
        <div class="feature-icon">📦</div>
        <h3>Found Something?</h3>
        <p>Report it here and our system will look for a matching lost item automatically.</p>
      </div>

      <div class="feature-card fade-in" style="animation-delay:0.2s">
        <div class="feature-icon">🔗</div>
        <h3>Smart Matching</h3>
        <p>Our keyword-based engine compares item names and locations to find possible matches.</p>
      </div>

      <div class="feature-card fade-in" style="animation-delay:0.3s">
        <div class="feature-icon">🔔</div>
        <h3>Instant Alerts</h3>
        <p>Get notified on your dashboard the moment a potential match is detected.</p>
      </div>

    </div>
  </section>

  <!-- ===== CALL TO ACTION ===== -->
  <section style="text-align:center; padding:60px 20px;">
    <p style="color:rgba(255,255,255,0.7); font-size:1rem; margin-bottom:22px;">
      Join hundreds of students already using CampusFind
    </p>
    <?php if (!isset($_SESSION['user_id'])): ?>
      <a href="register.php" class="btn btn-accent">Get Started — It's Free</a>
    <?php else: ?>
      <a href="dashboard.php" class="btn btn-accent">Go to Dashboard</a>
    <?php endif; ?>
  </section>

  <!-- ===== FOOTER ===== -->
  <footer>
    <p>© <?= date('Y') ?> CampusFind — Lost & Found System &nbsp;|&nbsp; MCA Student Project</p>
  </footer>

  <script src="js/script.js"></script>
</body>
</html>
