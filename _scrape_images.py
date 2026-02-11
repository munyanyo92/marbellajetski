import urllib.request, re

url = 'https://www.marbellajetski.com/'
req = urllib.request.Request(url, headers={'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36'})
html = urllib.request.urlopen(req).read().decode('utf-8')

print(f"HTML length: {len(html)}")

# Find ALL image URLs (src, srcset, data-src, background-image, etc.)
all_imgs = re.findall(r'(?:src|srcset|data-src|data-lazy-src|data-bg|url\()[\s="\']*(https?://[^\"\'\s>,)]+\.(?:jpg|jpeg|png|webp|gif))', html, re.IGNORECASE)

seen = set()
for img in all_imgs:
    if img not in seen:
        seen.add(img)
        print(img)

if not all_imgs:
    print("\nNo images found. Trying broader pattern...")
    all_urls = re.findall(r'https?://marbellajetski\.com[^\"\'\s>)]*', html)
    for u in sorted(set(all_urls))[:30]:
        print(u)

# Also try finding img tags
img_tags = re.findall(r'<img[^>]+>', html[:5000])
print(f"\nFirst 3 img tags:")
for t in img_tags[:3]:
    print(t[:200])
