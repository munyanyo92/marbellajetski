# DUAL-TRACK DEPLOYMENT PLAN
> Marbella JetSki — February 2026
> Status: **PLANNING** — awaiting cosmetic changes before execution

---

## Overview

Two parallel versions of the website will be maintained:

| | Track A — WordPress | Track B — Static (Self-hosted) |
|---|---|---|
| **Purpose** | Hand to TIC TAC for immediate deployment | Future self-hosted version with full backend |
| **Repo branch** | `wordpress` | `main` (current) |
| **Who deploys** | TIC TAC COMUNICACIÓN | You (Hetzner + Cloudflare) |
| **Backend features** | None (static content only) | Booking DB, Redsys, contracts, OCR (future) |
| **Timeline** | Ready for summer 2026 | Ongoing development |
| **Monthly cost** | Whatever you already pay TIC TAC | ~€41/mo when ready |

---

## Track A — WordPress Version

### What it is
A WordPress theme built from our existing HTML/CSS/JS so TIC TAC can install it like any other theme. The site looks **identical** to what we've built — same design, same content, same everything — but wrapped in WordPress structure.

### What gets converted
```
Our static files          →  WordPress theme
─────────────────────────────────────────────
index.html                →  front-page.php
about-daniel.html         →  page-about.php
booking.html              →  page-booking.php
terms.html                →  page-terms.php
weather-policy.html       →  page-weather-policy.php
404.html                  →  404.php
styles.css                →  style.css (with WP theme header)
script.js                 →  js/script.js (enqueued)
jetski-anim.js            →  js/jetski-anim.js (enqueued)
es/index.html             →  page-es-home.php (or WPML plugin)
es/booking.html           →  page-es-booking.php
fr/index.html             →  page-fr-home.php
nl/index.html             →  page-nl-home.php
boats/*.html              →  page-boats-*.php
assets/                   →  theme/assets/ (copied as-is)
```

### WordPress theme structure (to be created)
```
marbellajetski-theme/
├── style.css              ← Theme header + all our CSS
├── functions.php          ← Enqueue scripts, menus, theme support
├── header.php             ← <head>, nav (shared)
├── footer.php             ← Footer, scripts (shared)
├── front-page.php         ← Homepage (from index.html)
├── page-about.php         ← About Us (from about-daniel.html)
├── page-booking.php       ← Booking (from booking.html)
├── page-terms.php         ← Terms & Conditions
├── page-weather-policy.php
├── 404.php
├── page-boats-rinker.php
├── page-boats-cranchi.php
├── page-boats-azimut.php
├── page-boats-catamaran.php
├── js/
│   ├── script.js
│   └── jetski-anim.js
├── assets/
│   ├── fonts/
│   ├── media/
│   │   ├── photos/
│   │   ├── racing/
│   │   └── videos/
│   └── ...
└── screenshot.png         ← Theme preview in WP admin
```

### What TIC TAC needs to do
1. Install the theme ZIP file via WordPress Admin → Appearance → Themes → Add New → Upload
2. Activate the theme
3. Create pages in WordPress and assign the correct template to each
4. Set the homepage to use "Front Page" template
5. Done — the site looks exactly like what we built

### WordPress-specific additions
- `wp_enqueue_style()` / `wp_enqueue_script()` for proper asset loading
- `wp_nav_menu()` for navigation (optional — can keep hardcoded nav)
- Translation: Either hardcoded language pages (like now) or WPML plugin
- Contact form: Keep WhatsApp links (no plugin needed)
- Cookie consent: WP plugin (TIC TAC probably has one)

### What Track A does NOT include
- ❌ Booking database
- ❌ Payment processing (Redsys)
- ❌ Contract/waiver signing
- ❌ ID capture / OCR
- ❌ Admin dashboard
- ❌ Email confirmations
- These are all Track B features

### Security notes for WordPress
- TIC TAC MUST keep WordPress core + plugins updated
- Strong admin passwords (not admin/admin)
- Recommend Wordfence or Sucuri plugin for basic security
- Cloudflare free tier can still be used in front for DDoS protection

---

## Track B — Static / Self-Hosted Version

### What it is
The current codebase as-is, with future backend features added incrementally.

### Current state (what's done)
- ✅ Full responsive website (EN, ES, FR, NL)
- ✅ All service pages (jet ski, boats, watersports, paddleboard, etc.)
- ✅ About Us page (company-first structure)
- ✅ Racing section with videos + gallery
- ✅ Lesson cards (Basic, Intermediate, Masterclass)
- ✅ Boat detail pages (Rinker 296, Cranchi 39, Azimut 39, Catamaran Bali)
- ✅ Booking page (WhatsApp-based currently)
- ✅ Terms & Conditions
- ✅ Weather policy
- ✅ 404 page
- ✅ Offline page (PWA)
- ✅ Service worker

### Future backend (Phase 2+, when you self-host)
- Booking database (PostgreSQL)
- Redsys virtual TPV payment
- Digital contract/waiver with signature
- ID photo capture + OCR pre-fill
- Walk-in beach tablet form
- Email confirmations
- Admin dashboard
- Photo/video gallery manager

### Infrastructure (when ready)
- Hetzner CX32 VPS: €7.49/mo
- Cloudflare Pro: €20/mo
- Cloudflare R2 (media storage): €7.50/mo
- Backups: €1.49/mo
- Staging: €4.35/mo
- **Total: ~€41/mo**

---

## Execution Order

### Step 0: Cosmetic Changes (NOW — before any cloning)
> **All cosmetic/visual changes should be made FIRST on `main` branch.**
> Both tracks will inherit these changes.

Pending cosmetic changes:
- [ ] _List your changes here before we execute_
- [ ] 
- [ ] 
- [ ] 

### Step 1: Finalize Static Site
- Complete all cosmetic changes on `main`
- Test everything locally
- Push to GitHub

### Step 2: Create WordPress Branch
```powershell
cd "C:\Users\Usuario\Website Marbella Jetski"
git checkout -b wordpress
```

### Step 3: Build WordPress Theme
- Convert HTML pages to PHP templates
- Create functions.php with proper enqueuing
- Create style.css with WP theme header
- Package as ZIP for TIC TAC

### Step 4: Deliver to TIC TAC
- Send them the theme ZIP
- Provide installation instructions
- They install on their WordPress instance
- Test on staging before going live

### Step 5: Continue Track B on `main`
- Backend features developed independently
- Deploy to Hetzner when ready
- Switch DNS from TIC TAC to your own server when confident

---

## Branch Strategy

```
main (Track B — static/self-hosted)
  │
  ├── wordpress (Track A — WP theme for TIC TAC)
  │
  └── feature/* (future backend work)
        ├── feature/booking-api
        ├── feature/redsys-payment
        ├── feature/contracts
        └── feature/id-ocr
```

---

## Decision Log

| Date | Decision | Rationale |
|------|----------|-----------|
| 2026-02-11 | Dual-track approach | TIC TAC only works with WordPress; we need WP version for immediate deployment + static version for future self-hosting |
| 2026-02-11 | Cosmetic changes first | Both tracks benefit from visual improvements made on main before branching |
| 2026-02-11 | Backend deferred | Focus on getting the site live for summer; backend features (payments, contracts) can be added to Track B later |

---

## Notes
- Both tracks share the same visual design — the WordPress version is just a wrapper
- Any cosmetic change made on `main` can be merged into `wordpress` branch
- The WordPress version is a **delivery format**, not a rebuild
- When you're ready to self-host, you simply point the domain to your Hetzner VPS and Track B goes live
