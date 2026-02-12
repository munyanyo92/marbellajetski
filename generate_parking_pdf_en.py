#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Generate Marbella JetSki Parking Service PDF (EN) — Premium design.
"""

from fpdf import FPDF

class ParkingPDF(FPDF):
    def __init__(self):
        super().__init__(orientation='P', unit='pt', format='A4')
        self.set_auto_page_break(auto=False)
        self.add_font("Arial", "", r"C:\Windows\Fonts\arial.ttf")
        self.add_font("Arial", "B", r"C:\Windows\Fonts\arialbd.ttf")
        self.add_font("Arial", "I", r"C:\Windows\Fonts\ariali.ttf")
        self.navy = (10, 22, 40)
        self.gold = (185, 155, 70)
        self.gold_light = (210, 180, 95)
        self.slate = (100, 116, 139)
        self.dark_slate = (51, 65, 85)
        self.white = (255, 255, 255)
        self.cyan = (0, 180, 216)
        self.cyan_dark = (0, 130, 170)
        self.pw = 595.28
        self.ph = 841.89
        self.logo = r"c:\Users\Usuario\Website Marbella Jetski\assets\media\photos\logo-circular.png"

    def gradient_rect(self, x, y, w, h, c1, c2, steps=60):
        step_h = h / steps
        for i in range(steps):
            r = c1[0] + (c2[0] - c1[0]) * i / steps
            g = c1[1] + (c2[1] - c1[1]) * i / steps
            b = c1[2] + (c2[2] - c1[2]) * i / steps
            self.set_fill_color(int(r), int(g), int(b))
            self.rect(x, y + i * step_h, w, step_h + 1, 'F')

    def shadow_rect(self, x, y, w, h, radius=10):
        """Simulate a soft drop shadow behind a rounded rectangle."""
        for i in range(4, 0, -1):
            alpha = 230 + i * 5
            self.set_fill_color(alpha, alpha, alpha)
            self.rect(x + i, y + i, w, h, 'F', round_corners=True, corner_radius=radius)

    def build_page1(self):
        self.add_page()
        pw = self.pw
        m = 36

        # ── PAGE BACKGROUND: very subtle warm white gradient ──
        self.gradient_rect(0, 0, pw, self.ph, (255, 255, 255), (245, 248, 252))

        # ── HEADER ──
        self.gradient_rect(0, 0, pw, 140, (8, 18, 35), (15, 30, 55))
        # Gold accent line at bottom of header
        self.set_fill_color(*self.gold)
        self.rect(0, 140, pw, 2, 'F')
        # Logo
        logo_s = 48
        self.image(self.logo, pw / 2 - logo_s / 2, 12, logo_s, logo_s)
        # Company name
        self.set_font("Arial", "B", 16)
        self.set_text_color(*self.white)
        self.set_xy(0, 64)
        self.cell(pw, 16, "MARBELLA JET SKI", align='C')
        self.set_font("Arial", "", 6.5)
        self.set_text_color(*self.gold_light)
        self.set_xy(0, 82)
        self.cell(pw, 8, "W A T E R S P O R T S", align='C')
        # Decorative divider
        cx = pw / 2
        self.set_draw_color(*self.gold)
        self.set_line_width(0.6)
        self.line(cx - 60, 100, cx - 4, 100)
        self.line(cx + 4, 100, cx + 60, 100)
        self.set_fill_color(*self.gold)
        self.ellipse(cx - 2, 98, 4, 4, 'F')
        # Tagline
        self.set_font("Arial", "I", 5)
        self.set_text_color(180, 195, 215)
        self.set_xy(0, 112)
        self.cell(pw, 7, "Since 1998  \u00b7  Costa del Sol  \u00b7  Marbella", align='C')

        # ── TITLE SECTION ──
        self.set_font("Arial", "B", 12)
        self.set_text_color(*self.navy)
        self.set_xy(0, 154)
        self.cell(pw, 14, "JET SKI PARKING & STORAGE SERVICE", align='C')

        # Premium subtitle pill
        pill_w = 260
        self.set_fill_color(*self.navy)
        self.rect(pw / 2 - pill_w / 2, 172, pill_w, 13, 'F', round_corners=True, corner_radius=6.5)
        self.set_font("Arial", "B", 5.5)
        self.set_text_color(*self.gold_light)
        self.set_xy(0, 173.5)
        self.cell(pw, 9, "P R E M I U M   S E R V I C E   \u00b7   Y E A R - R O U N D", align='C')

        # Subtitle desc
        self.set_font("Arial", "", 5.5)
        self.set_text_color(*self.slate)
        self.set_xy(0, 192)
        self.cell(pw, 7, "Private & secure beachfront facilities  \u00b7  Marbella, Costa del Sol", align='C')

        # ── WHAT'S INCLUDED ──
        y = 212
        # Section title with gold accent
        self.set_fill_color(*self.gold)
        self.rect(m, y + 3, 18, 2.5, 'F', round_corners=True, corner_radius=1)
        self.set_font("Arial", "B", 8)
        self.set_text_color(*self.navy)
        self.set_xy(m + 24, y)
        self.cell(200, 10, "WHAT'S INCLUDED")

        items = [
            ("Annual or monthly parking", "Assigned spot in private facilities with controlled access and perimeter fencing"),
            ("24-hour security", "Permanent night watchman + full CCTV surveillance system covering all areas"),
            ("Professional exterior cleaning", "Freshwater wash, rinse and full dry-down after every trip to sea"),
            ("Engine desalination after every use", "Complete water circuit flush and anti-corrosion treatment to protect internal components"),
            ("Launch & retrieval service", "We take your jet ski to the water and pick it up \u2014 you just arrive and enjoy"),
            ("Transport included", "Pick-up of your jet ski up to 50 km free. Beyond that: \u20ac1/km (max. 200 km total)"),
        ]

        y += 18
        for title, desc in items:
            # Check circle
            self.set_fill_color(*self.cyan)
            self.ellipse(m, y + 1, 14, 14, 'F')
            self.set_font("Arial", "B", 7)
            self.set_text_color(*self.white)
            self.set_xy(m + 3.2, y + 3.5)
            self.cell(8, 7, "\u25cf")
            # Title
            self.set_font("Arial", "B", 6.5)
            self.set_text_color(*self.navy)
            self.set_xy(m + 20, y + 1)
            self.cell(400, 7, title)
            # Description
            self.set_font("Arial", "", 5.2)
            self.set_text_color(*self.slate)
            self.set_xy(m + 20, y + 9)
            self.cell(pw - 2 * m - 20, 6, desc)
            y += 24

        # ── ALERT BOX ──
        ay = y + 4
        # Shadow
        self.set_fill_color(245, 240, 220)
        self.rect(m + 2, ay + 2, pw - 2 * m, 36, 'F', round_corners=True, corner_radius=8)
        # Box
        self.set_fill_color(255, 252, 240)
        self.rect(m, ay, pw - 2 * m, 36, 'F', round_corners=True, corner_radius=8)
        self.set_draw_color(235, 210, 140)
        self.set_line_width(0.6)
        self.rect(m, ay, pw - 2 * m, 36, 'D', round_corners=True, corner_radius=8)
        # Gold left accent
        self.set_fill_color(*self.gold)
        self.rect(m + 1, ay + 8, 3, 20, 'F')
        # Warning icon
        self.set_fill_color(*self.gold)
        self.ellipse(m + 12, ay + 8, 16, 16, 'F')
        self.set_font("Arial", "B", 9)
        self.set_text_color(*self.white)
        self.set_xy(m + 16, ay + 11)
        self.cell(8, 8, "!")
        # Text
        self.set_font("Arial", "B", 6)
        self.set_text_color(140, 95, 20)
        self.set_xy(m + 36, ay + 4)
        self.cell(300, 7, "CUSTOMER MUST PROVIDE")
        self.set_font("Arial", "B", 5.8)
        self.set_text_color(100, 65, 10)
        self.set_xy(m + 36, ay + 12)
        self.cell(400, 6, "Protective cover for the jet ski (mandatory)")
        self.set_font("Arial", "", 4.8)
        self.set_text_color(120, 85, 20)
        self.set_xy(m + 36, ay + 19)
        self.multi_cell(pw - 2 * m - 46, 5,
            "Your jet ski must be covered at all times. The cover protects against sun, rain, dust and corrosion. No uncovered jet skis accepted. Need one? Ask us.")

        # ── 4 INFO BOXES ──
        by0 = ay + 48
        # Decorative divider
        self.set_draw_color(220, 228, 238)
        self.set_line_width(0.3)
        self.line(m, by0, pw - m, by0)
        by0 += 8

        box_w = (pw - 2 * m - 14) / 2
        box_h = 86

        boxes_data = [
            ("ACCESS & HOURS", [
                "Hours: 11:00 \u2013 20:00 (15 May \u2013 1 Oct)",
                "Book your session by phone or WhatsApp",
                "Minimum 2-hour notice for launch",
            ]),
            ("LAUNCH & RETRIEVAL", [
                "We transport your jet ski to the shore",
                "Professional launch and retrieval",
                "Wash and desalination after each trip",
                "No trailer or vehicle needed",
            ]),
            ("WINTER STORAGE", [
                "Year-round storage available",
                "Optional winterisation service",
                "Your jet ski ready when spring arrives",
            ]),
            ("TRANSPORT (PREMIUM ANNUAL ONLY)", [
                "Pick-up and delivery included up to 50 km",
                "Beyond 50 km: \u20ac1/km additional",
                "Maximum distance: 200 km total",
            ]),
        ]

        positions = [
            (m, by0), (m + box_w + 14, by0),
            (m, by0 + box_h + 8), (m + box_w + 14, by0 + box_h + 8),
        ]

        for idx, (title, items_list) in enumerate(boxes_data):
            bx, by2 = positions[idx]
            # Shadow
            self.set_fill_color(235, 238, 244)
            self.rect(bx + 2, by2 + 2, box_w, box_h, 'F', round_corners=True, corner_radius=8)
            # Card
            self.set_fill_color(238, 248, 252)
            self.rect(bx, by2, box_w, box_h, 'F', round_corners=True, corner_radius=8)
            self.set_draw_color(200, 225, 240)
            self.set_line_width(0.4)
            self.rect(bx, by2, box_w, box_h, 'D', round_corners=True, corner_radius=8)
            # Cyan top accent
            self.set_fill_color(*self.cyan)
            self.rect(bx + 12, by2, 30, 2.5, 'F', round_corners=True, corner_radius=1)
            # Title
            self.set_font("Arial", "B", 6.5)
            self.set_text_color(*self.navy)
            self.set_xy(bx + 12, by2 + 10)
            self.cell(box_w - 20, 7, title)
            # Divider
            self.set_draw_color(230, 238, 248)
            self.set_line_width(0.3)
            self.line(bx + 12, by2 + 22, bx + box_w - 12, by2 + 22)
            # Items
            iy = by2 + 28
            for item in items_list:
                self.set_font("Arial", "", 5.8)
                self.set_text_color(*self.cyan_dark)
                self.set_xy(bx + 12, iy)
                self.cell(6, 7, "\u2022")
                self.set_font("Arial", "", 5.8)
                self.set_text_color(*self.dark_slate)
                self.set_xy(bx + 20, iy)
                self.cell(box_w - 32, 7, item)
                iy += 10

        # ── FOOTER ──
        fy = self.ph - 28
        self.set_fill_color(*self.navy)
        self.rect(0, fy, pw, 28, 'F')
        self.set_fill_color(*self.gold)
        self.rect(0, fy, pw, 1.2, 'F')
        self.set_font("Arial", "", 4.8)
        self.set_text_color(180, 195, 215)
        self.set_xy(0, fy + 6)
        self.cell(pw, 6, "+34 655 442 232  \u00b7  marbellajetski.com  \u00b7  WhatsApp available", align='C')
        self.set_font("Arial", "", 4)
        self.set_text_color(130, 150, 180)
        self.set_xy(0, fy + 15)
        self.cell(pw, 5, "Playa de las Dunas, Urb. Pinomar  \u00b7  29604 Marbella  \u00b7  \u00a9 2026 Marbella Jet Ski Watersports", align='C')

    def build_page2(self):
        self.add_page()
        pw = self.pw
        m = 36

        # ── PAGE BACKGROUND ──
        self.gradient_rect(0, 0, pw, self.ph, (255, 255, 255), (245, 248, 252))

        # ── MINI HEADER ──
        self.set_fill_color(*self.navy)
        self.rect(0, 0, pw, 26, 'F')
        self.set_fill_color(*self.gold)
        self.rect(0, 26, pw, 1.2, 'F')
        self.image(self.logo, 14, 4, 18, 18)
        self.set_font("Arial", "B", 7)
        self.set_text_color(*self.white)
        self.set_xy(36, 8)
        self.cell(200, 10, "MARBELLA JET SKI WATERSPORTS")
        # Right side tag
        self.set_font("Arial", "", 4.5)
        self.set_text_color(*self.gold_light)
        self.set_xy(pw - 140, 10)
        self.cell(120, 6, "marbellajetski.com", align='R')

        # ── PRICING TITLE ──
        self.set_font("Arial", "B", 10)
        self.set_text_color(*self.navy)
        self.set_xy(m, 38)
        self.cell(200, 12, "OUR PRICING")
        # Gold underline accent
        self.set_fill_color(*self.gold)
        self.rect(m, 51, 40, 2, 'F', round_corners=True, corner_radius=1)

        # Subtitle pill
        pill_w = 230
        self.set_fill_color(240, 248, 255)
        self.rect(pw / 2 - pill_w / 2, 58, pill_w, 12, 'F', round_corners=True, corner_radius=6)
        self.set_draw_color(210, 228, 245)
        self.set_line_width(0.4)
        self.rect(pw / 2 - pill_w / 2, 58, pill_w, 12, 'D', round_corners=True, corner_radius=6)
        self.set_font("Arial", "B", 5.5)
        self.set_text_color(*self.cyan_dark)
        self.set_xy(0, 60)
        self.cell(pw, 8, "P R E M I U M   S E R V I C E   \u00b7   Y E A R - R O U N D", align='C')

        # ── 3 PRICING CARDS ──
        cy = 78
        gap = 8
        cw = (pw - 2 * m - 2 * gap) / 3
        ch = 198

        cards = [
            {
                "badge": "B E S T   V A L U E",
                "price": "\u20ac3,000",
                "name": "PREMIUM ANNUAL",
                "period": "per year",
                "features": [
                    "Year-round storage",
                    "Transport up to 50 km included",
                    "+\u20ac1/km extra (max. 200 km)",
                    "1 warehouse \u2192 beach transport incl.",
                    "Full-summer beach stay",
                    "24/7 protection + watchman",
                    "Cleaning + desalination incl.",
                    "Maintenance: competitive prices",
                    "2-week advance notice for delivery",
                    "Season: 15 May \u2013 1 Oct",
                ],
                "hl": True,
            },
            {
                "badge": "S T O R A G E",
                "price": "\u20ac1,800",
                "name": "ANNUAL STORAGE",
                "period": "per year",
                "features": [
                    "Year-round storage",
                    "Transport up to 50 km included",
                    "+\u20ac1/km extra (max. 200 km)",
                    "No beach service",
                    "Cleaning + desalination incl.",
                    "Maintenance: competitive prices",
                ],
                "hl": False,
            },
            {
                "badge": "F L E X I B L E",
                "price": "\u20ac800",
                "name": "MONTHLY BEACH",
                "period": "per month (May\u2013Oct)",
                "features": [
                    "Available 15 May \u2013 1 Oct",
                    "Beach spot with protection",
                    "24/7 surveillance + guard",
                    "Cleaning + desalination incl.",
                    "Launch & retrieval service",
                    "Off-season: \u20ac199/month",
                    "(storage only, Oct\u2013May)",
                ],
                "hl": False,
            },
        ]

        for i, card in enumerate(cards):
            cx = m + i * (cw + gap)

            # Drop shadow
            self.shadow_rect(cx, cy, cw, ch, 10)

            if card["hl"]:
                # ── PREMIUM CARD ──
                self.set_fill_color(232, 247, 252)
                self.rect(cx, cy, cw, ch, 'F', round_corners=True, corner_radius=10)
                self.set_draw_color(*self.gold)
                self.set_line_width(1.2)
                self.rect(cx, cy, cw, ch, 'D', round_corners=True, corner_radius=10)
                # Gold top accent
                self.set_fill_color(*self.gold)
                self.rect(cx + 15, cy, cw - 30, 3, 'F', round_corners=True, corner_radius=1.5)
                txt = self.navy
                sub = self.dark_slate
                feat = self.dark_slate
                badge_bg = (255, 107, 53)
                div = (200, 218, 225)
                bullet = self.gold
            else:
                # ── STANDARD CARD ──
                self.set_fill_color(238, 248, 252)
                self.rect(cx, cy, cw, ch, 'F', round_corners=True, corner_radius=10)
                self.set_draw_color(200, 225, 240)
                self.set_line_width(0.5)
                self.rect(cx, cy, cw, ch, 'D', round_corners=True, corner_radius=10)
                # Cyan top accent
                self.set_fill_color(*self.cyan)
                self.rect(cx + 15, cy, cw - 30, 2.5, 'F', round_corners=True, corner_radius=1)
                txt = self.navy
                sub = self.slate
                feat = self.dark_slate
                badge_bg = (0, 150, 199)
                div = (200, 225, 240)
                bullet = self.cyan_dark

            # Badge pill
            bw = 68
            bx2 = cx + (cw - bw) / 2
            self.set_fill_color(*badge_bg)
            self.rect(bx2, cy + 13, bw, 11, 'F', round_corners=True, corner_radius=5.5)
            self.set_font("Arial", "B", 3.5)
            self.set_text_color(*self.white)
            self.set_xy(bx2, cy + 14)
            self.cell(bw, 8, card["badge"], align='C')

            # Price
            self.set_font("Arial", "B", 26)
            self.set_text_color(*txt)
            self.set_xy(cx, cy + 30)
            self.cell(cw, 24, card["price"], align='C')

            # Name
            self.set_font("Arial", "B", 5.8)
            self.set_text_color(*sub)
            self.set_xy(cx, cy + 56)
            self.cell(cw, 7, card["name"], align='C')

            # Period
            self.set_font("Arial", "", 4.8)
            self.set_text_color(*self.slate)
            self.set_xy(cx, cy + 64)
            self.cell(cw, 6, card["period"], align='C')

            # Divider
            self.set_draw_color(*div)
            self.set_line_width(0.4)
            self.line(cx + 14, cy + 75, cx + cw - 14, cy + 75)

            # Features
            fy = cy + 82
            spacing = 10.8 if len(card["features"]) <= 7 else 9.8
            for f in card["features"]:
                self.set_font("Arial", "", 5.5)
                self.set_text_color(*bullet)
                self.set_xy(cx + 10, fy)
                self.cell(6, 7, "\u2022")
                self.set_font("Arial", "", 5.8)
                self.set_text_color(*feat)
                self.set_xy(cx + 17, fy)
                self.cell(cw - 27, 7, f)
                fy += spacing

        # ── VAT NOTE ──
        ny = cy + ch + 8
        self.set_font("Arial", "I", 5.5)
        self.set_text_color(*self.slate)
        self.set_xy(0, ny)
        self.cell(pw, 6, "VAT included  \u00b7  Payment in advance  \u00b7  Cancellation conditions on request", align='C')

        # ── OPTIONAL SERVICES ──
        sy = ny + 14
        self.set_font("Arial", "B", 8)
        self.set_text_color(*self.navy)
        self.set_xy(m, sy)
        self.cell(200, 10, "OPTIONAL SERVICES")
        self.set_fill_color(*self.gold)
        self.rect(m, sy + 11, 30, 1.5, 'F', round_corners=True, corner_radius=0.75)

        thy = sy + 16
        table_h = 13 + 7 * 11.5 + 2
        # Shadow
        self.set_fill_color(235, 238, 244)
        self.rect(m + 2, thy + 2, pw - 2 * m, table_h, 'F', round_corners=True, corner_radius=8)
        # Table
        self.set_fill_color(238, 248, 252)
        self.rect(m, thy, pw - 2 * m, table_h, 'F', round_corners=True, corner_radius=8)
        self.set_draw_color(200, 225, 240)
        self.set_line_width(0.4)
        self.rect(m, thy, pw - 2 * m, table_h, 'D', round_corners=True, corner_radius=8)
        # Header row
        self.set_font("Arial", "B", 5)
        self.set_text_color(*self.navy)
        self.set_xy(m + 12, thy + 4)
        self.cell(300, 6, "SERVICE")
        self.set_xy(pw - m - 75, thy + 4)
        self.cell(63, 6, "PRICE", align='R')
        # Header line
        self.set_draw_color(*self.cyan)
        self.set_line_width(0.4)
        self.line(m + 10, thy + 13, pw - m - 10, thy + 13)

        services = [
            "Full winterisation (engine, fuel, battery & preparation)",
            "De-winterisation and spring tune-up",
            "Oil and filter change",
            "Deep interior cleaning and detailing",
            "Battery replacement",
            "Minor mechanical repairs and diagnostics",
            "Protective cover (supply and fitting)",
        ]

        ry = thy + 16
        for idx, svc in enumerate(services):
            if idx < len(services) - 1:
                self.set_draw_color(235, 240, 248)
                self.set_line_width(0.2)
                self.line(m + 10, ry + 11.5, pw - m - 10, ry + 11.5)
            self.set_font("Arial", "", 4.8)
            self.set_text_color(*self.cyan_dark)
            self.set_xy(m + 12, ry + 2.5)
            self.cell(6, 6, "\u2022")
            self.set_font("Arial", "", 6)
            self.set_text_color(*self.dark_slate)
            self.set_xy(m + 19, ry + 2.5)
            self.cell(340, 6, svc)
            self.set_font("Arial", "B", 6)
            self.set_text_color(*self.cyan_dark)
            self.set_xy(pw - m - 75, ry + 2.5)
            self.cell(63, 6, "On request", align='R')
            ry += 11.5

        # ── CONDITIONS ──
        sey = ry + 10
        sec_h = 58
        # Shadow
        self.set_fill_color(235, 238, 244)
        self.rect(m + 2, sey + 2, pw - 2 * m, sec_h, 'F', round_corners=True, corner_radius=8)
        # Box
        self.set_fill_color(*self.navy)
        self.rect(m, sey, pw - 2 * m, sec_h, 'F', round_corners=True, corner_radius=8)
        # Gold top accent
        self.set_fill_color(*self.gold)
        self.rect(m + 15, sey, 30, 2, 'F', round_corners=True, corner_radius=1)

        self.set_font("Arial", "B", 7)
        self.set_text_color(*self.gold_light)
        self.set_xy(m + 12, sey + 7)
        self.cell(300, 7, "LIABILITY & CONDITIONS")

        self.set_font("Arial", "", 5.5)
        self.set_text_color(*self.gold_light)
        self.set_xy(m + 12, sey + 17)
        self.cell(6, 5, "\u2022")
        self.set_font("Arial", "", 5.2)
        self.set_text_color(190, 205, 225)
        self.set_xy(m + 20, sey + 17)
        self.multi_cell((pw - 2 * m - 32), 5.2,
            "The customer is responsible for maintaining their own jet ski insurance (third-party and comprehensive). Marbella Jet Ski Watersports is not liable for theft, vandalism, weather damage or mechanical failure. Proof of insurance may be requested.")

        self.set_font("Arial", "", 5.5)
        self.set_text_color(*self.gold_light)
        self.set_xy(m + 12, sey + 36)
        self.cell(6, 5, "\u2022")
        self.set_font("Arial", "", 5.2)
        self.set_text_color(190, 205, 225)
        self.set_xy(m + 20, sey + 36)
        self.multi_cell((pw - 2 * m - 32), 5.2,
            "Signed contract required. Minimum: 1 month. Annual plans: prepaid. Monthly: due on the 1st. Non-payment >15 days: access restricted. Unclaimed jet skis after 60 days subject to lien (art. 1780 CC). Full terms available on request.")

        # ── FOOTER ──
        fy2 = self.ph - 36
        self.set_fill_color(*self.navy)
        self.rect(0, fy2, pw, 36, 'F')
        self.set_fill_color(*self.gold)
        self.rect(0, fy2, pw, 1.2, 'F')
        self.set_font("Arial", "B", 5)
        self.set_text_color(*self.white)
        self.set_xy(0, fy2 + 6)
        self.cell(pw, 6, "+34 655 442 232  \u00b7  marbellajetski.com  \u00b7  WhatsApp available", align='C')
        self.set_font("Arial", "", 4.5)
        self.set_text_color(180, 195, 215)
        self.set_xy(0, fy2 + 15)
        self.cell(pw, 5, "Playa de las Dunas, Urb. Pinomar  \u00b7  29604 Marbella, M\u00e1laga  \u00b7  Costa del Sol", align='C')
        self.set_font("Arial", "", 3.5)
        self.set_text_color(130, 150, 180)
        self.set_xy(0, fy2 + 24)
        self.cell(pw, 4, "\u00a9 2026 Marbella Jet Ski Watersports  \u00b7  All rights reserved  \u00b7  Since 1998", align='C')


# GENERATE
pdf = ParkingPDF()
pdf.build_page1()
pdf.build_page2()
out = r"c:\Users\Usuario\Website Marbella Jetski\assets\media\Marbella_JetSki_Parking_Service_EN.pdf"
pdf.output(out)
print(f"PDF saved: {out}")
