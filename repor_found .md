<?php
session_start(); require_once 'db.php';
if(!isset($_SESSION['user_id'])){header('Location:login.php');exit;}
$uid=$_SESSION['user_id']; $success=$error=''; $current_page='found';
if($_SERVER['REQUEST_METHOD']==='POST'){
  $n=trim(mysqli_real_escape_string($conn,$_POST['item_name']));
  $d=trim(mysqli_real_escape_string($conn,$_POST['description']));
  $l=trim(mysqli_real_escape_string($conn,$_POST['location']));
  $dt=trim(mysqli_real_escape_string($conn,$_POST['date']));
  if(empty($n)||empty($d)||empty($l)||empty($dt)){$error='All fields are required.';}
  else{
    if(mysqli_query($conn,"INSERT INTO found_items(user_id,item_name,description,location,date)VALUES($uid,'$n','$d','$l','$dt')")){
      $success="Found item \"$n\" reported! Check dashboard for matches.";
    }else{$error='Failed to save. Try again.';}
  }
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1.0">
  <title>Report Found — CampusFind</title>
  <link rel="stylesheet" href="css/style.css">
  <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
</head>
<body>
<div class="app-layout">
  <?php include 'sidebar.php'; ?>
  <div class="main-content">
    <div class="topbar">
      <div class="topbar-left"><h1>Report Found Item</h1><p>Help someone get their item back!</p></div>
      <div class="topbar-right"><a href="dashboard.php" class="btn btn-sm btn-white">← Dashboard</a></div>
    </div>
    <div class="page-body">
      <div class="report-page-wrap">
        <?php if($success):?><div class="alert alert-ok">✅ <?=htmlspecialchars($success)?> <a href="dashboard.php" style="font-weight:700">View →</a></div><?php endif;?>
        <?php if($error):  ?><div class="alert alert-err">⚠️ <?=htmlspecialchars($error)?></div><?php endif;?>
        <div class="form-card">
          <form id="ff" action="report_found.php" method="POST" onsubmit="return validateForm('ff')">
            <div class="field">
              <label>Item Name *</label>
              <input type="text" id="item_name" name="item_name" required
                     placeholder="e.g. Black Umbrella, Student ID, Water Bottle"
                     value="<?=htmlspecialchars($_POST['item_name']??'')?>">
            </div>
            <div class="field">
              <label>Description *</label>
              <textarea id="description" name="description" required
                        placeholder="Color, brand, condition..."><?=htmlspecialchars($_POST['description']??'')?></textarea>
            </div>
            <div class="field">
              <label>Found Location *</label>
              <input type="text" id="location" name="location" required
                     placeholder="e.g. Library, Cafeteria, Parking Lot, Block B"
                     value="<?=htmlspecialchars($_POST['location']??'')?>">
            </div>
            <div class="field">
              <label>Date Found *</label>
              <input type="date" id="date" name="date" required
                     max="<?=date('Y-m-d')?>"
                     value="<?=htmlspecialchars($_POST['date']??date('Y-m-d'))?>">
            </div>
            <div style="display:flex;gap:10px;flex-wrap:wrap;margin-top:8px;">
              <button type="submit" class="btn btn-green">📦 Submit Found Report</button>
              <a href="dashboard.php" class="btn btn-white">Cancel</a>
            </div>
          </form>
        </div>
        <div class="tip-box" style="background:var(--green-lt);border-color:rgba(34,197,94,0.3);color:#166534;">
          <span>🙏</span>
          <span><strong>Thank you!</strong> Reporting found items helps students reunite with their belongings.</span>
        </div>
      </div>
    </div>
    <footer class="app-footer">© <?=date('Y')?> CampusFind</footer>
  </div>
</div>
<script src="js/script.js"></script>
</body>
</html>
