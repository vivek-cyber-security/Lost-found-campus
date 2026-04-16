<?php
session_start(); require_once 'db.php';
if(isset($_SESSION['user_id'])){header('Location:dashboard.php');exit;}
$error='';
if($_SERVER['REQUEST_METHOD']==='POST'){
  $u=trim(mysqli_real_escape_string($conn,$_POST['username']));
  $p=trim($_POST['password']);
  if(empty($u)||empty($p)){$error='Both fields required.';}
  else{
    $r=mysqli_query($conn,"SELECT id,username,password,is_admin FROM users WHERE username='$u'");
    if($r&&mysqli_num_rows($r)===1){
      $row=mysqli_fetch_assoc($r);
      if(password_verify($p,$row['password'])){
        $_SESSION['user_id']=$row['id'];
        $_SESSION['username']=$row['username'];
        $_SESSION['is_admin']=(bool)$row['is_admin'];
        header('Location:dashboard.php');exit;
      }else{$error='Incorrect password.';}
    }else{$error='No account found with that username.';}
  }
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1.0">
  <title>Sign In — CampusFind</title>
  <link rel="stylesheet" href="css/style.css">
  <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
</head>
<body>
<canvas id="particle-canvas"></canvas>
<div class="public-page">
  <nav class="pub-nav">
    <div class="pub-logo">⬡ Campus<span class="dot">Find</span></div>
    <div class="pub-nav-links">
      <a href="index.php">Home</a>
      <a href="register.php" class="nav-cta">Register</a>
    </div>
  </nav>
  <div class="auth-center">
    <div class="auth-box">
      <div class="auth-icon">🔐</div>
      <h2>Welcome back</h2>
      <p class="auth-sub">Sign in to your CampusFind account</p>
      <?php if($error):?><div class="alert alert-err">⚠️ <?=htmlspecialchars($error)?></div><?php endif;?>
      <?php if(isset($_GET['reg'])):?><div class="alert alert-ok">✅ Account created! Please sign in.</div><?php endif;?>
      <form id="lf" action="login.php" method="POST" onsubmit="return validateForm('lf')">
        <div class="field">
          <label>Username</label>
          <input type="text" id="username" name="username" placeholder="Your username" required
                 value="<?=htmlspecialchars($_POST['username']??'')?>">
        </div>
        <div class="field">
          <label>Password</label>
          <input type="password" id="password" name="password" placeholder="Your password" required>
        </div>
        <button type="submit" class="btn btn-orange btn-full" style="margin-top:8px">Sign In</button>
      </form>
      <div class="form-link">No account? <a href="register.php">Create one free</a></div>
    </div>
  </div>
  <footer class="pub-footer">© <?=date('Y')?> CampusFind</footer>
</div>
<script src="js/script.js"></script>
</body>
</html>
