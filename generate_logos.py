"""
Logo Generator – Marbella JetSki
Generates 3 typography variations (A/B/C) with:
- White ring removed
- Clean transparent PNG (2048px)
- SVG vector versions
- Small-size favicon versions
- Preview HTML page
"""

import os, math, struct, zipfile, io
from pathlib import Path
from urllib.request import urlopen, Request
from PIL import Image, ImageDraw, ImageFont, ImageFilter
import numpy as np

BASE = Path(r"C:\Users\Usuario\Website Marbella Jetski")
LOGO_SRC = BASE / "assets" / "media" / "photos" / "logo-circular.png"
OUT_DIR = BASE / "assets" / "media" / "logos"
FONT_DIR = BASE / "assets" / "fonts"
OUT_DIR.mkdir(parents=True, exist_ok=True)
FONT_DIR.mkdir(parents=True, exist_ok=True)

# ─── STEP 1: Download Fonts ───────────────────────────────────
FONT_URLS = {
    "Montserrat-Black": "https://github.com/JulietaUla/Montserrat/raw/master/fonts/ttf/Montserrat-Black.ttf",
    "Montserrat-Bold": "https://github.com/JulietaUla/Montserrat/raw/master/fonts/ttf/Montserrat-Bold.ttf",
    "BarlowCondensed-ExtraBold": "https://raw.githubusercontent.com/google/fonts/main/ofl/barlowcondensed/BarlowCondensed-ExtraBold.ttf",
    "BarlowCondensed-Bold": "https://raw.githubusercontent.com/google/fonts/main/ofl/barlowcondensed/BarlowCondensed-Bold.ttf",
    "PlayfairDisplay-Bold": "https://raw.githubusercontent.com/google/fonts/main/ofl/playfairdisplay/PlayfairDisplay-Bold.ttf",
    "PlayfairDisplay-Regular": "https://raw.githubusercontent.com/google/fonts/main/ofl/playfairdisplay/PlayfairDisplay-Regular.ttf",
    "Oswald-Bold": "https://raw.githubusercontent.com/google/fonts/main/ofl/oswald/Oswald%5Bwght%5D.ttf",
}

# Fallback: system fonts
SYSTEM_FONTS = {
    "bold-sans": r"C:\Windows\Fonts\ariblk.ttf",
    "condensed": r"C:\Windows\Fonts\impact.ttf",
    "elegant": r"C:\Windows\Fonts\georgiab.ttf",
}

def download_fonts():
    fonts = {}
    for name, url in FONT_URLS.items():
        fpath = FONT_DIR / f"{name}.ttf"
        if fpath.exists():
            fonts[name] = str(fpath)
            continue
        try:
            print(f"  Downloading {name}...")
            req = Request(url, headers={"User-Agent": "Mozilla/5.0"})
            data = urlopen(req, timeout=15).read()
            fpath.write_bytes(data)
            fonts[name] = str(fpath)
            print(f"    OK ({len(data)} bytes)")
        except Exception as e:
            print(f"    FAILED: {e}")
    return fonts

print("=== Step 1: Downloading fonts ===")
downloaded_fonts = download_fonts()
print(f"  Downloaded: {list(downloaded_fonts.keys())}")

# Resolve font paths with fallbacks
def get_font(primary_key, fallback_system_key):
    if primary_key in downloaded_fonts:
        return downloaded_fonts[primary_key]
    fb = SYSTEM_FONTS.get(fallback_system_key, "")
    if os.path.exists(fb):
        return fb
    # Last resort: try to find any system font
    for sp in SYSTEM_FONTS.values():
        if os.path.exists(sp):
            return sp
    return None

FONTS = {
    "A_main": get_font("Montserrat-Black", "bold-sans"),
    "A_sub": get_font("Montserrat-Bold", "bold-sans"),
    "B_main": get_font("BarlowCondensed-ExtraBold", "condensed"),
    "B_sub": get_font("BarlowCondensed-Bold", "condensed"),
    "C_main": get_font("PlayfairDisplay-Bold", "elegant"),
    "C_sub": get_font("PlayfairDisplay-Regular", "elegant"),
}
print(f"  Font mapping: { {k: ('OK' if v else 'MISSING') for k,v in FONTS.items()} }")


# ─── STEP 2: Clean Original (Remove White Ring) ──────────────
print("\n=== Step 2: Removing white ring ===")

img_orig = Image.open(LOGO_SRC).convert("RGBA")
arr = np.array(img_orig)
h, w = arr.shape[:2]
cy, cx = h // 2, w // 2

# Create distance map from center
Y, X = np.ogrid[:h, :w]
dist = np.sqrt((X - cx)**2 + (Y - cy)**2).astype(np.float32)

# The white ring is at radius 229-246
# The navy content is inside radius ~228
# Strategy: make everything outside radius 228 transparent,
# with anti-aliased edge (smooth falloff from 228 to 229)

INNER_RADIUS = 228.0
FEATHER = 1.5  # pixels of anti-aliasing

# Create alpha mask
alpha_mask = np.clip((INNER_RADIUS + FEATHER - dist) / (FEATHER * 2), 0, 1)

# Apply mask: multiply existing alpha by our ring-removal mask
new_alpha = (arr[:, :, 3].astype(np.float32) * alpha_mask).astype(np.uint8)

# Also check for any white halo: for pixels at the very edge (r=226-229),
# if they're white (part of ring anti-aliasing), make them transparent too
for y_px in range(h):
    for x_px in range(w):
        d = dist[y_px, x_px]
        if 224 < d < 230:
            r, g, b = arr[y_px, x_px, :3]
            # If pixel is mostly white (ring edge), remove it
            if r > 200 and g > 200 and b > 200:
                new_alpha[y_px, x_px] = 0

arr_clean = arr.copy()
arr_clean[:, :, 3] = new_alpha
img_clean = Image.fromarray(arr_clean)

# Crop to bounding box of content (remove excess transparent space)
bbox = img_clean.getbbox()
if bbox:
    img_clean_cropped = img_clean.crop(bbox)
else:
    img_clean_cropped = img_clean

img_clean_cropped.save(OUT_DIR / "logo-clean-original.png")
print(f"  Saved clean original: {img_clean_cropped.size}")


# ─── STEP 3: Extract Graphic Region (JetSki + Waves) ─────────
print("\n=== Step 3: Extracting graphic region ===")

# The graphic (jetski + waves) is in the upper portion: roughly y=60-195 (in the 512px original)
# Text starts around y=200
# We'll extract the top graphic area as a cutout from the cleaned image

# Work with the UN-cropped clean version for consistent coordinates
graphic_region = arr_clean.copy()

# Zero out everything below y=195 (this removes text, keeps graphic)
graphic_region[195:, :, 3] = 0
# Also zero out pixels too far from center (outside navy area)
for y_px in range(h):
    for x_px in range(w):
        d = dist[y_px, x_px]
        if d > 225:
            graphic_region[y_px, x_px, 3] = 0

img_graphic = Image.fromarray(graphic_region)
graphic_bbox = img_graphic.getbbox()
if graphic_bbox:
    img_graphic_cropped = img_graphic.crop(graphic_bbox)
    print(f"  Graphic region: {img_graphic_cropped.size} (from bbox {graphic_bbox})")
else:
    print("  WARNING: No graphic region found")
    img_graphic_cropped = img_graphic

img_graphic_cropped.save(OUT_DIR / "logo-graphic-only.png")


# ─── STEP 4: Generate variations at 2048px ───────────────────
print("\n=== Step 4: Generating 3 variations ===")

SIZE = 2048
NAVY = (13, 27, 57)  # Main navy from the logo
NAVY_DARK = (10, 19, 50)  # Slightly darker navy
WHITE = (255, 255, 255)

def create_navy_circle_base(size):
    """Create a navy circle on transparent background."""
    img = Image.new("RGBA", (size, size), (0, 0, 0, 0))
    draw = ImageDraw.Draw(img)
    center = size // 2
    radius = int(size * 0.445)  # ~91% of half = matches inner navy circle proportion
    
    # Draw filled circle with anti-aliasing (use supersampling)
    ss = 4  # supersample factor
    ss_size = size * ss
    ss_img = Image.new("L", (ss_size, ss_size), 0)
    ss_draw = ImageDraw.Draw(ss_img)
    ss_center = ss_size // 2
    ss_radius = radius * ss
    ss_draw.ellipse(
        [ss_center - ss_radius, ss_center - ss_radius,
         ss_center + ss_radius, ss_center + ss_radius],
        fill=255
    )
    mask = ss_img.resize((size, size), Image.LANCZOS)
    
    # Create the colored circle
    navy_layer = Image.new("RGBA", (size, size), (*NAVY, 255))
    img.paste(navy_layer, mask=mask)
    
    return img, mask, center, radius

def load_font(font_path, size):
    """Load a font at specified size, with fallback."""
    if font_path and os.path.exists(font_path):
        try:
            return ImageFont.truetype(font_path, size)
        except:
            pass
    return ImageFont.load_default()

def center_text(draw, text, font, y, canvas_size, fill=WHITE):
    """Draw horizontally centered text."""
    bbox = draw.textbbox((0, 0), text, font=font)
    tw = bbox[2] - bbox[0]
    x = (canvas_size - tw) // 2
    draw.text((x, y), text, font=font, fill=(*fill, 255))
    return bbox[3] - bbox[1]  # return text height

def draw_wave_line(draw, y_center, width, canvas_size, amplitude=12, wavelength=80, thickness=3):
    """Draw a wavy decorative line."""
    points = []
    x_start = (canvas_size - width) // 2
    for x in range(width):
        y = y_center + int(amplitude * math.sin(2 * math.pi * x / wavelength))
        points.append((x_start + x, y))
    
    for i in range(len(points) - 1):
        draw.line([points[i], points[i + 1]], fill=(*WHITE, 180), width=thickness)

def draw_jetski_silhouette(draw, cx, cy, scale=1.0):
    """Draw a stylized jetski + rider silhouette."""
    s = scale
    # Jetski body (hull)
    hull_points = [
        (cx - 120*s, cy + 20*s),     # rear bottom
        (cx - 100*s, cy + 30*s),     # rear curve
        (cx - 40*s, cy + 35*s),      # bottom center
        (cx + 60*s, cy + 30*s),      # front bottom
        (cx + 130*s, cy + 10*s),     # front tip
        (cx + 120*s, cy - 5*s),      # front top
        (cx + 50*s, cy - 10*s),      # top front
        (cx - 20*s, cy - 5*s),       # top middle
        (cx - 80*s, cy + 5*s),       # top rear
        (cx - 120*s, cy + 10*s),     # rear top
    ]
    draw.polygon([(int(x), int(y)) for x, y in hull_points], fill=(*WHITE, 255))
    
    # Rider (simplified)
    # Body/torso
    rider_body = [
        (cx - 30*s, cy - 5*s),       # seat
        (cx - 25*s, cy - 50*s),      # back
        (cx - 10*s, cy - 70*s),      # shoulders
        (cx + 10*s, cy - 80*s),      # forward lean
        (cx + 25*s, cy - 60*s),      # front
        (cx + 15*s, cy - 30*s),      # arms
        (cx + 5*s, cy - 10*s),       # lap
    ]
    draw.polygon([(int(x), int(y)) for x, y in rider_body], fill=(*WHITE, 255))
    
    # Head (circle)
    head_cx = cx - 5*s
    head_cy = cy - 88*s
    head_r = 16*s
    draw.ellipse([int(head_cx-head_r), int(head_cy-head_r),
                   int(head_cx+head_r), int(head_cy+head_r)], fill=(*WHITE, 255))
    
    # Spray/Wake
    for i in range(5):
        angle = -30 + i * 15
        length = (40 + i * 12) * s
        x1 = cx - 110*s
        y1 = cy + 5*s
        x2 = x1 - length * math.cos(math.radians(angle))
        y2 = y1 - length * math.sin(math.radians(angle))
        draw.line([(int(x1), int(y1)), (int(x2), int(y2))],
                  fill=(*WHITE, 150), width=max(2, int(3*s)))

def draw_waves(draw, y_start, canvas_size, num_waves=3, max_width=600):
    """Draw decorative wave curves below the jetski."""
    cx = canvas_size // 2
    for i in range(num_waves):
        y_off = y_start + i * 22
        wave_width = max_width - i * 80
        amplitude = 8 - i * 2
        points = []
        x_start = cx - wave_width // 2
        for x in range(wave_width):
            y = y_off + int(amplitude * math.sin(2 * math.pi * x / 60 + i * 1.5))
            points.append((x_start + x, y))
        for j in range(len(points) - 1):
            alpha = int(200 - i * 50)
            draw.line([points[j], points[j+1]], fill=(255, 255, 255, alpha), width=2)


# ─── Variation A: Bold Modern Sans-Serif ─────────────────────
print("  Generating Variation A (Bold Modern Sans-Serif)...")
img_a, mask_a, center_a, radius_a = create_navy_circle_base(SIZE)
draw_a = ImageDraw.Draw(img_a)

# Scale factor from original 512 to 2048
SF = SIZE / 512.0

# Draw jetski graphic
draw_jetski_silhouette(draw_a, center_a, int(center_a - radius_a * 0.35), scale=SF * 0.42)
draw_waves(draw_a, int(center_a - radius_a * 0.08), SIZE, max_width=int(500 * SF * 0.42))

# Draw thin separator line
sep_y = int(center_a + radius_a * 0.05)
sep_w = int(radius_a * 0.7)
draw_a.line([(center_a - sep_w, sep_y), (center_a + sep_w, sep_y)],
            fill=(*WHITE, 100), width=2)

# Typography A: Montserrat Black (bold, modern, premium)
font_a_main = load_font(FONTS["A_main"], int(130 * SF / 4))
font_a_sub = load_font(FONTS["A_sub"], int(75 * SF / 4))
font_a_sm = load_font(FONTS["A_sub"], int(35 * SF / 4))

y_text = int(center_a + radius_a * 0.10)
th1 = center_text(draw_a, "MARBELLA", font_a_main, y_text, SIZE)
y_text += th1 + int(8 * SF / 4)
th2 = center_text(draw_a, "JET SKI", font_a_sub, y_text, SIZE)
y_text += th2 + int(12 * SF / 4)

# Small "rental" text
font_a_rental = load_font(FONTS["A_sub"], int(28 * SF / 4))
center_text(draw_a, "R E N T A L", font_a_rental, y_text, SIZE, fill=(255, 255, 255))

# Apply circle mask to ensure clean edges
img_a_arr = np.array(img_a)
mask_arr = np.array(mask_a)
img_a_arr[:, :, 3] = np.minimum(img_a_arr[:, :, 3], mask_arr)
img_a = Image.fromarray(img_a_arr)

img_a.save(OUT_DIR / "logo-A-bold-modern.png", "PNG")
print(f"    Saved: logo-A-bold-modern.png ({img_a.size})")


# ─── Variation B: Condensed Racing Style ─────────────────────
print("  Generating Variation B (Condensed Racing)...")
img_b, mask_b, center_b, radius_b = create_navy_circle_base(SIZE)
draw_b = ImageDraw.Draw(img_b)

draw_jetski_silhouette(draw_b, center_b, int(center_b - radius_b * 0.35), scale=SF * 0.42)
draw_waves(draw_b, int(center_b - radius_b * 0.08), SIZE, max_width=int(500 * SF * 0.42))

# Typography B: Barlow Condensed ExtraBold (aggressive, motorsport)
font_b_main = load_font(FONTS["B_main"], int(150 * SF / 4))
font_b_sub = load_font(FONTS["B_sub"], int(90 * SF / 4))
font_b_sm = load_font(FONTS["B_sub"], int(32 * SF / 4))

# Separator - angular line (racing style)
sep_y = int(center_b + radius_b * 0.05)
sep_w = int(radius_b * 0.75)
draw_b.line([(center_b - sep_w, sep_y + 2), (center_b + sep_w, sep_y - 2)],
            fill=(*WHITE, 130), width=3)

y_text = int(center_b + radius_b * 0.10)
th1 = center_text(draw_b, "MARBELLA", font_b_main, y_text, SIZE)
y_text += th1 + int(4 * SF / 4)
th2 = center_text(draw_b, "JET SKI", font_b_sub, y_text, SIZE)
y_text += th2 + int(10 * SF / 4)
center_text(draw_b, "R E N T A L", font_b_sm, y_text, SIZE)

img_b_arr = np.array(img_b)
mask_b_arr = np.array(mask_b)
img_b_arr[:, :, 3] = np.minimum(img_b_arr[:, :, 3], mask_b_arr)
img_b = Image.fromarray(img_b_arr)

img_b.save(OUT_DIR / "logo-B-racing.png", "PNG")
print(f"    Saved: logo-B-racing.png ({img_b.size})")


# ─── Variation C: Elegant Nautical ────────────────────────────
print("  Generating Variation C (Elegant Nautical)...")
img_c, mask_c, center_c, radius_c = create_navy_circle_base(SIZE)
draw_c = ImageDraw.Draw(img_c)

draw_jetski_silhouette(draw_c, center_c, int(center_c - radius_c * 0.35), scale=SF * 0.42)
draw_waves(draw_c, int(center_c - radius_c * 0.08), SIZE, max_width=int(500 * SF * 0.42))

# Typography C: Playfair Display (elegant, premium coastal)
font_c_main = load_font(FONTS["C_main"], int(115 * SF / 4))
font_c_sub = load_font(FONTS["C_sub"], int(70 * SF / 4))
font_c_sm = load_font(FONTS["C_sub"], int(30 * SF / 4))

# Elegant separator - thin line with dots
sep_y = int(center_c + radius_c * 0.05)
sep_w = int(radius_c * 0.6)
draw_c.line([(center_c - sep_w, sep_y), (center_c + sep_w, sep_y)],
            fill=(*WHITE, 80), width=1)
# Small dots at ends
for dx in [-sep_w, sep_w]:
    draw_c.ellipse([center_c + dx - 3, sep_y - 3, center_c + dx + 3, sep_y + 3],
                   fill=(*WHITE, 120))

y_text = int(center_c + radius_c * 0.10)
th1 = center_text(draw_c, "MARBELLA", font_c_main, y_text, SIZE)
y_text += th1 + int(8 * SF / 4)
th2 = center_text(draw_c, "JET SKI", font_c_sub, y_text, SIZE)
y_text += th2 + int(12 * SF / 4)

# Wave line above "rental"
draw_wave_line(draw_c, y_text - int(5 * SF / 4), int(200 * SF / 4), SIZE,
               amplitude=4, wavelength=40, thickness=1)
y_text += int(8 * SF / 4)
center_text(draw_c, "R E N T A L", font_c_sm, y_text, SIZE)

img_c_arr = np.array(img_c)
mask_c_arr = np.array(mask_c)
img_c_arr[:, :, 3] = np.minimum(img_c_arr[:, :, 3], mask_c_arr)
img_c = Image.fromarray(img_c_arr)

img_c.save(OUT_DIR / "logo-C-nautical.png", "PNG")
print(f"    Saved: logo-C-nautical.png ({img_c.size})")


# ─── STEP 5: Create SVG Versions ─────────────────────────────
print("\n=== Step 5: Generating SVG versions ===")

def create_svg(font_family_main, font_family_sub, font_weight_main, font_weight_sub,
               main_size, sub_size, rental_size, separator_style, filename):
    """Generate an SVG logo."""
    
    svg_size = 512
    cx = svg_size // 2
    cy = svg_size // 2
    r = 228  # navy circle radius
    
    # Jetski silhouette path (simplified for SVG)
    jetski_path = """
    M 180 165 
    C 180 155, 195 140, 210 135
    L 230 120 
    C 232 110, 240 95, 245 90
    C 250 85, 255 80, 252 78
    C 248 76, 240 82, 238 88
    L 225 105
    C 222 108, 218 112, 215 115
    L 200 130
    C 195 133, 188 138, 185 142
    Z
    M 160 175
    L 155 168 C 155 162, 165 155, 180 152
    L 340 148 C 355 148, 360 155, 355 162
    L 340 172 C 335 178, 320 180, 300 178
    L 180 178 C 168 178, 160 178, 160 175 Z
    """
    
    # Waves
    wave1 = f'M {cx-120} 195 Q {cx-80} 185, {cx-40} 195 Q {cx} 205, {cx+40} 195 Q {cx+80} 185, {cx+120} 195'
    wave2 = f'M {cx-90} 210 Q {cx-50} 200, {cx-10} 210 Q {cx+30} 220, {cx+70} 210'
    wave3 = f'M {cx-60} 222 Q {cx-30} 215, {cx} 222 Q {cx+30} 229, {cx+60} 222'
    
    # Separator
    if separator_style == "straight":
        sep = f'<line x1="{cx-100}" y1="248" x2="{cx+100}" y2="248" stroke="white" stroke-opacity="0.4" stroke-width="1"/>'
    elif separator_style == "angled":
        sep = f'<line x1="{cx-110}" y1="250" x2="{cx+110}" y2="246" stroke="white" stroke-opacity="0.5" stroke-width="1.5"/>'
    else:  # elegant with dots
        sep = f'''<line x1="{cx-80}" y1="248" x2="{cx+80}" y2="248" stroke="white" stroke-opacity="0.3" stroke-width="0.8"/>
        <circle cx="{cx-80}" cy="248" r="2" fill="white" fill-opacity="0.5"/>
        <circle cx="{cx+80}" cy="248" r="2" fill="white" fill-opacity="0.5"/>'''
    
    svg = f'''<?xml version="1.0" encoding="UTF-8"?>
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 {svg_size} {svg_size}" width="{svg_size}" height="{svg_size}">
  <defs>
    <clipPath id="circle-clip">
      <circle cx="{cx}" cy="{cy}" r="{r}"/>
    </clipPath>
    <style>
      @import url('https://fonts.googleapis.com/css2?family={font_family_main.replace(" ", "+")}:wght@{font_weight_main}&amp;family={font_family_sub.replace(" ", "+")}:wght@{font_weight_sub}&amp;display=swap');
    </style>
  </defs>
  
  <!-- Navy circle background -->
  <circle cx="{cx}" cy="{cy}" r="{r}" fill="#0d1b39"/>
  
  <!-- Jetski silhouette -->
  <g clip-path="url(#circle-clip)">
    <!-- Simplified jetski hull -->
    <path d="M 160 175 L 155 168 C 155 162 165 155 180 152 L 345 148 C 360 148 365 155 358 165 L 345 175 C 335 182 315 185 295 182 L 180 182 C 168 182 160 180 160 175 Z" fill="white"/>
    
    <!-- Rider body -->
    <path d="M 235 152 L 228 130 C 226 122 230 110 238 100 L 250 88 C 254 84 258 82 256 80 C 254 78 248 82 244 88 L 228 108 C 222 116 218 125 220 135 L 215 152 Z" fill="white"/>
    
    <!-- Rider head -->
    <circle cx="247" cy="75" r="12" fill="white"/>
    
    <!-- Water spray -->
    <path d="M 160 170 L 120 155 M 160 172 L 115 165 M 158 175 L 110 175 M 158 178 L 120 188 M 160 180 L 130 195" 
          stroke="white" stroke-opacity="0.6" stroke-width="2" stroke-linecap="round" fill="none"/>
    
    <!-- Waves -->
    <path d="{wave1}" stroke="white" stroke-opacity="0.7" stroke-width="2.5" fill="none" stroke-linecap="round"/>
    <path d="{wave2}" stroke="white" stroke-opacity="0.5" stroke-width="2" fill="none" stroke-linecap="round"/>
    <path d="{wave3}" stroke="white" stroke-opacity="0.35" stroke-width="1.5" fill="none" stroke-linecap="round"/>
    
    <!-- Separator -->
    {sep}
    
    <!-- Text: MARBELLA -->
    <text x="{cx}" y="{265 + main_size * 0.85}" 
          font-family="'{font_family_main}', sans-serif" 
          font-weight="{font_weight_main}"
          font-size="{main_size}" 
          fill="white" text-anchor="middle" 
          letter-spacing="3">{" ".join("MARBELLA") if main_size < 50 else "MARBELLA"}</text>
    
    <!-- Text: JET SKI -->
    <text x="{cx}" y="{265 + main_size * 0.85 + sub_size + 10}" 
          font-family="'{font_family_sub}', sans-serif" 
          font-weight="{font_weight_sub}"
          font-size="{sub_size}" 
          fill="white" text-anchor="middle" 
          letter-spacing="4">JET SKI</text>
    
    <!-- Text: RENTAL -->
    <text x="{cx}" y="{265 + main_size * 0.85 + sub_size + rental_size + 22}" 
          font-family="'{font_family_sub}', sans-serif" 
          font-weight="{font_weight_sub}"
          font-size="{rental_size}" 
          fill="white" fill-opacity="0.7" text-anchor="middle" 
          letter-spacing="8">RENTAL</text>
  </g>
</svg>'''
    
    filepath = OUT_DIR / filename
    filepath.write_text(svg, encoding="utf-8")
    print(f"    Saved: {filename}")

# A: Bold Modern (Montserrat)
create_svg("Montserrat", "Montserrat", 900, 700,
           52, 36, 16, "straight", "logo-A-bold-modern.svg")

# B: Racing Condensed (Barlow Condensed)
create_svg("Barlow Condensed", "Barlow Condensed", 800, 700,
           58, 40, 15, "angled", "logo-B-racing.svg")

# C: Elegant Nautical (Playfair Display)
create_svg("Playfair Display", "Playfair Display", 700, 400,
           48, 32, 14, "elegant", "logo-C-nautical.svg")


# ─── STEP 6: Small-size versions (favicons) ──────────────────
print("\n=== Step 6: Generating favicon/small versions ===")

favicon_sizes = [256, 128, 64, 32]
for variant_name, variant_img in [("A-bold-modern", img_a), ("B-racing", img_b), ("C-nautical", img_c)]:
    for fsize in favicon_sizes:
        small = variant_img.resize((fsize, fsize), Image.LANCZOS)
        fname = f"logo-{variant_name}-{fsize}.png"
        small.save(OUT_DIR / fname, "PNG")
    print(f"    {variant_name}: saved {favicon_sizes}")

# Also save ring-free original at small sizes
clean_orig_sq = img_clean.copy()  # already has ring removed
for fsize in favicon_sizes:
    small = clean_orig_sq.resize((fsize, fsize), Image.LANCZOS)
    small.save(OUT_DIR / f"logo-clean-original-{fsize}.png", "PNG")
print(f"    clean-original: saved {favicon_sizes}")


# ─── STEP 7: Quality check ───────────────────────────────────
print("\n=== Step 7: Quality checks ===")

for name, fpath in [
    ("A", OUT_DIR / "logo-A-bold-modern.png"),
    ("B", OUT_DIR / "logo-B-racing.png"),
    ("C", OUT_DIR / "logo-C-nautical.png"),
    ("Clean", OUT_DIR / "logo-clean-original.png"),
]:
    img_check = Image.open(fpath).convert("RGBA")
    arr_check = np.array(img_check)
    h_c, w_c = arr_check.shape[:2]
    
    # Check corners for transparency
    corners_ok = True
    for cy_c, cx_c in [(5,5), (5,w_c-5), (h_c-5,5), (h_c-5,w_c-5)]:
        if arr_check[cy_c, cx_c, 3] > 10:
            corners_ok = False
    
    # Check for white ring remnants: sample the edge of content
    edge_white = 0
    edge_total = 0
    center_y, center_x = h_c//2, w_c//2
    for angle in range(0, 360, 2):
        for r_off in range(-5, 6):
            check_r = min(center_x, center_y) * 0.95 + r_off
            x_s = int(center_x + check_r * math.cos(math.radians(angle)))
            y_s = int(center_y + check_r * math.sin(math.radians(angle)))
            if 0 <= x_s < w_c and 0 <= y_s < h_c:
                edge_total += 1
                r, g, b, a = arr_check[y_s, x_s]
                if a > 200 and r > 220 and g > 220 and b > 220:
                    edge_white += 1
    
    white_pct = edge_white / max(1, edge_total) * 100
    print(f"  {name}: corners_transparent={corners_ok}, edge_white={white_pct:.1f}%")

print("\n=== DONE ===")
print(f"Output directory: {OUT_DIR}")
for f in sorted(OUT_DIR.iterdir()):
    size_kb = f.stat().st_size / 1024
    print(f"  {f.name} ({size_kb:.1f} KB)")
