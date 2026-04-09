# 🔍 CampusFind — Lost & Found Campus System

> A smart, student-built web application that helps campus students report and recover lost items using automatic keyword-based matching.

![PHP](https://img.shields.io/badge/PHP-8.0+-777BB4?style=for-the-badge&logo=php&logoColor=white)
![MySQL](https://img.shields.io/badge/MySQL-5.7+-4479A1?style=for-the-badge&logo=mysql&logoColor=white)
![HTML5](https://img.shields.io/badge/HTML5-E34F26?style=for-the-badge&logo=html5&logoColor=white)
![CSS3](https://img.shields.io/badge/CSS3-1572B6?style=for-the-badge&logo=css3&logoColor=white)
![JavaScript](https://img.shields.io/badge/JavaScript-F7DF1E?style=for-the-badge&logo=javascript&logoColor=black)
![XAMPP](https://img.shields.io/badge/XAMPP-FB7A24?style=for-the-badge&logo=xampp&logoColor=white)

--


## 📸 Screenshots

| Home Page | Dashboard | Smart Matches |
|-----------|-----------|---------------|
| Hero section with campus background | Stats, items grid, match panel | AJAX-powered XML match results |

---

## 📋 Table of Contents

- [About the Project](#about-the-project)
- [Features](#features)
- [Tech Stack](#tech-stack)
- [Folder Structure](#folder-structure)
- [Database Schema](#database-schema)
- [Getting Started](#getting-started)
- [How It Works](#how-it-works)
- [Pages Overview](#pages-overview)
- [Contributing](#contributing)
- [Author](#author)

---

## 📖 About the Project

**CampusFind** is an MCA-level web project that solves a common campus problem — students losing their belongings with no easy way to find them. This system allows students to:

- Register and log in securely
- Report items they've **lost** or **found** on campus
- Automatically get **smart match suggestions** when a lost item matches a found item
- View all reports on a clean, modern dashboard

Built using **only core web technologies** — no frameworks, no Bootstrap, no React. Pure PHP, MySQL, JavaScript, AJAX, and XML.

---

## ✨ Features

- 🔐 **User Authentication** — Register & login with secure bcrypt password hashing and PHP sessions
- 📋 **Report Lost Items** — Submit item name, description, location, and date
- 📦 **Report Found Items** — Same easy form to log found items
- 🔗 **Smart Matching Engine** — Compares keywords from lost & found item names and locations
- ⚡ **AJAX Integration** — Matches load dynamically without page refresh using `fetch()`
- 📄 **XML Storage** — Match results are written to and read from `matches.xml` via PHP DOMDocument
- 🔍 **Live Search Filter** — JavaScript-powered filter across all item cards
- 📊 **Dashboard Stats** — Real-time count of lost items, found items, and matches
- 📱 **Responsive Design** — Works on desktop and mobile screens

---

## 🛠️ Tech Stack

| Technology | Usage |
|---|---|
| **PHP** | Backend logic, sessions, form handling, DB queries |
| **MySQL** | Storing users, lost items, found items |
| **HTML5** | Page structure and forms |
| **CSS3** | Custom styling — flexbox, grid, animations (no Bootstrap) |
| **JavaScript** | Form validation, live search filter |
| **AJAX (fetch API)** | Dynamic match loading without page refresh |
| **XML + DOMDocument** | Match results stored and read from `matches.xml` |

---

## 📁 Folder Structure

```
lost-found-campus/
│
├── 📂 css/
│   └── style.css              ← All styles (single file, no Bootstrap)
│
├── 📂 js/
│   └── script.js              ← Form validation, AJAX, live search
│
├── 📂 xml/
│   └── matches.xml            ← Auto-generated match results (PHP writes this)
│
├── 📂 images/
│   └── background.jpg         ← Optional: local background image
│
├── db.php                     ← Database connection config
├── index.php                  ← Home / Landing page
├── register.php               ← User registration
├── login.php                  ← User login
├── dashboard.php              ← Main dashboard (stats + items + matches)
├── report_lost.php            ← Form to report a lost item
├── report_found.php           ← Form to report a found item
├── getMatches.php             ← AJAX endpoint: runs matching + writes XML
├── logout.php                 ← Destroys session and redirects
├── database.sql               ← Full MySQL setup script with sample data
└── README.md                  ← You are here
```

---

## 🗄️ Database Schema

```sql
-- Users table
CREATE TABLE users (
  id       INT AUTO_INCREMENT PRIMARY KEY,
  username VARCHAR(50)  NOT NULL UNIQUE,
  password VARCHAR(255) NOT NULL        -- bcrypt hashed
);

-- Lost items table
CREATE TABLE lost_items (
  id          INT AUTO_INCREMENT PRIMARY KEY,
  user_id     INT          NOT NULL,
  item_name   VARCHAR(150) NOT NULL,
  description TEXT         NOT NULL,
  location    VARCHAR(200) NOT NULL,
  date        DATE         NOT NULL,
  created_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id)
);

-- Found items table
CREATE TABLE found_items (
  id          INT AUTO_INCREMENT PRIMARY KEY,
  user_id     INT          NOT NULL,
  item_name   VARCHAR(150) NOT NULL,
  description TEXT         NOT NULL,
  location    VARCHAR(200) NOT NULL,
  date        DATE         NOT NULL,
  created_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id)
);
```

---

## 🚀 Getting Started

### Prerequisites

- [XAMPP](https://www.apachefriends.org/download.html) installed (includes Apache, MySQL, PHP, phpMyAdmin)

### Installation Steps

**1. Clone the repository**
```bash
git clone https://github.com/your-username/lost-found-campus.git
```

**2. Move to XAMPP's web root**
```
Copy the folder → C:\xampp\htdocs\lost-found-campus\
```

**3. Start XAMPP**
- Open XAMPP Control Panel
- Click **Start** next to **Apache**
- Click **Start** next to **MySQL**

**4. Set up the database**
- Open browser → go to `http://localhost/phpmyadmin`
- Click **New** → name it `lost_found_campus` → click **Create**
- Click the database in the sidebar → click **Import** tab
- Click **Choose File** → select `database.sql` from the project folder
- Click **Go**

**5. Configure DB credentials (if needed)**

Open `db.php` and update:
```php
define('DB_HOST', 'localhost');
define('DB_USER', 'root');     // your MySQL username
define('DB_PASS', '');         // your MySQL password (blank by default in XAMPP)
define('DB_NAME', 'lost_found_campus');
```

**6. Run the project**
```
http://localhost/lost-found-campus/
```

---

## ⚙️ How It Works

### Smart Matching Engine

When a user opens the dashboard, JavaScript calls `getMatches.php` via `fetch()` (AJAX).

The PHP script:
1. Fetches all lost and found items from the database
2. Extracts meaningful keywords from item names (filters out stop words like "a", "the", "on")
3. Compares keywords between every lost item and every found item
4. If item names share a keyword → **match found**
5. Writes results to `xml/matches.xml` using PHP's `DOMDocument`
6. Returns the XML to the browser

JavaScript then parses the XML and renders match cards dynamically on the dashboard — no page reload needed.

```
Dashboard loads
    ↓
JS calls getMatches.php via fetch()
    ↓
PHP compares keywords (lost ↔ found)
    ↓
PHP writes results → matches.xml
    ↓
PHP returns XML response
    ↓
JS parses XML → renders match cards
```

---

## 📄 Pages Overview

| Page | File | Description |
|---|---|---|
| Home | `index.php` | Landing page with hero section and feature cards |
| Register | `register.php` | Create a new account |
| Login | `login.php` | Login with username and password |
| Dashboard | `dashboard.php` | View stats, all items, and smart matches |
| Report Lost | `report_lost.php` | Submit a lost item report |
| Report Found | `report_found.php` | Submit a found item report |
| Get Matches | `getMatches.php` | AJAX endpoint — runs matching, writes XML |
| Logout | `logout.php` | Clears session, redirects to login |

---

## 🎯 Sample Test Data

The `database.sql` file includes 3 sample users and 5 pre-loaded lost/found items so you can see the matching system working immediately after setup.

To create your own account, simply use the **Register** page.

---

## 🤝 Contributing

Pull requests are welcome! For major changes, please open an issue first to discuss what you'd like to change.

1. Fork the project
2. Create your feature branch (`git checkout -b feature/new-feature`)
3. Commit your changes (`git commit -m 'Add new feature'`)
4. Push to the branch (`git push origin feature/new-feature`)
5. Open a Pull Request

---

## 👨‍💻 Author

**Your Name**
- GitHub: [@your-username](https://github.com/your-username)
- Email: your.email@example.com

---

## 📝 License

This project is open source and available under the [MIT License](LICENSE).

---

## 🙏 Acknowledgements

- [Google Fonts — Poppins](https://fonts.google.com/specimen/Poppins)
- [Unsplash](https://unsplash.com) — Campus background images
- XAMPP by Apache Friends

---

> Made with ❤️ as an MCA Student Project
