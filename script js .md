/**
 * Lost & Found Campus System - script.js
 * Handles: Form validation, AJAX match loading, item search/filter
 */

/* ============================================================
   1. FORM VALIDATION
   ============================================================ */

/**
 * Validates a form by checking all required fields are non-empty.
 * @param {string} formId - The ID of the form element
 * @returns {boolean} - true if valid
 */
function validateForm(formId) {
  const form = document.getElementById(formId);
  if (!form) return true;

  let isValid = true;

  // Clear previous error highlights
  form.querySelectorAll('.input-error').forEach(el => {
    el.classList.remove('input-error');
  });
  form.querySelectorAll('.err-msg').forEach(el => el.remove());

  const inputs = form.querySelectorAll('input[required], textarea[required], select[required]');
  inputs.forEach(input => {
    if (!input.value.trim()) {
      input.classList.add('input-error');
      const msg = document.createElement('span');
      msg.className = 'err-msg';
      msg.textContent = 'This field is required.';
      msg.style.cssText = 'color:#e74c3c;font-size:0.78rem;margin-top:4px;display:block;';
      input.parentNode.appendChild(msg);
      isValid = false;
    }
  });

  // Password match check (register page)
  const pwd  = form.querySelector('#password');
  const cpwd = form.querySelector('#confirm_password');
  if (pwd && cpwd && pwd.value !== cpwd.value) {
    cpwd.classList.add('input-error');
    const msg = document.createElement('span');
    msg.className = 'err-msg';
    msg.textContent = 'Passwords do not match.';
    msg.style.cssText = 'color:#e74c3c;font-size:0.78rem;margin-top:4px;display:block;';
    cpwd.parentNode.appendChild(msg);
    isValid = false;
  }

  if (!isValid) {
    // Shake the form card
    const card = form.closest('.card, .auth-card');
    if (card) {
      card.style.animation = 'none';
      card.offsetHeight; // reflow
      card.style.animation = 'shake 0.4s ease';
    }
  }
  return isValid;
}

// Add shake animation dynamically
const style = document.createElement('style');
style.textContent = `
  @keyframes shake {
    0%,100%{transform:translateX(0)}
    20%,60%{transform:translateX(-6px)}
    40%,80%{transform:translateX(6px)}
  }
  .input-error {
    border-color: #e74c3c !important;
    background: #fff8f8 !important;
  }
`;
document.head.appendChild(style);


/* ============================================================
   2. AJAX — LOAD SMART MATCHES
   ============================================================ */

/**
 * Calls getMatches.php via AJAX, writes results to matches.xml (server side),
 * then reads and renders the matches on the dashboard.
 */
function loadMatches() {
  const container = document.getElementById('match-container');
  if (!container) return;

  // Show loading spinner
  container.innerHTML = `
    <div class="loading-text">
      <div class="spinner"></div>
      <span>Scanning for possible matches...</span>
    </div>
  `;

  // AJAX call to getMatches.php
  fetch('getMatches.php', {
    method: 'GET',
    headers: { 'X-Requested-With': 'XMLHttpRequest' }
  })
  .then(response => {
    if (!response.ok) throw new Error('Network error');
    return response.text();
  })
  .then(xmlText => {
    renderMatches(xmlText, container);
  })
  .catch(err => {
    container.innerHTML = `
      <div class="alert alert-error">
        ⚠️ Could not load matches. Please try again later.
      </div>
    `;
    console.error('AJAX Error:', err);
  });
}

/**
 * Parses XML string and renders match cards in the given container.
 * @param {string} xmlText - Raw XML string from server
 * @param {HTMLElement} container - Where to render results
 */
function renderMatches(xmlText, container) {
  let parser, xmlDoc;
  try {
    parser = new DOMParser();
    xmlDoc = parser.parseFromString(xmlText, 'application/xml');
  } catch(e) {
    container.innerHTML = '<div class="alert alert-error">Failed to parse match data.</div>';
    return;
  }

  const matches = xmlDoc.getElementsByTagName('match');

  if (matches.length === 0) {
    container.innerHTML = `
      <div class="empty-state">
        <div class="empty-icon">🔍</div>
        <p>No matches found right now. Check back after more items are reported.</p>
      </div>
    `;
    return;
  }

  // Build match cards
  let html = `
    <div class="match-alert">
      🎉 ${matches.length} Possible Match${matches.length > 1 ? 'es' : ''} Found!
    </div>
  `;

  Array.from(matches).forEach((match, i) => {
    const getText = tag => {
      const el = match.getElementsByTagName(tag)[0];
      return el ? el.textContent : '';
    };

    html += `
      <div class="match-card fade-in" style="animation-delay:${i * 0.08}s">
        <div class="match-title">
          🔗 Lost: "${getText('lost_item')}" ↔ Found: "${getText('found_item')}"
        </div>
        <div class="match-detail">
          <strong>Lost Location:</strong> ${getText('lost_location')} &nbsp;|&nbsp;
          <strong>Found Location:</strong> ${getText('found_location')}
        </div>
        <div class="match-detail" style="margin-top:5px; color:#888;">
          Reported by Lost: <strong>${getText('lost_user')}</strong> &nbsp;|&nbsp;
          Reported by Found: <strong>${getText('found_user')}</strong>
        </div>
      </div>
    `;
  });

  container.innerHTML = html;

  // Flash the match section header
  const header = document.querySelector('.match-pulse');
  if (header) {
    header.style.background = '#2ecc71';
    setTimeout(() => { header.style.background = ''; }, 2000);
  }
}


/* ============================================================
   3. ITEM SEARCH / FILTER (Dashboard)
   ============================================================ */

/**
 * Filters item cards based on a search query.
 * Works on both lost and found item grids.
 */
function filterItems() {
  const query = document.getElementById('searchInput');
  if (!query) return;

  const q = query.value.toLowerCase().trim();
  const cards = document.querySelectorAll('.item-card');
  let visible = 0;

  cards.forEach(card => {
    const text = card.textContent.toLowerCase();
    if (text.includes(q)) {
      card.style.display = 'block';
      visible++;
    } else {
      card.style.display = 'none';
    }
  });

  // Show/hide "no results" message
  const noResult = document.getElementById('no-result-msg');
  if (noResult) {
    noResult.style.display = visible === 0 ? 'block' : 'none';
  }
}


/* ============================================================
   4. INIT ON PAGE LOAD
   ============================================================ */

document.addEventListener('DOMContentLoaded', () => {

  // Load matches if on dashboard
  if (document.getElementById('match-container')) {
    loadMatches();
  }

  // Attach search filter
  const searchInput = document.getElementById('searchInput');
  if (searchInput) {
    searchInput.addEventListener('input', filterItems);
  }

  // Auto-dismiss flash alerts after 4 seconds
  document.querySelectorAll('.alert').forEach(alert => {
    setTimeout(() => {
      alert.style.transition = 'opacity 0.5s ease';
      alert.style.opacity = '0';
      setTimeout(() => alert.remove(), 500);
    }, 4000);
  });

  // Highlight active nav link
  const currentPage = window.location.pathname.split('/').pop();
  document.querySelectorAll('.navbar nav a').forEach(link => {
    if (link.getAttribute('href') === currentPage) {
      link.classList.add('active');
    }
  });
});
