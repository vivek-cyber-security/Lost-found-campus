<?php
session_start(); require_once 'db.php';
if(!isset($_SESSION['user_id'])){header('Location:login.php');exit;}
$uid=$_SESSION['user_id']; $uname=$_SESSION['username'];
$is_admin=!empty($_SESSION['is_admin']);

$total_lost  = mysqli_fetch_assoc(mysqli_query($conn,"SELECT COUNT(*) c FROM lost_items"))['c'];
$total_found = mysqli_fetch_assoc(mysqli_query($conn,"SELECT COUNT(*) c FROM found_items"))['c'];
$total_users = mysqli_fetch_assoc(mysqli_query($conn,"SELECT COUNT(*) c FROM users"))['c'];

$all_lost  = mysqli_query($conn,"SELECT l.*,u.username FROM lost_items l JOIN users u ON l.user_id=u.id ORDER BY l.created_at DESC LIMIT 20");
$all_found = mysqli_query($conn,"SELECT f.*,u.username FROM found_items f JOIN users u ON f.user_id=u.id ORDER BY f.created_at DESC LIMIT 20");

$greeting = date('H')<12?'Good Morning':( date('H')<18?'Good Afternoon':'Good Evening');
$current_page='dashboard';
?>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1.0">
  <title>Dashboard — CampusFind</title>
  <link rel="stylesheet" href="css/style.css">
  <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
</head>
<body>
<div class="app-layout">

  <?php include 'sidebar.php'; ?>

  <div class="main-content">
    <!-- Topbar -->
    <div class="topbar">
      <div class="topbar-left">
        <h1><?= $greeting ?>, <?= htmlspecialchars($uname) ?> 👋</h1>
        <p>Today is <?= date('l, d F Y') ?></p>
      </div>
      <div class="topbar-right">
        <a href="report_lost.php"  class="btn btn-sm btn-orange">+ Lost</a>
        <a href="report_found.php" class="btn btn-sm btn-green">+ Found</a>
        <?php if($is_admin):?><a href="admin.php" class="btn btn-sm btn-purple">⚙️ Admin</a><?php endif;?>
      </div>
    </div>

    <div class="page-body">

      <!-- Stats -->
      <div class="stats-row">
        <div class="stat-pill sp-red">
          <span class="sp-icon">😟</span>
          <div class="sp-num"><?= $total_lost ?></div>
          <div class="sp-label">Lost Items</div>
        </div>
        <div class="stat-pill sp-green">
          <span class="sp-icon">😊</span>
          <div class="sp-num"><?= $total_found ?></div>
          <div class="sp-label">Found Items</div>
        </div>
        <div class="stat-pill sp-blue">
          <span class="sp-icon">🔗</span>
          <div class="sp-num" id="stat-matches">—</div>
          <div class="sp-label">Matches Found</div>
        </div>
        <div class="stat-pill">
          <span class="sp-icon">👥</span>
          <div class="sp-num"><?= $total_users ?></div>
          <div class="sp-label">Students</div>
        </div>
      </div>

      <!-- MATCH BOARD (AJAX) -->
      <div class="match-board">
        <div class="match-board-hdr">
          <span class="live-dot"></span>
          <h2>Smart Match Results</h2>
          <span style="margin-left:auto;font-size:0.75rem;color:rgba(255,255,255,0.3);">
            via AJAX + XML &nbsp;
            <button onclick="loadMatches()" style="background:rgba(255,255,255,0.1);border:none;color:rgba(255,255,255,0.5);padding:3px 10px;border-radius:4px;font-size:0.72rem;cursor:pointer;font-family:Outfit,sans-serif;">🔄 Refresh</button>
          </span>
        </div>
        <!-- Matches rendered here by JS -->
        <div id="match-box">
          <div class="match-loading"><div class="spin-ring"></div><span>Loading...</span></div>
        </div>
      </div>

      <!-- Search -->
      <div class="search-wrap">
        <span class="search-icon">🔍</span>
        <input type="text" id="item-search" placeholder="Search all items by name, location, description...">
      </div>
      <div id="no-items-msg" style="display:none;" class="alert alert-inf">No items match your search.</div>

      <!-- LOST ITEMS -->
      <div class="sec-hdr">
        <h2>😟 Lost Items</h2>
        <span><?= $total_lost ?> total</span>
      </div>
      <div class="items-list">
        <?php if(mysqli_num_rows($all_lost)===0): ?>
          <div style="padding:20px;color:var(--text-3);font-size:0.88rem;text-align:center;">No lost items reported yet.</div>
        <?php else: ?>
        <?php while($item=mysqli_fetch_assoc($all_lost)): ?>
          <div class="item-row">
            <span class="ir-dot lost"></span>
            <span class="type-pill tp-lost">Lost</span>
            <div class="ir-body">
              <div class="ir-name"><?= htmlspecialchars($item['item_name']) ?></div>
              <div class="ir-desc"><?= htmlspecialchars($item['description']) ?></div>
            </div>
            <div class="ir-meta">
              <span class="ir-loc">📍 <?= htmlspecialchars($item['location']) ?></span>
              <span class="ir-date">📅 <?= htmlspecialchars($item['date']) ?></span>
              <span class="ir-user">by <?= htmlspecialchars($item['username']) ?></span>
            </div>
          </div>
        <?php endwhile; ?>
        <?php endif; ?>
      </div>

      <!-- FOUND ITEMS -->
      <div class="sec-hdr">
        <h2>😊 Found Items</h2>
        <span><?= $total_found ?> total</span>
      </div>
      <div class="items-list">
        <?php if(mysqli_num_rows($all_found)===0): ?>
          <div style="padding:20px;color:var(--text-3);font-size:0.88rem;text-align:center;">No found items reported yet.</div>
        <?php else: ?>
        <?php while($item=mysqli_fetch_assoc($all_found)): ?>
          <div class="item-row">
            <span class="ir-dot found"></span>
            <span class="type-pill tp-found">Found</span>
            <div class="ir-body">
              <div class="ir-name"><?= htmlspecialchars($item['item_name']) ?></div>
              <div class="ir-desc"><?= htmlspecialchars($item['description']) ?></div>
            </div>
            <div class="ir-meta">
              <span class="ir-loc">📍 <?= htmlspecialchars($item['location']) ?></span>
              <span class="ir-date">📅 <?= htmlspecialchars($item['date']) ?></span>
              <span class="ir-user">by <?= htmlspecialchars($item['username']) ?></span>
            </div>
          </div>
        <?php endwhile; ?>
        <?php endif; ?>
      </div>

    </div><!-- /page-body -->
    <footer class="app-footer">© <?=date('Y')?> CampusFind — MSc CA Project</footer>
  </div><!-- /main-content -->
</div>
<script src="js/script.js"></script>
</body>
</html>
