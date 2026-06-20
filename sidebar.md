<?php
/**
 * sidebar.php — Reusable Sidebar Component
 * Include this in all dashboard pages
 * Requires: $current_page variable set before including
 */
$cur = $current_page ?? '';
$uname = $_SESSION['username'] ?? 'User';
$initials = strtoupper(substr($uname,0,2));
$is_admin = !empty($_SESSION['is_admin']);

// Count badges
require_once __DIR__.'/db.php';
$lost_cnt  = mysqli_fetch_assoc(mysqli_query($conn,"SELECT COUNT(*) c FROM lost_items"))['c'];
$found_cnt = mysqli_fetch_assoc(mysqli_query($conn,"SELECT COUNT(*) c FROM found_items"))['c'];
?>
<aside class="sidebar">
  <!-- Logo -->
  <div class="sidebar-logo">
    <div class="logo-text">Campus<span>Find</span></div>
    <div class="logo-sub">Lost &amp; Found System</div>
  </div>

  <!-- User -->
  <div class="sidebar-user">
    <div class="sidebar-avatar"><?= $initials ?></div>
    <div class="sidebar-user-info">
      <div class="name"><?= htmlspecialchars($uname) ?></div>
      <div class="role"><?= $is_admin ? '⚙️ Administrator' : '🎓 Student' ?></div>
    </div>
  </div>

  <!-- Nav -->
  <nav class="sidebar-nav">
    <div class="sidebar-label">Main</div>

    <a href="dashboard.php" class="nav-item <?= $cur==='dashboard'?'active':'' ?>">
      <span class="nav-icon">📊</span> Dashboard
    </a>

    <div class="sidebar-label">Reports</div>

    <a href="report_lost.php" class="nav-item <?= $cur==='lost'?'active':'' ?>">
      <span class="nav-icon">😟</span> Report Lost
      <?php if($lost_cnt>0): ?><span class="nav-badge"><?= $lost_cnt ?></span><?php endif; ?>
    </a>

    <a href="report_found.php" class="nav-item <?= $cur==='found'?'active':'' ?>">
      <span class="nav-icon">😊</span> Report Found
      <?php if($found_cnt>0): ?><span class="nav-badge"><?= $found_cnt ?></span><?php endif; ?>
    </a>

    <?php if($is_admin): ?>
    <div class="sidebar-label">Admin</div>
    <a href="admin.php" class="nav-item <?= $cur==='admin'?'active':'' ?>">
      <span class="nav-icon">⚙️</span> Admin Panel
    </a>
    <?php endif; ?>
  </nav>

  <!-- Logout -->
  <div class="sidebar-footer">
    <a href="logout.php" class="nav-item" style="color:rgba(239,68,68,0.7);">
      <span class="nav-icon">🚪</span> Logout
    </a>
  </div>
</aside>
