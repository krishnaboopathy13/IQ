# IQ Enterprise v2.0
### Enterprise Assessment & Hiring Intelligence Platform

A fully self-contained, single-file web application for end-to-end recruitment assessment. No backend, no database, no build step required.

---

## 📦 Package Contents

```
iq-enterprise/
├── index.html                  ← The entire application (deploy this)
├── manifest.json               ← PWA manifest
├── sw.js                       ← Service worker (offline support)
├── favicon.ico                 ← Browser favicon
├── icons/
│   ├── icon-192.png            ← PWA icon (Android)
│   ├── icon-512.png            ← PWA icon (splash screen)
│   ├── apple-touch-icon.png    ← iOS home screen icon
│   ├── favicon-32.png          ← Browser tab icon (32px)
│   └── favicon-16.png          ← Browser tab icon (16px)
├── iq-candidates-template.csv  ← Bulk import CSV template
│
├── netlify.toml                ← Netlify deployment config
├── firebase.json               ← Firebase Hosting config
├── .firebaserc                 ← Firebase project reference
├── nginx.conf                  ← Production Nginx (with SSL)
├── nginx.docker.conf           ← Nginx config for Docker
├── Dockerfile                  ← Docker image definition
├── docker-compose.yml          ← Docker Compose stack
├── deploy.sh                   ← VPS one-command deploy script
└── README.md                   ← This file
```

---

## 🚀 Deploy in 60 Seconds

### Option 1 — Netlify (Recommended, free)
1. Go to [app.netlify.com](https://app.netlify.com)
2. Drag and drop this entire folder onto the deploy zone
3. Done — live in ~10 seconds ✅

Or via CLI:
```bash
npm install -g netlify-cli
netlify deploy --prod --dir .
```

---

### Option 2 — Firebase Hosting
```bash
npm install -g firebase-tools
firebase login
# Edit .firebaserc → set your project ID
firebase deploy
```

---

### Option 3 — Docker
```bash
# Build and run
docker compose up -d

# Or manually
docker build -t iq-enterprise .
docker run -d -p 80:80 --name iq iq-enterprise
```
Then open `http://localhost`

---

### Option 4 — VPS / Ubuntu Server (with Nginx + SSL)
```bash
chmod +x deploy.sh
./deploy.sh your-domain.com
```
This will:
- Install Nginx (if needed)
- Copy files to `/var/www/iq-enterprise`
- Configure and enable the Nginx site
- Optionally obtain a free SSL cert via Certbot

---

### Option 5 — GitHub Pages
1. Push this folder to a GitHub repo
2. Go to **Settings → Pages**
3. Set source to `main` branch, root `/`
4. Done — live at `https://yourusername.github.io/repo-name`

---

### Option 6 — Local / Offline
Open `index.html` directly in Chrome. Camera/proctoring requires a proper host (HTTPS or localhost).

---

## ⚠️ Important: HTTPS Requirement

Camera-based proctoring (**Full** and **Photo** modes) requires **HTTPS**. This is a browser security requirement (WebRTC).

- Netlify, Firebase, GitHub Pages → HTTPS by default ✅
- Docker/Nginx → add Certbot or a reverse proxy (Caddy, Traefik) ✅
- Local development → `localhost` works without HTTPS ✅

---

## 🗂 Bulk Import

Use `iq-candidates-template.csv` as your starting point. Required columns: `name`, `email`. All others are optional.

```
name, email, phone, role, taleoid, dept, city, recruiteremail, requisitionid, duration, cutoff, password, proctoring
```

**proctoring** values: `full` | `photo` | `none`

---

## 💾 Data Storage

All data is stored in the **browser's localStorage** on the admin device under the key `oiq-ent-v1`.

- **Backup regularly:** Use the Export (CSV/XLSX/PDF) buttons before clearing browser data
- **Multi-device:** Export CSV from Device A → import on Device B
- **Max capacity:** ~5–10 MB (supports ~500 candidates with proctoring data)

---

## 🔑 Default Admin Login

The app launches directly into the admin shell. No login required by default — secure your deployment via:
- Hosting-level password (Netlify password protection)
- VPN / IP allowlist on Nginx
- Or add custom auth in a future update

---

## 📋 Key Features

| Module | Capability |
|--------|-----------|
| Candidates | Profiles, bulk CSV import, Pipeline Kanban |
| Tests | MCQ builder, Typing tests, True/False |
| Repository | 200-question pool, bulk JSON/CSV import |
| Aptitude Bank | 6 categories: Quantitative, Logical, Verbal, Data, Spatial, Abstract |
| Auto-Assign | Count + strategy rules per candidate |
| Proctoring | Webcam captures, tab-switch detection, fullscreen enforcement, trust score |
| Schedules | Named time windows with start/end gates |
| Invites | Per-candidate tokens, bulk invite, expiry tracking |
| Email Builder | Template editor with variable substitution, 4 presets |
| Results | Live leaderboard, dept filter, pass/fail badges |
| Analytics | Score distribution, role-wise breakdown |
| Remarks | Interviewer tags and notes per candidate |
| Audit Logs | Full invite and action trail |
| Exports | CSV, XLSX, PDF across all modules |

---

## 🛠 Tech Stack

- **Frontend:** Vanilla HTML5 + CSS3 + ES6 JavaScript
- **Dependencies:** None (zero npm packages)
- **Fonts:** DM Sans, Sora, JetBrains Mono (Google Fonts CDN)
- **Storage:** Browser localStorage
- **Camera:** WebRTC getUserMedia API
- **Exports:** Native Blob/URL API + SheetJS (XLSX)

---

## 📄 License

Proprietary — IQ Enterprise v2.0. All rights reserved.
