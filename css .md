/* ============================================
   Lost & Found Campus System - style.css
   Author: Student Project
   ============================================ */

/* --- Google Fonts Import --- */
@import url('https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap');

/* --- CSS Variables --- */
:root {
  --primary:    #1a73e8;
  --primary-dk: #0d5bba;
  --accent:     #f4a261;
  --success:    #2ecc71;
  --danger:     #e74c3c;
  --warning:    #f39c12;
  --bg-card:    rgba(255, 255, 255, 0.95);
  --text-dark:  #1e1e2e;
  --text-mid:   #555;
  --text-light: #888;
  --radius:     12px;
  --shadow:     0 8px 32px rgba(0,0,0,0.12);
  --shadow-sm:  0 4px 16px rgba(0,0,0,0.08);
  --transition: all 0.3s ease;
}

/* --- Reset & Base --- */
*, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }

body {
  font-family: 'Poppins', sans-serif;
  color: var(--text-dark);
  min-height: 100vh;
}

a { text-decoration: none; color: inherit; }
ul { list-style: none; }
img { max-width: 100%; }

/* --- Background Pages (index, login, register) --- */
.bg-campus {
  background:
    linear-gradient(135deg, rgba(10,30,80,0.72) 0%, rgba(26,115,232,0.55) 100%),
    url('https://images.unsplash.com/photo-1523050854058-8df90110c9f1?w=1600&q=80') center/cover no-repeat fixed;
  min-height: 100vh;
}

/* --- Navbar --- */
.navbar {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 18px 40px;
  background: rgba(255,255,255,0.07);
  backdrop-filter: blur(12px);
  border-bottom: 1px solid rgba(255,255,255,0.12);
  position: sticky;
  top: 0;
  z-index: 100;
}

.navbar .logo {
  font-size: 1.4rem;
  font-weight: 700;
  color: #fff;
  display: flex;
  align-items: center;
  gap: 10px;
}

.navbar .logo span { color: var(--accent); }

.navbar nav a {
  color: rgba(255,255,255,0.85);
  margin-left: 28px;
  font-size: 0.92rem;
  font-weight: 500;
  transition: var(--transition);
  padding: 6px 0;
  border-bottom: 2px solid transparent;
}

.navbar nav a:hover,
.navbar nav a.active {
  color: #fff;
  border-bottom-color: var(--accent);
}

/* --- Dashboard Navbar (light) --- */
.navbar-light {
  background: #fff;
  border-bottom: 1px solid #e8eaf0;
  padding: 14px 40px;
  backdrop-filter: none;
  box-shadow: var(--shadow-sm);
}

.navbar-light .logo { color: var(--primary); }
.navbar-light nav a { color: var(--text-mid); }
.navbar-light nav a:hover { color: var(--primary); border-bottom-color: var(--primary); }

.navbar-light .nav-user {
  display: flex;
  align-items: center;
  gap: 14px;
}

.navbar-light .nav-user span {
  font-size: 0.88rem;
  color: var(--text-mid);
  font-weight: 500;
}

/* --- Hero Section (index) --- */
.hero {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  text-align: center;
  padding: 100px 20px 80px;
  color: #fff;
}

.hero-badge {
  display: inline-block;
  background: rgba(244,162,97,0.25);
  border: 1px solid rgba(244,162,97,0.5);
  color: var(--accent);
  font-size: 0.8rem;
  font-weight: 600;
  padding: 6px 18px;
  border-radius: 50px;
  letter-spacing: 1.5px;
  text-transform: uppercase;
  margin-bottom: 22px;
}

.hero h1 {
  font-size: clamp(2rem, 5vw, 3.6rem);
  font-weight: 700;
  line-height: 1.2;
  margin-bottom: 20px;
  text-shadow: 0 2px 20px rgba(0,0,0,0.3);
}

.hero h1 span { color: var(--accent); }

.hero p {
  font-size: 1.1rem;
  color: rgba(255,255,255,0.8);
  max-width: 560px;
  line-height: 1.7;
  margin-bottom: 40px;
}

.hero-btns {
  display: flex;
  gap: 16px;
  flex-wrap: wrap;
  justify-content: center;
}

/* --- Buttons --- */
.btn {
  display: inline-flex;
  align-items: center;
  gap: 8px;
  padding: 13px 32px;
  border-radius: 50px;
  font-size: 0.95rem;
  font-weight: 600;
  font-family: 'Poppins', sans-serif;
  cursor: pointer;
  border: none;
  transition: var(--transition);
}

.btn-primary {
  background: var(--primary);
  color: #fff;
  box-shadow: 0 4px 18px rgba(26,115,232,0.4);
}

.btn-primary:hover {
  background: var(--primary-dk);
  transform: translateY(-2px);
  box-shadow: 0 6px 24px rgba(26,115,232,0.5);
}

.btn-outline {
  background: transparent;
  color: #fff;
  border: 2px solid rgba(255,255,255,0.6);
}

.btn-outline:hover {
  background: rgba(255,255,255,0.12);
  border-color: #fff;
  transform: translateY(-2px);
}

.btn-accent {
  background: var(--accent);
  color: #fff;
  box-shadow: 0 4px 18px rgba(244,162,97,0.4);
}

.btn-accent:hover {
  background: #e07b38;
  transform: translateY(-2px) scale(1.03);
}

.btn-danger {
  background: var(--danger);
  color: #fff;
}

.btn-danger:hover { background: #c0392b; transform: scale(1.04); }

.btn-sm { padding: 8px 20px; font-size: 0.85rem; }
.btn-full { width: 100%; justify-content: center; }

/* --- Cards --- */
.card {
  background: var(--bg-card);
  border-radius: var(--radius);
  box-shadow: var(--shadow);
  padding: 32px;
  transition: var(--transition);
}

.card:hover { box-shadow: 0 12px 40px rgba(0,0,0,0.16); }

/* --- Auth Pages (login / register) --- */
.auth-wrapper {
  display: flex;
  align-items: center;
  justify-content: center;
  min-height: calc(100vh - 72px);
  padding: 40px 20px;
}

.auth-card {
  width: 100%;
  max-width: 440px;
  background: rgba(255,255,255,0.97);
  border-radius: 20px;
  box-shadow: 0 20px 60px rgba(0,0,0,0.3);
  padding: 44px 40px;
  animation: slideUp 0.5s ease;
}

.auth-card h2 {
  font-size: 1.8rem;
  font-weight: 700;
  color: var(--text-dark);
  margin-bottom: 6px;
}

.auth-card .subtitle {
  font-size: 0.9rem;
  color: var(--text-light);
  margin-bottom: 32px;
}

/* --- Forms --- */
.form-group {
  margin-bottom: 20px;
}

.form-group label {
  display: block;
  font-size: 0.85rem;
  font-weight: 600;
  color: var(--text-mid);
  margin-bottom: 8px;
  text-transform: uppercase;
  letter-spacing: 0.5px;
}

.form-group input,
.form-group textarea,
.form-group select {
  width: 100%;
  padding: 13px 16px;
  border: 2px solid #e8eaf0;
  border-radius: 10px;
  font-size: 0.95rem;
  font-family: 'Poppins', sans-serif;
  color: var(--text-dark);
  background: #fafbff;
  transition: var(--transition);
  outline: none;
}

.form-group input:focus,
.form-group textarea:focus,
.form-group select:focus {
  border-color: var(--primary);
  background: #fff;
  box-shadow: 0 0 0 4px rgba(26,115,232,0.1);
}

.form-group textarea { resize: vertical; min-height: 100px; }

.form-footer {
  text-align: center;
  margin-top: 22px;
  font-size: 0.88rem;
  color: var(--text-light);
}

.form-footer a { color: var(--primary); font-weight: 600; }

/* --- Stats Bar (dashboard) --- */
.stats-bar {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(180px, 1fr));
  gap: 20px;
  margin: 30px 0;
}

.stat-card {
  background: #fff;
  border-radius: var(--radius);
  padding: 22px 26px;
  box-shadow: var(--shadow-sm);
  display: flex;
  align-items: center;
  gap: 18px;
  transition: var(--transition);
  border-left: 4px solid var(--primary);
}

.stat-card:hover { transform: translateY(-3px); box-shadow: var(--shadow); }
.stat-card.lost-stat  { border-left-color: var(--danger); }
.stat-card.found-stat { border-left-color: var(--success); }
.stat-card.match-stat { border-left-color: var(--warning); }

.stat-icon {
  font-size: 2rem;
  width: 52px;
  height: 52px;
  display: flex;
  align-items: center;
  justify-content: center;
  border-radius: 12px;
  background: rgba(26,115,232,0.1);
}

.lost-stat  .stat-icon { background: rgba(231,76,60,0.1); }
.found-stat .stat-icon { background: rgba(46,204,113,0.1); }
.match-stat .stat-icon { background: rgba(243,156,18,0.1); }

.stat-info h3 { font-size: 1.7rem; font-weight: 700; color: var(--text-dark); }
.stat-info p  { font-size: 0.82rem; color: var(--text-light); margin-top: 2px; }

/* --- Dashboard Layout --- */
.dashboard-body {
  background: #f0f2f8;
  min-height: 100vh;
}

.dashboard-container {
  max-width: 1200px;
  margin: 0 auto;
  padding: 30px 24px;
}

.section-title {
  font-size: 1.2rem;
  font-weight: 700;
  color: var(--text-dark);
  margin-bottom: 18px;
  display: flex;
  align-items: center;
  gap: 10px;
}

.section-title::after {
  content: '';
  flex: 1;
  height: 2px;
  background: linear-gradient(to right, #e8eaf0, transparent);
  margin-left: 10px;
}

/* --- Items Grid --- */
.items-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
  gap: 20px;
  margin-bottom: 40px;
}

.item-card {
  background: #fff;
  border-radius: var(--radius);
  padding: 22px;
  box-shadow: var(--shadow-sm);
  transition: var(--transition);
  border-top: 4px solid var(--primary);
  position: relative;
  overflow: hidden;
}

.item-card::before {
  content: '';
  position: absolute;
  top: 0; left: 0; right: 0;
  height: 4px;
}

.item-card.lost-card  { border-top-color: var(--danger); }
.item-card.found-card { border-top-color: var(--success); }

.item-card:hover {
  transform: translateY(-4px);
  box-shadow: 0 10px 30px rgba(0,0,0,0.12);
}

.item-badge {
  display: inline-block;
  padding: 4px 12px;
  border-radius: 50px;
  font-size: 0.75rem;
  font-weight: 600;
  text-transform: uppercase;
  letter-spacing: 0.5px;
  margin-bottom: 12px;
}

.badge-lost  { background: rgba(231,76,60,0.12);  color: var(--danger); }
.badge-found { background: rgba(46,204,113,0.12); color: var(--success); }

.item-card h3 {
  font-size: 1.05rem;
  font-weight: 600;
  color: var(--text-dark);
  margin-bottom: 8px;
}

.item-card p {
  font-size: 0.87rem;
  color: var(--text-mid);
  line-height: 1.6;
  margin-bottom: 6px;
}

.item-meta {
  display: flex;
  gap: 14px;
  margin-top: 14px;
  padding-top: 14px;
  border-top: 1px solid #f0f2f8;
  font-size: 0.8rem;
  color: var(--text-light);
}

.item-meta span { display: flex; align-items: center; gap: 5px; }

/* --- Match Section --- */
.match-section {
  background: linear-gradient(135deg, #fff8ed, #fff3e0);
  border: 2px dashed var(--accent);
  border-radius: var(--radius);
  padding: 28px;
  margin-bottom: 40px;
}

.match-header {
  display: flex;
  align-items: center;
  gap: 12px;
  margin-bottom: 20px;
}

.match-header h2 { font-size: 1.2rem; color: var(--text-dark); font-weight: 700; }
.match-pulse {
  display: inline-block;
  width: 12px; height: 12px;
  background: var(--warning);
  border-radius: 50%;
  animation: pulse 1.5s ease infinite;
}

.match-card {
  background: #fff;
  border-radius: 10px;
  padding: 18px 22px;
  box-shadow: var(--shadow-sm);
  border-left: 4px solid var(--warning);
  margin-bottom: 14px;
  animation: slideUp 0.4s ease;
}

.match-card .match-title {
  font-weight: 600;
  font-size: 0.95rem;
  color: var(--text-dark);
  margin-bottom: 6px;
}

.match-card .match-detail {
  font-size: 0.85rem;
  color: var(--text-mid);
  line-height: 1.6;
}

.match-alert {
  display: inline-flex;
  align-items: center;
  gap: 8px;
  background: #fff3cd;
  border: 1px solid #ffc107;
  color: #856404;
  padding: 10px 18px;
  border-radius: 8px;
  font-size: 0.85rem;
  font-weight: 600;
  margin-bottom: 16px;
}

/* --- Loading Spinner --- */
.spinner {
  display: inline-block;
  width: 22px; height: 22px;
  border: 3px solid rgba(26,115,232,0.2);
  border-top-color: var(--primary);
  border-radius: 50%;
  animation: spin 0.8s linear infinite;
}

.loading-text {
  text-align: center;
  padding: 30px;
  color: var(--text-light);
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 14px;
  font-size: 0.9rem;
}

/* --- Search Bar --- */
.search-bar {
  display: flex;
  gap: 12px;
  margin-bottom: 24px;
  flex-wrap: wrap;
}

.search-bar input {
  flex: 1;
  min-width: 220px;
  padding: 12px 18px;
  border: 2px solid #e8eaf0;
  border-radius: 50px;
  font-size: 0.92rem;
  font-family: 'Poppins', sans-serif;
  outline: none;
  transition: var(--transition);
}

.search-bar input:focus {
  border-color: var(--primary);
  box-shadow: 0 0 0 4px rgba(26,115,232,0.08);
}

/* --- Alert / Flash Messages --- */
.alert {
  padding: 14px 20px;
  border-radius: 10px;
  font-size: 0.9rem;
  font-weight: 500;
  margin-bottom: 20px;
  display: flex;
  align-items: center;
  gap: 10px;
  animation: slideUp 0.4s ease;
}

.alert-success { background: rgba(46,204,113,0.12); color: #1a7a45; border: 1px solid rgba(46,204,113,0.3); }
.alert-error   { background: rgba(231,76,60,0.10);  color: #a93226; border: 1px solid rgba(231,76,60,0.25); }
.alert-info    { background: rgba(26,115,232,0.10); color: #0d5bba; border: 1px solid rgba(26,115,232,0.25); }

/* --- Features Section (index) --- */
.features {
  padding: 70px 20px;
  text-align: center;
  background: rgba(255,255,255,0.04);
}

.features h2 {
  font-size: 2rem;
  font-weight: 700;
  color: #fff;
  margin-bottom: 10px;
}

.features .sub {
  color: rgba(255,255,255,0.65);
  margin-bottom: 50px;
  font-size: 1rem;
}

.features-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
  gap: 24px;
  max-width: 1000px;
  margin: 0 auto;
}

.feature-card {
  background: rgba(255,255,255,0.08);
  backdrop-filter: blur(10px);
  border: 1px solid rgba(255,255,255,0.15);
  border-radius: 16px;
  padding: 32px 24px;
  transition: var(--transition);
  color: #fff;
}

.feature-card:hover {
  background: rgba(255,255,255,0.14);
  transform: translateY(-5px);
}

.feature-icon { font-size: 2.4rem; margin-bottom: 16px; }
.feature-card h3 { font-size: 1.05rem; font-weight: 600; margin-bottom: 10px; }
.feature-card p  { font-size: 0.87rem; color: rgba(255,255,255,0.7); line-height: 1.6; }

/* --- Report Page --- */
.report-wrapper {
  max-width: 680px;
  margin: 40px auto;
  padding: 0 20px;
}

.report-header {
  text-align: center;
  margin-bottom: 32px;
}

.report-header h1 { font-size: 1.8rem; font-weight: 700; color: var(--text-dark); }
.report-header p  { font-size: 0.92rem; color: var(--text-light); margin-top: 6px; }

/* --- Empty State --- */
.empty-state {
  text-align: center;
  padding: 50px 20px;
  color: var(--text-light);
}

.empty-state .empty-icon { font-size: 3rem; margin-bottom: 16px; }
.empty-state p { font-size: 0.95rem; }

/* --- Footer --- */
footer {
  text-align: center;
  padding: 28px;
  color: rgba(255,255,255,0.5);
  font-size: 0.85rem;
  border-top: 1px solid rgba(255,255,255,0.08);
}

footer.footer-light {
  background: #fff;
  color: var(--text-light);
  border-top: 1px solid #e8eaf0;
}

/* --- Animations --- */
@keyframes slideUp {
  from { opacity: 0; transform: translateY(20px); }
  to   { opacity: 1; transform: translateY(0); }
}

@keyframes spin {
  to { transform: rotate(360deg); }
}

@keyframes pulse {
  0%, 100% { transform: scale(1); opacity: 1; }
  50%       { transform: scale(1.4); opacity: 0.6; }
}

.fade-in {
  animation: slideUp 0.5s ease both;
}

/* --- Responsive --- */
@media (max-width: 768px) {
  .navbar { padding: 14px 20px; }
  .navbar-light { padding: 12px 20px; }
  .hero { padding: 60px 20px 50px; }
  .dashboard-container { padding: 20px 14px; }
  .auth-card { padding: 32px 24px; }
  .items-grid { grid-template-columns: 1fr; }
}
