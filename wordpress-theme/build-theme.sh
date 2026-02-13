#!/bin/bash
# ================================================================
#  BUILD WORDPRESS THEME
#  Converts the static Marbella JetSki site into a WordPress theme.
#
#  Extracts page content from HTML files, copies assets, and
#  prepares everything for a one-click WP theme installation.
#
#  Usage:  cd /path/to/marbellajetski && bash wordpress-theme/build-theme.sh
# ================================================================

set -e

# Paths
STATIC_DIR="$(cd "$(dirname "$0")/.." && pwd)"
THEME_DIR="$STATIC_DIR/wordpress-theme/marbellajetski"
CONTENT_DIR="$THEME_DIR/page-content"

echo "🚀 Building Marbella JetSki WordPress Theme..."
echo "   Static site:  $STATIC_DIR"
echo "   Theme output: $THEME_DIR"
echo ""

# ── 1. CREATE DIRECTORIES ──
mkdir -p "$CONTENT_DIR"
mkdir -p "$THEME_DIR/assets/css"
mkdir -p "$THEME_DIR/assets/js"

# ── 2. COPY ASSETS ──
echo "📁 Copying assets..."
# CSS
cp "$STATIC_DIR/styles.css" "$THEME_DIR/assets/css/main.css"
echo "   ✅ styles.css → assets/css/main.css"

# JS
cp "$STATIC_DIR/script.js" "$THEME_DIR/assets/js/script.js"
echo "   ✅ script.js → assets/js/script.js"

if [ -f "$STATIC_DIR/jetski-anim.js" ]; then
    cp "$STATIC_DIR/jetski-anim.js" "$THEME_DIR/assets/js/jetski-anim.js"
    echo "   ✅ jetski-anim.js → assets/js/jetski-anim.js"
fi

# Media (photos, videos, racing, boats)
if [ -d "$STATIC_DIR/assets/media" ]; then
    cp -R "$STATIC_DIR/assets/media" "$THEME_DIR/assets/"
    echo "   ✅ assets/media/ → copied (photos, videos, racing)"
fi

# Boats pages (for detail pages)
if [ -d "$STATIC_DIR/boats" ]; then
    cp -R "$STATIC_DIR/boats" "$THEME_DIR/assets/"
    echo "   ✅ boats/ → copied"
fi

echo ""

# ── 3. EXTRACT PAGE CONTENT ──
# Skip extraction if page-content files already exist (they contain {{placeholder}} tokens)
# Use --force flag to re-extract from static HTML (WARNING: overwrites placeholders!)
if [ -f "$CONTENT_DIR/home.html" ] && [ "$1" != "--force" ]; then
    echo "📄 Page content already exists — skipping extraction (preserving Customizer placeholders)"
    echo "   To re-extract from static HTML, run: bash build-theme.sh --force"
    echo ""
else

echo "📄 Extracting page content from static HTML..."
if [ "$1" == "--force" ]; then
    echo "   ⚠️  --force flag used — overwriting existing page-content files"
fi

# Function: Extract content between <main ...> and </main> tags
extract_main_content() {
    local src="$1"
    local dest="$2"
    local label="$3"
    
    if [ ! -f "$src" ]; then
        echo "   ⚠️  File not found: $src"
        return
    fi
    
    # Extract everything between first <main and </main> (inclusive content, exclusive tags)
    sed -n '/<main/,/<\/main>/p' "$src" | sed '1d;$d' > "$dest"
    
    echo "   ✅ $label → $(basename "$dest") ($(wc -l < "$dest" | tr -d ' ') lines)"
}

# Function: Extract inline <style> blocks from <head> section
extract_styles() {
    local src="$1"
    local dest="$2"
    local label="$3"
    
    if [ ! -f "$src" ]; then
        return
    fi
    
    # Extract all <style>...</style> blocks from the file (before <body>)
    sed -n '/<head/,/<\/head>/p' "$src" | sed -n '/<style/,/<\/style>/p' > "$dest"
    
    # Only keep if non-empty
    if [ -s "$dest" ]; then
        echo "   ✅ $label styles → $(basename "$dest") ($(wc -l < "$dest" | tr -d ' ') lines)"
    else
        rm -f "$dest"
    fi
}

echo "📄 Extracting page content..."

# Homepage
extract_main_content "$STATIC_DIR/index.html" "$CONTENT_DIR/home.html" "index.html"

# Extract the boat modal (it's outside <footer>, between </footer> and </body>)
sed -n '/<\/footer>/,/<\/body>/p' "$STATIC_DIR/index.html" | sed '1d;$d' > "$CONTENT_DIR/home-modal.html"
MODAL_LINES=$(wc -l < "$CONTENT_DIR/home-modal.html" | tr -d ' ')
echo "   ✅ Boat modal → home-modal.html ($MODAL_LINES lines)"

# Booking
extract_main_content "$STATIC_DIR/booking.html" "$CONTENT_DIR/booking.html" "booking.html"
extract_styles "$STATIC_DIR/booking.html" "$CONTENT_DIR/booking-styles.html" "booking.html"

# Also extract inline <style> blocks from <body> section of booking (it has styles inside body)
# Get all style blocks from the entire file
sed -n '/<style/,/<\/style>/p' "$STATIC_DIR/booking.html" > "$CONTENT_DIR/booking-styles.html" 2>/dev/null
if [ -s "$CONTENT_DIR/booking-styles.html" ]; then
    echo "   ✅ booking.html all styles → booking-styles.html"
fi

# Lessons
extract_main_content "$STATIC_DIR/lessons.html" "$CONTENT_DIR/lessons.html" "lessons.html"
sed -n '/<style/,/<\/style>/p' "$STATIC_DIR/lessons.html" > "$CONTENT_DIR/lessons-styles.html" 2>/dev/null
if [ -s "$CONTENT_DIR/lessons-styles.html" ]; then
    echo "   ✅ lessons.html styles → lessons-styles.html"
fi

# About Us
extract_main_content "$STATIC_DIR/about-us.html" "$CONTENT_DIR/about-us.html" "about-us.html"
sed -n '/<style/,/<\/style>/p' "$STATIC_DIR/about-us.html" > "$CONTENT_DIR/about-us-styles.html" 2>/dev/null
if [ -s "$CONTENT_DIR/about-us-styles.html" ]; then
    echo "   ✅ about-us.html styles → about-us-styles.html"
fi

# Terms
extract_main_content "$STATIC_DIR/terms.html" "$CONTENT_DIR/terms.html" "terms.html"
sed -n '/<style/,/<\/style>/p' "$STATIC_DIR/terms.html" > "$CONTENT_DIR/terms-styles.html" 2>/dev/null
if [ -s "$CONTENT_DIR/terms-styles.html" ]; then
    echo "   ✅ terms.html styles → terms-styles.html"
fi

# Weather Policy (no <main> tag — extract between </nav> and <footer>)
if grep -q '<main' "$STATIC_DIR/weather-policy.html"; then
    extract_main_content "$STATIC_DIR/weather-policy.html" "$CONTENT_DIR/weather-policy.html" "weather-policy.html"
else
    sed -n '/<\/nav>/,/<footer/p' "$STATIC_DIR/weather-policy.html" | sed '1d;$d' > "$CONTENT_DIR/weather-policy.html"
    echo "   ✅ weather-policy.html → weather-policy.html ($(wc -l < "$CONTENT_DIR/weather-policy.html" | tr -d ' ') lines) [nav-to-footer]"
fi
sed -n '/<style/,/<\/style>/p' "$STATIC_DIR/weather-policy.html" > "$CONTENT_DIR/weather-policy-styles.html" 2>/dev/null
if [ -s "$CONTENT_DIR/weather-policy-styles.html" ]; then
    echo "   ✅ weather-policy.html styles → weather-policy-styles.html"
fi

echo ""

fi  # end of extraction skip check

# ── 4. CREATE SCREENSHOT ──
if [ ! -f "$THEME_DIR/screenshot.png" ]; then
    echo "📸 Note: Add a screenshot.png (1200×900) to the theme folder for WP Admin preview."
fi

# ── 5. CREATE THEME ZIP (for easy upload) ──
echo "📦 Creating theme ZIP..."
cd "$STATIC_DIR/wordpress-theme"
zip -r "marbellajetski.zip" "marbellajetski/" -x "*.DS_Store" > /dev/null 2>&1
echo "   ✅ marbellajetski.zip created ($(du -sh marbellajetski.zip | cut -f1))"

echo ""
echo "=============================================="
echo "  ✅ Theme build complete!"
echo "=============================================="
echo ""
echo "  Theme ZIP: wordpress-theme/marbellajetski.zip"
echo "  Theme Dir: wordpress-theme/marbellajetski/"
echo ""
echo "  Next steps:"
echo "  1. Upload marbellajetski.zip to WordPress → Appearance → Themes → Add New → Upload"
echo "  2. Activate the theme"
echo "  3. Create pages and assign templates (see SETUP-INSTRUCTIONS.md)"
echo ""
