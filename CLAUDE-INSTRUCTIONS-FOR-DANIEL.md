# Instructions for Claude on Daniel's Machine

## Overview

The website code has been fully audited and pushed to GitHub. Everything works **except the 8 video files** which are too large for GitHub (>100MB) and are excluded via `.gitignore`. Daniel has these videos locally on his machine. They need to be placed in the correct folders, then the site can be deployed to Vercel.

---

## Step 1: Pull the Latest Code

```bash
cd /path/to/marbellajetski
git pull origin main
```

---

## Step 2: Restore the 8 Missing Video Files

The videos are excluded from git (see `.gitignore`). Daniel needs to place them manually in the correct locations.

### Homepage Videos — "See Us in Action" section
These go in: `assets/media/videos/`

| # | Required Filename | Used In |
|---|---|---|
| 1 | `promo-marbella-1.mp4` | index.html + es/index.html |
| 2 | `promo-marbella-3.mp4` | index.html + es/index.html |
| 3 | `promo-marbella-5.mp4` | index.html + es/index.html |
| 4 | `promo-jetski-action.mp4` | index.html + es/index.html |

**Thumbnail posters already exist** in `assets/media/videos/thumbs/`:
- `promo-marbella-1-thumb.jpg`
- `promo-marbella-3-thumb.jpg`
- `promo-marbella-5-thumb.jpg`
- `promo-jetski-action-thumb.jpg`

### Lessons Page Videos — "Daniel in Competition" section
These go in: `assets/media/racing/`

| # | Required Filename | Used In |
|---|---|---|
| 5 | `promo-racing-video.mp4` | lessons.html (Featured + hero bg) |
| 6 | `international-basque-cup.mp4` | lessons.html |
| 7 | `racing-rallyjet-castellon.mp4` | lessons.html |
| 8 | `race-start-1.mp4` | lessons.html |

### Quick Check — Verify Files Are in Place

```bash
# Should list 4 mp4 files:
ls -la assets/media/videos/*.mp4

# Should list 4 mp4 files:
ls -la assets/media/racing/*.mp4
```

---

## Step 3: Deploy to Vercel (Temporary Hosting)

### Option A: Vercel CLI (Recommended)

```bash
# Install Vercel CLI if not already installed
npm install -g vercel

# Navigate to the project root
cd /path/to/marbellajetski

# Deploy (first time will ask you to link/create a project)
vercel

# For production deployment:
vercel --prod
```

Vercel will:
- Ask you to log in (if first time)
- Ask to link to an existing project or create new
- Choose: **"No" to link existing**, create new
- Set project name: `marbellajetski`
- Framework: **Other** (it's a static site, no framework)
- Root directory: `.` (current directory)
- Build command: leave empty (press Enter)
- Output directory: `.` (current directory)

### Option B: Vercel Dashboard (No CLI needed)

1. Go to https://vercel.com and sign in
2. Click **"Add New..."** → **"Project"**
3. Import the GitHub repo: `munyanyo92/marbellajetski`
4. Framework Preset: **Other**
5. Root Directory: `/`
6. Build Command: leave empty
7. Output Directory: `.`
8. Click **Deploy**

**IMPORTANT:** Since `.mp4` files are in `.gitignore`, Vercel won't get them from GitHub. For Vercel deployment **with videos**, use the CLI method (Option A) from Daniel's local machine where the videos exist — the CLI uploads ALL local files including those in `.gitignore`.

If using the GitHub import method (Option B), videos won't be included. In that case, you'd need to either:
- Remove the `.mp4` lines from `.gitignore`, force-add the videos with `git add -f`, commit and push
- Or use Vercel Blob Storage / external CDN for the video files

### Recommended approach: Use CLI from Daniel's machine

```bash
cd /path/to/marbellajetski
# Make sure all 8 .mp4 files are in place first
vercel --prod
```

This uploads everything from the local folder, including the .mp4 files that git ignores.

---

## Step 4: Verify the Deployment

After deploying, check these pages:

1. **Homepage** → Scroll to "See Us in Action" → All 4 videos should play
2. **Lessons page** (`/lessons.html`) → Scroll to "Daniel in Competition" → All 4 videos should play
3. **Booking page** → Test the booking form, check time slots (11:00–19:00)
4. **Spanish pages** (`/es/`) → Verify translations look correct
5. **Mobile** → Test on phone — nav toggle, touch targets, video playback

---

## Summary of What Was Fixed in This Audit

- **Critical JS bugs:** Added missing `showNotification()`, fixed `closeLightbox()` overflow bug, fixed duplicate window assignments
- **Booking logic:** `isBoatBooking()` now correctly detects yacht bookings (was broken → wrong deposit %), time slots expanded 11:00–19:00
- **Hreflang tags:** Added FR/NL alternates to index.html and es/index.html
- **Yacht links:** Fixed from `href="#"` to actual boat page URLs
- **Spanish translations:** 33+ untranslated English strings fixed in es/index.html
- **Navigation:** Rebuilt broken nav on weather-policy.html (EN + ES)
- **Logo sizes:** Fixed 45px→75px on ALL pages (7 files)
- **Mobile/tablet CSS:** Comprehensive responsive optimization (tablet 1024px, mobile 768px, small phone 480px, touch targets 44px, safe areas, landscape, print)
- **Service Worker:** Fixed cache bugs, added missing pages
- **Offline page:** Removed CDN dependency (works offline now)
- **WhatsApp emoji:** Fixed motorcycle 🏍️ → jet ski 🚤
- **Renamed:** `about-daniel.html` → `about-us.html`
