<?php
/**
 * register.php — User Registration
 * Lost & Found Campus System
 */
session_start();
require_once 'db.php';

$error   = '';
$success = '';

// If already logged in, go to dashboard
if (isset($_SESSION['user_id'])) {
    header('Location: dashboard.php');
    exit;
}

// Handle form submission
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $username = trim(mysqli_real_escape_string($conn, $_POST['username']));
    $password = trim($_POST['password']);
    $confirm  = trim($_POST['confirm_password']);

    // Basic server-side validation
    if (empty($username) || empty($password) || empty($confirm)) {
        $error = 'All fields are required.';
    } elseif (strlen($username) < 3) {
        $error = 'Username must be at least 3 characters.';
    } elseif ($password !== $confirm) {
        $error = 'Passwords do not match.';
    } elseif (strlen($password) < 6) {
        $error = 'Password must be at least 6 characters.';
    } else {
        // Check if username already exists
        $check = mysqli_query($conn, "SELECT id FROM users WHERE username = '$username'");
        if (mysqli_num_rows($check) > 0) {
            $error = 'Username already taken. Please choose another.';
        } else {
            // Hash password and insert user
            $hashed = password_hash($password, PASSWORD_DEFAULT);
            $sql = "INSERT INTO users (username, password) VALUES ('$username', '$hashed')";
            if (mysqli_query($conn, $sql)) {
                $success = 'Account created successfully! You can now log in.';
            } else {
                $error = 'Registration failed. Please try again.';
            }
        }
    }
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Register — CampusFind</title>
  <link rel="stylesheet" href="css/style.css">
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
</head>
<body class="bg-campus">

  <!-- Navbar -->
  <header class="navbar">
    <div class="logo">🔍 <span>Campus</span>Find</div>
    <nav>
      <a href="index.php">Home</a>
      <a href="login.php">Login</a>
      <a href="register.php" class="active">Register</a>
    </nav>
  </header>

  <!-- Auth Wrapper -->
  <div class="auth-wrapper">
    <div class="auth-card fade-in">

      <h2>Create Account</h2>
      <p class="subtitle">Join CampusFind and start reporting items</p>

      <!-- Flash Messages -->
      <?php if ($error): ?>
        <div class="alert alert-error">⚠️ <?= htmlspecialchars($error) ?></div>
      <?php endif; ?>
      <?php if ($success): ?>
        <div class="alert alert-success">✅ <?= htmlspecialchars($success) ?>
          <a href="login.php" style="margin-left:8px;font-weight:700;color:inherit;">Login →</a>
        </div>
      <?php endif; ?>

      <!-- Registration Form -->
      <form id="registerForm" action="register.php" method="POST"
            onsubmit="return validateForm('registerForm')">

        <div class="form-group">
          <label for="username">Username</label>
          <input type="text" id="username" name="username"
                 placeholder="e.g. john_doe" required
                 value="<?= isset($_POST['username']) ? htmlspecialchars($_POST['username']) : '' ?>">
        </div>

        <div class="form-group">
          <label for="password">Password</label>
          <input type="password" id="password" name="password"
                 placeholder="Min 6 characters" required>
        </div>

        <div class="form-group">
          <label for="confirm_password">Confirm Password</label>
          <input type="password" id="confirm_password" name="confirm_password"
                 placeholder="Repeat password" required>
        </div>

        <button type="submit" class="btn btn-primary btn-full">
          Create Account
        </button>
      </form>

      <div class="form-footer">
        Already have an account? <a href="login.php">Login here</a>
      </div>

    </div>
  </div>

  <script src="js/script.js"></script>
</body>
</html>
