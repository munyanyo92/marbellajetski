# MASTER BLUEPRINT — Marbella JetSki Website

> **Last Updated:** 2025-07-15 — Phase 2: Yacht rebuild, pricing restructure, brand refocus, gallery expansion  
> **Business:** STIERS E HIJOS S.L. (NIF: B92917178)  
> **Owner:** Daniel Luciano Stiers — 4x Spanish National Jet Ski Champion (RFEM 2024) • Campeón de Andalucía 2025  
> **Domain:** marbellajetski.com  
> **Stack:** Static HTML/CSS/JS — No frameworks, no build tools, no backend  
> **Hosting:** UNKNOWN — images are served from `marbellajetski.com/wp-content/uploads/` (WordPress media library)

---

## PURPOSE OF THE WEBSITE

Commercial website for **Marbella JetSki**, a family-owned water sports centre operating since 1998 at Playa de las Dunas, Marbella, Spain. The site aims to:

1. Showcase all services (jet ski hire, yacht charters, water sports, training with Daniel)
2. Allow customers to book/reserve activities online
3. Establish credibility (racing achievements, ISO certifications, 25+ years experience)
4. Provide multilingual access (EN, ES, FR, NL)
5. Function as a PWA with offline support

---

## FILE-BY-FILE AUDIT

### Legend
| Symbol | Meaning |
|--------|---------|
| DONE | Fully implemented and functional |
| PARTIAL | Started but incomplete or has issues |
| NOT DONE | Planned/referenced but not implemented |
| UNKNOWN | Cannot verify status without live server/deployment |
| BUG | Contains a known issue |

---

### ROOT FILES

#### `index.html` (1682 lines) — English Homepage
| Section | Status | Notes |
|---------|--------|-------|
| `<head>` SEO meta tags | DONE | Title, description, keywords, robots, canonical all present |
| Open Graph tags | DONE | og:type, og:url, og:title, og:description, og:image, og:locale |
| Twitter Card tags | DONE | summary_large_image card configured |
| Hreflang tags | PARTIAL | EN and ES declared; FR and NL are **missing** from hreflang |
| Structured Data (JSON-LD) | DONE | LocalBusiness schema with address, geo, hours, rating, founder |
| PWA manifest link | DONE | Links to manifest.json |
| Favicon | DONE | Points to WP-hosted PNG logo |
| Fonts (Google Fonts) | DONE | Montserrat + Playfair Display + Space Grotesk (hero title) |
| Font Awesome 6.5.1 | DONE | CDN link |
| AOS animation library | DONE | CDN CSS + JS at bottom |
| Swiper 11 | DONE | CDN CSS + JS at bottom |
| Skip-to-content link | DONE | Accessibility compliance (WCAG 2.4.1) |
| Cache-busting on load | DONE | Inline script clears old SW caches |
| **Navigation** | DONE | Fixed navbar, scroll effect, mobile hamburger, lang switch (ES only), Book Now CTA |
| Language selector | PARTIAL | Only EN→ES toggle in nav. FR/NL links **not in nav** |
| **Summer discount banner** | DONE | "Book Before Summer & Save 10%" — animated banner |
| **Hero section** | DONE | Video background (Pexels), fallback image, title, stats (1998/15 activities/4.9★), CTA buttons (Book + WhatsApp) |
| **Weather widget** | DONE | Live weather via Open-Meteo API (temp, desc, wind, sea temp estimate, humidity) |
| **Services overview** | DONE | 4 cards — Jet Ski Hire, Yacht Charters, Water Sports, Guided Excursions |
| **Why Choose Us** | DONE | 6 USP cards — GPS-Tracked Fleet (OtoTrak), Premium Jet Ski Experiences, Maritime Qualified, Pro Photos, Family Since 1998, ISO Certified |
| **Jet Ski section** | DONE | Circuit (20m €70 / 30m €90 ★Most Popular / 1h €120 — max 1h) + Excursion (1h €170/jetski ★Most Popular / 2h €330/jetski — max 4 jet skis) with Swiper carousels |
| **Water Sports section** | DONE | 10 activities: Wakeboarding, Water Skiing, Crazy Sofa, Water Bull, Banana Boat, Air Stream, Donut Ride, SUP, Pedal Boats, Double Kayaks (€30/h) — with category filter. Waterski photo replaced with own (ski1.jpg) |
| **Yacht Charter section** | DONE | 5 real yachts from BARCOS PDFs: Sea Ray 240 (from €280/h), Rinker 296 (from €250/h), Cranchi 39 (from €380/h), Azimut 39 Fly (from €400/h), Catamaran Bali 4.0 (from €750/2h). Each card has expandable pricing. All operated by Marbella Ocean Boats from Puerto Banús. |
| **About section** | DONE | Company-focused: Marbella JetSki since 1998. Daniel mentioned as professional pilot who offers racing lessons. ISO certs, achievements. |
| **Video section** | DONE | 4 local promo videos from `assets/media/videos/`. Sotogrande videos deleted. |
| **Gallery section** | DONE | 20-image grid with lightbox — mix of WP-hosted, local racing, own photos (blue-jetski, high-res-jetski, waterski-action, yacht-action). |
| **Lightbox** | DONE | Click-to-open, arrow navigation, keyboard (Escape/Left/Right), overlay close |
| **Testimonials** | DONE | Swiper carousel with 4 reviews (Google + TripAdvisor), 4.9/5 rating, Write a Review link |
| **Booking CTA section** | DONE | Trust badges, "Book Online Now" button, WhatsApp + Phone alternatives |
| **FAQ section** | DONE | 14 expandable FAQ items with accordion — comprehensive coverage |
| **Contact section** | DONE | Phone, WhatsApp, Email, Hours, Location + embedded Google Maps iframe |
| **Footer** | DONE | Brand, Quick Links, Information/Legal links, Contact info, Social (FB/IG/TikTok/YT/TripAdvisor), ISO cert images, copyright |
| **Floating WhatsApp button** | DONE | Fixed bottom-right with tooltip |
| **Back to Top button** | DONE | Appears on scroll, smooth scroll up |
| **jetski-anim.js reference** | NOT DONE | README says "Legacy animation file (unused)" — file exists (457 lines) but is NOT loaded in index.html `<script>` tags |

#### `booking.html` (1583 lines) — English Booking Page
| Feature | Status | Notes |
|---------|--------|-------|
| SEO meta tags | DONE | Title, description, OG tags |
| Navigation | DONE | Reuses same nav structure, links back to index.html sections |
| Hero banner | DONE | Gradient hero with "Book Your Adventure" |
| **4-Step booking wizard** | DONE | Step 1: Choose Activity → Step 2: Date & Details → Step 3: Your Info → Step 4: Payment |
| Step 1: Activity selection | DONE | 5 categories (All, Jet Ski, Water Sports, Yacht, Training with Daniel). 22 activity options with prices |
| Training with Daniel | DONE | "By Request" items — shows WhatsApp/Phone contact notice instead of booking flow |
| Step 2: Date & time | DONE | Date picker (min=today), time dropdown (10:00-14:00 in 30min slots) |
| Step 2: Guests/jet skis | DONE | Number inputs with validation constraints (max 4 circuit jet skis, min 2 tour, min 2 towable) |
| Step 2: Special requests | DONE | Optional textarea |
| Same-day booking cutoff | DONE | Shows warning after 14:00 for same-day |
| Step 3: Personal info | DONE | First/Last name, Email, Phone, ID/Passport, DOB, Address (optional) |
| Step 4: Payment options | DONE | 30% deposit or full payment toggle |
| Step 4: Payment methods | DONE | Card, PayPal, Pay on Arrival — **BUT card processing is NOT integrated** |
| **Actual payment processing** | **NOT DONE** | Card fields show "Secure Payment Link" placeholder — no Stripe/PayPal integration. Payment is via WhatsApp message |
| Step 4: Terms checkbox | DONE | Links to terms.html, privacy, cancellation, weather policy |
| Step 4: Media consent | DONE | Optional photo/video consent checkbox |
| Step 5: Confirmation | DONE | Shows booking reference, WhatsApp notification |
| **Booking submission** | PARTIAL | Generates ref number, builds WhatsApp message, opens WhatsApp with pre-filled data — **NO email confirmation, NO database, NO actual payment** |
| Order summary sidebar | DONE | Sticky sidebar with activity, date, time, guests, price breakdown |
| Summary trust badges | DONE | Free cancellation, weather refund, safety equipment, photos, insurance |
| Policies bar | DONE | 4 policy items at bottom |
| Footer | DONE | Same as index.html footer |
| **Time slots** | BUG | Only shows 10:00-14:00 — business hours are 11:00-20:00. Missing afternoon/evening slots |
| **Responsive** | DONE | Grid collapses on mobile, steps wrap |

#### `about-daniel.html` — About & Lessons / Racing Page
| Feature | Status | Notes |
|---------|--------|-------|
| SEO meta tags | DONE | Person schema, OG profile type, detailed awards in JSON-LD |
| Navigation | DONE | Added "Racing" link between Yachts and About & Lessons |
| Hero section | DONE | Full video background with particles, animated badge, CTA buttons |
| Story section | DONE | Refocused on Marbella JetSki as company. Daniel presented as "Professional Pilot & Instructor" — not center of brand. |
| "The Racing Journey" timeline | DONE | "Professional Racing Begins" entry removed. Remaining: Family Legacy 1998, Growing Up 2000s, Quality Certification 2020, First Year 2023, National Champion 2024, Andalusia Champion 2025, Training Next Generation NOW |
| "Championship Medal Tally" section | REMOVED | Entire section deleted |
| Racing Videos section | DONE | Real racing footage preserved (id="racing-videos") |
| Lessons section | DONE | Renamed to "Racing Lessons". 3 tiers: Basic 30min €299, Racing Experience 1h €499, Masterclass 2h €699 |
| CTA section | DONE | Replaced "Ready to Ride with a Champion?" with "Book Your Water Experience" — company-focused |
| Transparent Pricing section | REMOVED | Entire section deleted (redundant — pricing is in main index.html) |
| Extras section | DONE | Complete Water Sports Experience grid |
| Trust logos | DONE | RFEM, CSD, UIM, ISO certifications |
| Page-specific CSS | DONE | All styling is inline `<style>` block |

#### `terms.html` (650 lines) — Terms, Conditions & Legal
| Section | Status | Notes |
|---------|--------|-------|
| Legal Notice | DONE | Company info, NIF, registered office |
| Terms & Conditions | DONE | Full terms for services |
| Privacy Policy | DONE | GDPR-compliant privacy policy |
| Cancellation Policy | DONE | 24h free cancellation, weather guarantee |
| Cookie Policy | DONE | Cookie usage explanation |
| Sticky navigation tabs | DONE | Tab bar to jump between legal sections |

#### `weather-policy.html` (356 lines) — Weather & Cancellation Policy
| Feature | Status | Notes |
|---------|--------|-------|
| Hero section | DONE | Gradient header |
| Weather criteria | DONE | Visual grid showing wind/wave/visibility thresholds |
| Cancellation timeline | DONE | Step-by-step process |
| Refund options | DONE | Full refund or free reschedule |
| AEMET/State Ports reference | DONE | Data sources mentioned |

#### `404.html` (179 lines) — Custom 404 Page
| Feature | Status | Notes |
|---------|--------|-------|
| Design | DONE | Dark theme, gradient 404 text, wave animation |
| Navigation | DONE | "Back to Shore" (home) + "WhatsApp Us" buttons |
| SEO | DONE | noindex, nofollow |
| **Server configuration** | UNKNOWN | Needs server config (e.g., .htaccess or hosting rules) to serve this page on 404 |

#### `offline.html` (107 lines) — PWA Offline Fallback
| Feature | Status | Notes |
|---------|--------|-------|
| Design | DONE | Friendly message, wave animation, phone number |
| Retry button | DONE | Reloads page |
| Contact info | DONE | Direct phone link |

---

### JAVASCRIPT FILES

#### `script.js` (564 lines) — Main JavaScript
| Feature | Status | Notes |
|---------|--------|-------|
| Navigation (scroll, mobile toggle, active link) | DONE | |
| Smooth scroll for anchor links | DONE | |
| Animated stats counter | DONE | IntersectionObserver-based |
| Swiper initialization (testimonials + jetski carousels) | DONE | |
| Gallery lightbox | DONE | Open/close/navigate with keyboard support |
| FAQ accordion | DONE | |
| Activity category filter | DONE | |
| Back to top button | DONE | |
| Cookie consent banner | DONE | Accept/Decline with localStorage |
| Service Worker registration | DONE | |
| Image lazy loading (data-src) | DONE | But most images use native `loading="lazy"` attribute instead |
| Live weather widget (Open-Meteo API) | DONE | No API key required |
| Console easter egg | DONE | Fun branding message |
| Debounce/throttle utilities | DONE | Defined but **not used anywhere** |
| Card click-through handler | DONE | Makes service/jetski cards fully clickable |
| **Notification function** | UNKNOWN | `showNotification()` called in cookie accept but **function not defined in script.js** |

#### `jetski-anim.js` (457 lines) — Jet Ski Hero Animation
| Feature | Status | Notes |
|---------|--------|-------|
| Canvas-based particle water effect | DONE | Real Yamaha photo as masked sprite + 600 particles |
| Physics (wave bob, rooster spray, mist, foam) | DONE | |
| IntersectionObserver visibility gating | DONE | |
| prefers-reduced-motion respect | DONE | |
| **LOADED IN HTML?** | **NOT LOADED** | File exists but is **NOT referenced** in any HTML `<script>` tag. README says "Legacy animation file (unused)" |

#### `sw.js` (176 lines) — Service Worker
| Feature | Status | Notes |
|---------|--------|-------|
| Cache versioning | DONE | `marbellajetski-v36-weather-fix` |
| Asset pre-caching | DONE | 30+ URLs cached on install |
| Network-first for local files | DONE | HTML/CSS/JS always fetched from network first |
| Cache-first for CDN assets | DONE | Fonts, icons, libraries |
| Offline fallback | DONE | Serves offline.html for navigation requests |
| API bypass (weather) | DONE | open-meteo.com requests skip cache |
| Background sync stub | PARTIAL | Event listener exists but only does `console.log` — **not functional** |
| Push notification handler | PARTIAL | Event listener exists but **no push subscription setup** — non-functional |
| **Cached files mismatch** | BUG | Cache list references `/es/index.html` but NOT `/fr/`, `/nl/`, `/es/booking.html`, `/es/weather-policy.html` |

---

### CSS

#### `styles.css` (~3621 lines) — Main Stylesheet
| Feature | Status | Notes |
|---------|--------|-------|
| CSS custom properties (variables) | DONE | Comprehensive color, typography, spacing system |
| Reset & base styles | DONE | |
| Navigation styles | DONE | Fixed, transparent→solid on scroll, mobile hamburger |
| Hero section | DONE | Video background, overlay, responsive |
| Services grid | DONE | Cards with hover effects |
| USP/Why Choose Us grid | DONE | |
| Jet Ski section | DONE | Split layout with carousel |
| Water Sports grid | DONE | Activity cards with badges |
| Yacht section | DONE | Fleet cards |
| About section | DONE | Image stack with badge |
| Video section | DONE | Grid layout |
| Gallery grid | DONE | Masonry-like with large/tall/wide variants |
| Lightbox | DONE | Fullscreen overlay |
| Testimonials | DONE | Swiper-styled cards |
| Booking CTA | DONE | |
| FAQ accordion | DONE | |
| Contact section | DONE | Grid with map |
| Footer | DONE | 4-column grid |
| Floating WhatsApp | DONE | Fixed positioning with pulse animation |
| Back to top | DONE | |
| Cookie banner | DONE | |
| Summer banner | DONE | |
| Responsive breakpoints | DONE | Mobile, tablet, desktop queries |
| Dark mode | NOT DONE | No dark mode support |
| Print styles | NOT DONE | No print stylesheet |
| **about-daniel styles** | NOT IN styles.css | All about-daniel.html styles are **inline** (massive `<style>` block) |
| **booking.html styles** | NOT IN styles.css | All booking-specific styles are **inline** |
| **terms.html styles** | NOT IN styles.css | Inline styles |
| **weather-policy.html styles** | NOT IN styles.css | Inline styles |

---

### LOCALIZED PAGES

#### `/es/index.html` (1358 lines) — Spanish Homepage
| Feature | Status | Notes |
|---------|--------|-------|
| Full Spanish translation | DONE | All content translated |
| SEO (meta, OG, JSON-LD) | DONE | Spanish-specific |
| Hreflang tags | PARTIAL | EN and ES — **FR/NL missing** |
| Same sections as EN | DONE | All sections mirrored |
| CSS/JS references | DONE | Points to `../styles.css`, `../script.js` |
| Language selector in nav | PARTIAL | Links to EN version — **no FR/NL links** |
| jetski-anim.js | NOT LOADED | Same as EN — not referenced |

#### `/es/booking.html` (1152 lines) — Spanish Booking Page
| Feature | Status | Notes |
|---------|--------|-------|
| Full Spanish translation | DONE | All labels/options in Spanish |
| Same booking wizard | DONE | 4-step process |
| Same limitations as EN booking | SAME | No payment processing, WhatsApp-based |
| Time slots | BUG | Same issue — only morning slots (10:00-14:00) |

#### `/es/weather-policy.html` (348 lines) — Spanish Weather Policy
| Feature | Status | Notes |
|---------|--------|-------|
| Full Spanish translation | DONE | |

#### `/fr/index.html` (1337 lines) — French Homepage
| Feature | Status | Notes |
|---------|--------|-------|
| Full French translation | DONE | All content translated |
| SEO (meta, OG, JSON-LD) | DONE | French-specific, proper hreflang (EN/ES/FR/NL) |
| **Booking page (FR)** | **NOT DONE** | No `/fr/booking.html` exists |
| **Weather policy (FR)** | **NOT DONE** | No `/fr/weather-policy.html` exists |
| **Terms page (FR)** | **NOT DONE** | No `/fr/terms.html` exists |
| **About page (FR)** | **NOT DONE** | No `/fr/about-daniel.html` exists |

#### `/nl/index.html` (1322 lines) — Dutch Homepage
| Feature | Status | Notes |
|---------|--------|-------|
| Full Dutch translation | DONE | All content translated |
| SEO (meta, OG, JSON-LD) | DONE | Dutch-specific, proper hreflang (EN/ES/FR/NL) |
| **Booking page (NL)** | **NOT DONE** | No `/nl/booking.html` exists |
| **Weather policy (NL)** | **NOT DONE** | No `/nl/weather-policy.html` exists |
| **Terms page (NL)** | **NOT DONE** | No `/nl/terms.html` exists |
| **About page (NL)** | **NOT DONE** | No `/nl/about-daniel.html` exists |

---

### OTHER FILES

#### `manifest.json` — PWA Manifest
| Feature | Status | Notes |
|---------|--------|-------|
| App name/description | DONE | |
| Icons | PARTIAL | Uses inline SVG emoji (🌊) for main icon + WP-hosted PNG. **No proper local icon files** (192x192, 512x512) |
| Shortcuts | DONE | Book Now, WhatsApp, Services |
| Display mode | DONE | standalone |
| Theme/background colors | DONE | |

#### `serve.ps1` (69 lines) — Local PowerShell Server
| Feature | Status | Notes |
|---------|--------|-------|
| HTTP listener on port 8000 | DONE | |
| MIME type mapping | DONE | HTML, CSS, JS, JSON, images, fonts |
| 404 handling | DONE | Returns 404.html or plain 404 |
| Directory index support | DONE | Serves index.html for directories |

#### `README.md` (130 lines) — Project Documentation
| Feature | Status | Notes |
|---------|--------|-------|
| Project structure | DONE | File listing |
| Run locally instructions | DONE | 3 options: Live Server, Python, Node |
| Mentions `bg.jpg` | BUG | File doesn't exist in workspace |
| Lists `jetski-anim.js` as "unused" | DONE | Confirms it's legacy |

---

### ASSETS

#### `assets/media/photos/` — EMPTY
| Status | Notes |
|--------|-------|
| **EMPTY** | Folder exists but contains **zero files**. All photos are externally hosted on `marbellajetski.com/wp-content/uploads/` |

#### `assets/media/racing/` — Racing Media (12 files)
| File | Type | Used In |
|------|------|---------|
| circuit-race-benalmadena.jpg | Photo | UNKNOWN — not referenced in any HTML |
| copa-del-rey-parking.jpg | Photo | UNKNOWN — not referenced |
| daniel-pose.jpg | Photo | about-daniel.html story section |
| international-basque-cup.mp4 | Video | UNKNOWN — not referenced |
| promo-racing-video.mp4 | Video | UNKNOWN — not referenced |
| promo-racing.jpg | Photo | index.html gallery + video poster + navbar logo + footer logo |
| race-start-1.mp4 | Video | UNKNOWN — not referenced |
| racing-benalmadena-1.jpg | Photo | index.html gallery |
| racing-circuit-benidorm.png | Photo | index.html gallery |
| racing-rallyjet-2.jpg | Photo | UNKNOWN — not referenced |
| racing-rallyjet-castellon.mp4 | Video | UNKNOWN — not referenced |
| racing-yamaha-gp1800-cadiz.jpg | Photo | UNKNOWN — not referenced |

#### `assets/media/videos/` — Promo Videos (8 files)
| File | Used In |
|------|---------|
| promo-marbella-1.mp4 | index.html video section |
| promo-marbella-2.mp4 | index.html video section |
| promo-marbella-3.mp4 | index.html video section |
| promo-marbella-4.mp4 | index.html video section |
| promo-marbella-5.mp4 | **NOT USED** — not referenced |
| promo-marbella-6.mp4 | **NOT USED** — not referenced |
| promo-sotogrande-1.mp4 | **NOT USED** — not referenced |
| promo-sotogrande-2.mp4 | **NOT USED** — not referenced |

#### `VIDEOS FOTOS WEB/` — Raw Media Folder
| Status | Notes |
|--------|-------|
| UNKNOWN | Folder exists. Likely contains source photos/videos for the website. Contents not audited (raw assets, not code). |

---

## FUNCTIONALITY SUMMARY

### FULLY WORKING (DONE)
1. English homepage with all sections (hero, services, jet ski, water sports, yachts, about, videos, gallery, testimonials, FAQ, contact, footer)
2. Spanish homepage (full translation)
3. French homepage (full translation)
4. Dutch homepage (full translation)
5. Booking wizard UI (4-step form with activity selection, date/time, personal info, payment options)
6. Spanish booking page
7. Terms & conditions page (EN)
8. Weather policy page (EN + ES)
9. Custom 404 page
10. Offline fallback page (PWA)
11. Live weather widget (Open-Meteo API, no key needed)
12. Photo gallery with lightbox
13. Testimonials carousel (Swiper)
14. Jet ski image carousels (Swiper)
15. FAQ accordion
16. Activity category filtering
17. Animated stat counters
18. Cookie consent banner
19. Service Worker caching (offline support)
20. Navigation (fixed, scroll effect, mobile hamburger)
21. WhatsApp integration (floating button + multiple CTAs)
22. Google Maps embed
23. Social media links (Facebook, Instagram, TikTok, YouTube, TripAdvisor)
24. Local dev server (serve.ps1)
25. Skip-to-content accessibility link
26. Structured data (JSON-LD) for Google rich results
27. PWA manifest with app shortcuts

### PARTIALLY WORKING (PARTIAL)
1. **Payment processing** — UI exists (card/PayPal/on-site options) but NO actual payment integration. Booking is submitted via WhatsApp message only.
2. **Booking confirmation** — Generates a reference number but it's a random string with no backend storage. No email confirmation sent.
3. **Service Worker background sync** — Event listener exists but only logs to console. Not functional.
4. **Push notifications** — Handler exists in SW but no subscription mechanism. Non-functional.
5. **Language selector** — EN↔ES in navbar. FR and NL exist as pages but are NOT accessible from navigation (no language picker for FR/NL).
6. **Hreflang tags** — EN index.html only declares EN+ES. FR/NL index.html correctly declare all 4. Inconsistent.
7. **Time slot availability** — Booking page only shows 10:00-14:00 slots despite 11:00-20:00 business hours.
8. **PWA icons** — Uses emoji SVG and remote PNG. No proper local icon files at required sizes.

### NOT DONE
1. **Payment gateway integration** (Stripe, PayPal, Redsys, etc.)
2. **Backend/database** — No server-side code. No booking storage. No admin panel.
3. **Email notifications** — No email sending (no form submission backend)
4. **French booking page** (`/fr/booking.html`)
5. **French terms page** (`/fr/terms.html`)
6. **French weather policy** (`/fr/weather-policy.html`)
7. **French about page** (`/fr/about-daniel.html`)
8. **Dutch booking page** (`/nl/booking.html`)
9. **Dutch terms page** (`/nl/terms.html`)
10. **Dutch weather policy** (`/nl/weather-policy.html`)
11. **Dutch about page** (`/nl/about-daniel.html`)
12. **Spanish terms page** (`/es/terms.html`)
13. **Spanish about page** (`/es/about-daniel.html`)
14. **Google Analytics / tracking** — No analytics code found
15. **Google Tag Manager** — Not present
16. **Facebook Pixel** — Not present
17. **Availability calendar** — No real-time availability system
18. **Review aggregation** — Testimonials are hardcoded, not pulled from Google/TripAdvisor API
19. **Dark mode** — No dark mode toggle or media query support
20. **Print stylesheet** — No print CSS
21. **Sitemap.xml** — NOT FOUND
22. **robots.txt** — NOT FOUND
23. **.htaccess / server config** — NOT FOUND (needed for 404 routing, redirects, HTTPS enforcement)
24. **Local PWA icons** (192x192, 512x512 PNG files)
25. **Image optimization** — No local image files; all served from WP. No WebP/AVIF optimization pipeline.
26. **Contact form** — No contact form (all contact is via WhatsApp/phone/email links)
27. **Blog/content section** — Not present
28. **Instagram feed embed** — Not present (only link to profile)

### BUGS & ISSUES
1. **booking.html time slots** — Only 10:00-14:00 available. Missing 14:30-19:30 slots for actual business hours (11:00-20:00)
2. **`showNotification()` undefined** — Called in cookie accept handler but function is never defined
3. **README references `bg.jpg`** — File doesn't exist in workspace
4. **Service Worker cache list** — Doesn't include FR/NL pages, ES subpages, or local video/racing assets
5. **`assets/media/photos/` empty** — Folder exists but has no files
6. **5 unused racing assets** — `circuit-race-benalmadena.jpg`, `copa-del-rey-parking.jpg`, `daniel-pose.jpg`, `racing-rallyjet-2.jpg`, `racing-yamaha-gp1800-cadiz.jpg` — not referenced in any page
7. **4 unused racing videos** — `international-basque-cup.mp4`, `promo-racing-video.mp4`, `race-start-1.mp4`, `racing-rallyjet-castellon.mp4`
8. **4 unused promo videos** — `promo-marbella-5.mp4`, `promo-marbella-6.mp4`, `promo-sotogrande-1.mp4`, `promo-sotogrande-2.mp4`
9. **about-daniel.html massive inline CSS** — All styles inline instead of in styles.css. Same for booking.html, terms.html, weather-policy.html
10. **Inconsistent footer** — booking.html footer has fewer social links and no ISO cert images vs index.html
11. **Spanish page cache version mismatch** — ES pages reference `styles.css?v=2026020923` while index.html uses `?v=2026020924`
12. **jetski-anim.js** — 457 lines of code exist but file is not loaded anywhere. Dead code.
13. **`debounce()` and `throttle()` in script.js** — Defined but never used
14. **Gallery images array mismatch** — `galleryImages[]` in script.js doesn't perfectly match the gallery HTML image sources
15. **Mixed content dependency** — All images hosted on `marbellajetski.com` WP installation. Site will show broken images if WP goes down.

---

## ARCHITECTURE NOTES

### Image Hosting Strategy
- **ALL product/service images** are hosted on `marbellajetski.com/wp-content/uploads/` (WordPress media library)
- **Local assets** are only racing photos/videos in `assets/media/racing/` and promo videos in `assets/media/videos/`
- **Risk:** Site appearance depends entirely on the WordPress installation being online
- **`assets/media/photos/`** is empty — appears intended for local photo storage but never populated

### CSS Architecture
- `styles.css` (3606 lines) — shared global styles for all pages
- Each sub-page (booking, about-daniel, terms, weather-policy) has **massive inline `<style>` blocks** — NOT consolidated into styles.css
- No CSS preprocessor (SASS/LESS)
- No CSS minification
- No CSS modules or BEM methodology (just descriptive class names)

### JavaScript Architecture
- `script.js` (564 lines) — all shared functionality
- `booking.html` — has its own `<script>` block (400+ lines) for booking wizard logic
- `about-daniel.html` — UNKNOWN (3934 lines total, likely has inline JS)
- `jetski-anim.js` (457 lines) — NOT LOADED. Legacy/unused.
- No JavaScript bundling or minification
- No framework (pure vanilla JS)
- Depends on CDN libraries: AOS, Swiper

### SEO Score Estimate
- **Strong:** Schema.org structured data, OG tags, canonical URLs, meta descriptions, semantic HTML
- **Weak:** Missing sitemap.xml, robots.txt, no analytics, incomplete hreflang, no breadcrumbs

### Performance Concerns
- Hero loads a 4K video from Pexels CDN (potential slow first paint)
- 30+ external image URLs from WP (not optimized, no srcset/sizes)
- Multiple CDN dependencies (Google Fonts, Font Awesome, AOS, Swiper)
- No critical CSS inlining
- No JS/CSS minification
- Large inline style blocks on sub-pages

---

## CHANGE LOG

| Date | Prompt # | Changes Made |
|------|----------|-------------|
| 2026-02-10 | #1 | Initial full audit — Blueprint created. No code changes. |
| 2025-07-14 | #3 | **32-step UX/UI overhaul applied.** See detailed list below. |

### 32-Step Edit Log (Prompt #3)

**index.html + styles.css (Steps 1–21)**
1. **Hero font change** — `.title-highlight` switched from Playfair Display italic to Space Grotesk 700 normal. Google Fonts link updated.
2. **Navbar/banner white line removed** — `.navbar.scrolled { border-bottom: none }` + `.summer-banner { border-top: none; box-shadow: none }`
3. **Summer discount 15% → 10%** — Banner text updated.
4. **Weather widget CSS fix** — `.weather-box { overflow: hidden; pointer-events: auto }` to stop overflow/click issues.
5. **USP "Led by a Champion" → "Premium Jet Ski Experiences"** — Card title, text and icon updated.
6. **USP "Direct Sea Access"** — Description rewritten in English (was Spanish "sin esperas").
7. **USP "Professional Photos"** — Removed "30-50 edited photos for just €25"; replaced with "high-quality digital photos".
8. **Excursion minimum rule** — Added prominent gold warning box: "Minimum 2 jet skis required for all excursions".
9. **Water Skiing image** — Replaced with Pexels #1837687.
10. **Air Stream image** — Replaced with Pexels #13315556.
11. **Pedal Boats image** — Replaced with Pexels #26646652.
12. **SUP image** — Replaced with Pexels #6931315.
13. **Video zoom fix** — Added `.video-wrapper video { position: absolute; … object-fit: cover }` rule.
14. **FAQ: Payment methods** — Removed Amex & PayPal mention.
15. **FAQ: Deposit** — Removed "30% deposit" sentence.
16. **FAQ: Season dates** — "April" → "May".
17. **FAQ: Photos** — "included free of charge" → "available".
18. **FAQ: Safety** — Removed "AED defibrillator" mention.
19. **Email bulk replacement** — `danistiers@hotmail.com` → `jetskimarbella@gmail.com` across 10 files (index.html, booking.html, terms.html, weather-policy.html, script.js, es/booking.html, es/index.html, es/weather-policy.html, fr/index.html, nl/index.html).
20. **Header & footer logos** — Changed from WP-hosted logo to `assets/media/racing/promo-racing.jpg`.
21. **Responsiveness audit** — Confirmed existing breakpoints are adequate; no changes needed.

**about-daniel.html (Steps 22–32)**
22. **Yamaha text removal** — "Yamaha" removed from story paragraph; replaced with "high-performance jet skis".
23. **"Why Train with a Champion" section removed** — Entire ~100-line section replaced with HTML comment.
24. **Story image replaced** — `About_us.jpg` → `assets/media/racing/daniel-pose.jpg`.
25. **Section rename** — "The Champion's Journey" → "The Racing Journey".
26. **Hero badge updated** — Added "• Campeón de Andalucía 2025"; floating medal year 2024 → 2025.
27. **Medals removed** — Medal summary row (4 Gold, 1 Silver, 2 Bronze) + floating gold-medal/champion-badge elements removed.
28. **Racing video text rewrite** — Subtitle rewritten to remove "4x national champion" phrasing.
29. **Racing Masterclass text rewrite** — Description rewritten to remove "4x Spanish National Champion" phrase.
30. **Extras section** — "2024-25 Yamaha VX jet skis" → "latest jet skis".
31. **Racing photos verified** — All use local `assets/media/racing/` paths; "Yamaha GP1800 — Cádiz" overlay → "GP1800 — Cádiz".
32. **Hero stat-cards removed** — Animated counters (7 National Medals, 4 Gold Titles, Est. 1998) removed. Yamaha trust logo → RFEM.

---

## PHASE 2 CHANGELOG — 2025-07-15

### Brand Refocus
- Website now emphasises **Marbella JetSki as a company** — Daniel is presented as "Professional Pilot & Instructor" rather than the centre of the brand
- About section in index.html rewritten: company-first, Daniel mentioned as pilot who offers racing lessons
- Story section in about-daniel.html: label changed to "Meet Our Professional Pilot", heading changed to "Professional Pilot & Instructor"

### USP Section
- "Direct Sea Access" USP card → **"GPS-Tracked Fleet (OtoTrak)"** — highlights live GPS tracking safety feature

### Jet Ski Circuit Pricing
- Removed 2-hour circuit option (was €330)
- New pricing: 20min €70, 30min €90 (★Most Popular), 1h €120
- Maximum circuit duration: 1 hour

### Jet Ski Excursions
- New pricing table format: 1h €170/jet ski (★Most Popular), 2h €330/jet ski
- Updated constraint: "Minimum 2 jet skis required. Maximum 4 jet skis per excursion."
- Per-jet-ski pricing clarified (1-2 persons per jet ski)

### Water Sports
- **Added Double Kayaks** — €30/1h, 2 people, Easy difficulty, relaxed/family/individual category
- Water skiing photo replaced with own photo (`ski1.jpg` → `waterski-action.jpg`)

### Yacht Section — Complete Rebuild
- Replaced 3 generic yacht cards + flat pricing table with **5 real boats from BARCOS PDFs**:
  1. **Sea Ray 240 Sundeck** — 8m, 12 guests, Bluetooth, from €280/h
  2. **Rinker 296 Captiva** — 9.4m, 8 guests, Puerto Banús Dock 5, from €250/h
  3. **Cranchi 39** — 12.3m, 9 guests, lower cabin, from €380/h
  4. **Azimut 39 Fly** — 12.3m, 12 guests, flybridge, from €400/h
  5. **Catamaran Bali 4.0 (2020)** — 12.5m, 12+crew, 4 cabins, from €750/2h
- Each card has expandable pricing (click "Full Prices" to expand/collapse)
- All boats credited to Marbella Ocean Boats, Puerto Banús
- Added yacht action photos from BARCOS folder as local images

### Navigation
- Added **"Racing"** link between Yachts and About & Lessons (links to `about-daniel.html#racing-videos`)
- Updated both index.html and about-daniel.html navbars

### About Daniel Page Cleanup
- **Deleted "Professional Racing Begins"** timeline entry (2010s)
- **Deleted "Championship Medal Tally"** section entirely
- **Deleted "Ready to Ride with a Champion?"** CTA → replaced with company-focused "Book Your Water Experience"
- **Deleted "Transparent Pricing"** section entirely (redundant with index.html)
- Racing lesson cards updated: Basic 30min €299, Racing Experience 1h €499, Masterclass 2h €699

### Media
- Copied new photos to `assets/media/photos/`: blue-jetski.jpg, high-res-jetski.jpg, watersports-beach.webp, waterski-action.jpg, waterski-action-2.jpg, yacht-action-1.jpg, yacht-action-2.jpg
- Copied new videos: promo-jetski-action.mp4, promo-jetski-ride.mp4
- Deleted Sotogrande videos: promo-sotogrande-1.mp4, promo-sotogrande-2.mp4

### Gallery
- Expanded from 14 to **20 images** — added 6 own photos (blue jetski, high-res action, 2 waterski, 2 yacht action shots)
- Updated lightbox array in script.js
- Gallery grid changed from fixed 2 rows to `grid-auto-rows` for dynamic row count

### CSS
- Added yacht expandable pricing styles (`.yacht-pricing-inline`, `.yacht-toggle-btn`, `.yacht-price-details`, `.yacht-price-row`)
- Updated `.yacht-card.featured` scale from 1.05 to 1.02 (5 cards need less dramatic scaling)
- Gallery grid `grid-template-rows` → `grid-auto-rows: 240px`

---

*This blueprint should be referenced and updated with every future prompt.*
