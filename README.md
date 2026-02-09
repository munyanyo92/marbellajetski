# 🌊 Marbella JetSki — Official Website

**STIERS E HIJOS S.L.** — NIF B92917178  
Owned & operated by **Daniel Stiers** — 4× Spanish National Champion 2024

📍 Puerto Deportivo de Marbella, 29601 Marbella, Spain  
📞 +34 655 44 22 32  
📧 info@marbellajetski.com

---

## 🗂️ Project Structure

```
├── index.html              # 🇬🇧 English homepage
├── es/index.html           # 🇪🇸 Spanish homepage
├── fr/index.html           # 🇫🇷 French homepage
├── nl/index.html           # 🇳🇱 Dutch homepage
├── about-daniel.html       # About Daniel Stiers page
├── booking.html            # Booking / reservation page
├── terms.html              # Terms & conditions
├── 404.html                # Custom 404 page
├── offline.html            # Offline fallback (PWA)
├── styles.css              # All CSS styles
├── script.js               # All JavaScript
├── sw.js                   # Service Worker (PWA caching)
├── manifest.json           # PWA manifest
├── bg.jpg                  # Fallback background image
├── jetski-anim.js          # Legacy animation file (unused)
└── .gitignore
```

## 🚀 How to Run Locally

This is a **static website** — no build tools, no npm, no frameworks needed.

### Option 1: VS Code Live Server (Recommended)
1. Open this folder in **VS Code**
2. Install the **Live Server** extension (`ritwickdey.LiveServer`)
3. Right-click `index.html` → **Open with Live Server**
4. Site opens at `http://127.0.0.1:5500`

### Option 2: Python HTTP Server
```bash
cd MarbellaJetSki
python3 -m http.server 8000
# Open http://localhost:8000
```

### Option 3: Node.js HTTP Server
```bash
npx serve .
```

## 🔧 Tech Stack

| Component | Technology |
|-----------|-----------|
| Frontend | Pure HTML5, CSS3, JavaScript (no frameworks) |
| Styling | Custom CSS with CSS variables |
| Icons | Font Awesome 6 (CDN) |
| Animations | AOS (Animate on Scroll) library (CDN) |
| Slider | Swiper.js (CDN) |
| Video | Pexels stock footage (hero background) |
| Weather | Open-Meteo free API (no API key needed) |
| PWA | Service Worker + manifest.json |

## 🌤️ Weather Widget

The weather widget shows **live Marbella weather** using the free [Open-Meteo API](https://open-meteo.com/). No API key required.

- Temperature, wind speed, humidity are live
- Sea temperature uses monthly Mediterranean averages
- Weather descriptions mapped from WMO codes

## 🎨 Design Variables (CSS)

```css
--primary: #00b4d8      /* Ocean blue */
--secondary: #ff6b35    /* Sunset orange */
--accent-gold: #ffc300  /* Gold accent */
--dark: #0a1628         /* Dark navy */
```

## 📱 Features

- ✅ Fully responsive (mobile-first)
- ✅ 4 languages (EN / ES / FR / NL)
- ✅ Video hero background
- ✅ Live weather widget
- ✅ Summer discount banner
- ✅ PWA (installable, works offline)
- ✅ SEO optimized (meta tags, structured data, Open Graph)
- ✅ Google Reviews integration
- ✅ WhatsApp booking button
- ✅ Cookie consent
- ✅ Accessibility (ARIA labels, semantic HTML)
- ✅ Service Worker with smart caching

## 🌐 Deployment

This site can be hosted on any static hosting:

- **GitHub Pages** — Free, push to `main` branch
- **Netlify** — Drag & drop the folder
- **Vercel** — Connect this repo
- **Hostinger / cPanel** — Upload via FTP
- **Cloudflare Pages** — Connect this repo

### Quick Deploy to GitHub Pages:
1. Go to repo **Settings** → **Pages**
2. Source: **Deploy from a branch**
3. Branch: `main`, folder: `/ (root)`
4. Save — site will be live at `https://danielst7.github.io/marbellajetski/`

## 📝 Making Changes

All code is plain HTML/CSS/JS — edit directly in VS Code:

- **Content/text**: Edit the `.html` files
- **Styling**: Edit `styles.css`
- **Behavior**: Edit `script.js`
- **Caching**: Update `CACHE_NAME` version in `sw.js` after changes

> ⚠️ After making changes, bump the service worker cache version in `sw.js` to ensure visitors get the latest version.

## 📄 License

© 2026 STIERS E HIJOS S.L. All rights reserved.
