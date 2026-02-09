/**
 * Marbella Jet Ski Service Worker
 * Enables offline functionality and caching for PWA
 */

const CACHE_NAME = 'marbellajetski-v36-weather-fix';
const OFFLINE_URL = '/offline.html';

// Local files that should always be fetched from network first
const LOCAL_FILES = ['index.html', 'booking.html', 'about-daniel.html', 'terms.html', 'styles.css', 'script.js', '404.html', '/es/'];

const ASSETS_TO_CACHE = [
    '/',
    '/index.html',
    '/booking.html',
    '/about-daniel.html',
    '/terms.html',
    '/404.html',
    '/styles.css',
    '/script.js',
    '/manifest.json',
    '/offline.html',
    '/es/index.html',
    'https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;500;600;700;800;900&family=Playfair+Display:wght@400;500;600;700&display=swap',
    'https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css',
    'https://unpkg.com/aos@2.3.1/dist/aos.css',
    'https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css',
    // Original site logo
    'https://marbellajetski.com/wp-content/uploads/2021/05/MJS_16_500x500-removebg-preview.png',
    'https://marbellajetski.com/wp-content/uploads/2021/05/MJS_16_500x500.png',
    // Original Yamaha jet ski images (all sizes)
    'https://marbellajetski.com/wp-content/uploads/2021/05/2021-Yamaha-VXCRUISERHO-EU-Yellow-Action-001-03-1.jpg',
    'https://marbellajetski.com/wp-content/uploads/2021/05/2021-Yamaha-VXCRUISERHO-EU-Yellow-Action-001-03-1-1536x864.jpg',
    'https://marbellajetski.com/wp-content/uploads/2021/05/2021-Yamaha-VXCRUISERHO-EU-Yellow-Action-001-03-1-1024x576.jpg',
    'https://marbellajetski.com/wp-content/uploads/2021/05/2021-Yamaha-VXCRUISERHO-EU-Yellow-Action-001-03-1-768x432.jpg',
    'https://marbellajetski.com/wp-content/uploads/2021/05/2021-Yamaha-VXCRUISERHO-EU-Yellow-Action-001-03-1-600x338.jpg',
    // Original yacht images
    'https://marbellajetski.com/wp-content/uploads/2025/08/ChatGPT-Image-12-ago-2025-11_28_51.png',
    'https://marbellajetski.com/wp-content/uploads/2025/08/ChatGPT-Image-12-ago-2025-11_28_51-768x512.png',
    'https://marbellajetski.com/wp-content/uploads/2025/08/ChatGPT-Image-12-ago-2025-11_28_51-600x400.png',
    'https://marbellajetski.com/wp-content/uploads/2025/08/2021-cranchi-endurance-39-power-9670500-20250131064459679-1_LARGE.jpg',
    'https://marbellajetski.com/wp-content/uploads/2025/08/2021-cranchi-endurance-39-power-9670500-20250131064459679-1_LARGE-300x224.jpg',
    'https://marbellajetski.com/wp-content/uploads/2025/08/676709ae66657-l.jpeg',
    'https://marbellajetski.com/wp-content/uploads/2025/08/676709ae66657-l-768x455.jpeg',
    // Original beach image
    'https://marbellajetski.com/wp-content/uploads/2023/05/IMG_3961-scaled.webp',
    'https://marbellajetski.com/wp-content/uploads/2023/05/IMG_3961-1024x683.webp',
    // Original ISO certificates
    'https://marbellajetski.com/wp-content/uploads/2022/05/WhatsApp-Image-2022-05-13-at-7.22.08-PM.jpeg',
    'https://marbellajetski.com/wp-content/uploads/2022/05/WhatsApp-Image-2022-05-13-at-7.22.21-PM.jpeg'
];

// Install event - cache assets
self.addEventListener('install', event => {
    event.waitUntil(
        caches.open(CACHE_NAME)
            .then(cache => {
                console.log('Caching app shell');
                return cache.addAll(ASSETS_TO_CACHE);
            })
            .catch(err => {
                console.log('Cache install failed:', err);
            })
    );
    self.skipWaiting();
});

// Activate event - clean up old caches
self.addEventListener('activate', event => {
    event.waitUntil(
        caches.keys().then(cacheNames => {
            return Promise.all(
                cacheNames.map(cacheName => {
                    if (cacheName !== CACHE_NAME) {
                        console.log('Deleting old cache:', cacheName);
                        return caches.delete(cacheName);
                    }
                })
            );
        })
    );
    self.clients.claim();
});

// Fetch event - network-first for local files, cache-first for CDN
self.addEventListener('fetch', event => {
    // Skip non-GET requests
    if (event.request.method !== 'GET') return;
    
    // Skip chrome-extension and other non-http(s) requests
    if (!event.request.url.startsWith('http')) return;

    // Skip API calls — always go to network
    if (event.request.url.includes('api.open-meteo.com')) return;
    
    // Check if this is a local file that should use network-first
    const isLocal = LOCAL_FILES.some(f => event.request.url.includes(f)) || event.request.mode === 'navigate';
    
    if (isLocal) {
        // Network-first for local files — always get latest version
        event.respondWith(
            fetch(event.request)
                .then(response => {
                    if (response && response.status === 200) {
                        const responseToCache = response.clone();
                        caches.open(CACHE_NAME).then(cache => cache.put(event.request, responseToCache));
                    }
                    return response;
                })
                .catch(() => {
                    return caches.match(event.request).then(cached => {
                        return cached || (event.request.mode === 'navigate' ? caches.match(OFFLINE_URL) : undefined);
                    });
                })
        );
    } else {
        // Cache-first for CDN assets (fonts, icons, external libraries)
        event.respondWith(
            caches.match(event.request)
                .then(cachedResponse => {
                    if (cachedResponse) return cachedResponse;
                    return fetch(event.request).then(response => {
                        if (!response || response.status !== 200) return response;
                        const responseToCache = response.clone();
                        caches.open(CACHE_NAME).then(cache => cache.put(event.request, responseToCache));
                        return response;
                    }).catch(() => {
                        if (event.request.mode === 'navigate') return caches.match(OFFLINE_URL);
                    });
                })
        );
    }
});

// Background sync for offline form submissions
self.addEventListener('sync', event => {
    if (event.tag === 'booking-sync') {
        event.waitUntil(
            console.log('Syncing offline bookings...')
        );
    }
});

// Push notifications
self.addEventListener('push', event => {
    const options = {
        body: event.data ? event.data.text() : 'New update from Marbella Jet Ski!',
        icon: 'https://marbellajetski.com/wp-content/uploads/2021/05/MJS_16_500x500.png',
        badge: 'https://marbellajetski.com/wp-content/uploads/2021/05/MJS_16_500x500-removebg-preview.png',
        vibrate: [100, 50, 100],
        data: {
            dateOfArrival: Date.now(),
            primaryKey: 1
        },
        actions: [
            { action: 'book', title: 'Book Now' },
            { action: 'close', title: 'Close' }
        ]
    };
    
    event.waitUntil(
        self.registration.showNotification('Marbella Jet Ski', options)
    );
});

// Notification click handler
self.addEventListener('notificationclick', event => {
    event.notification.close();
    
    if (event.action === 'book') {
        clients.openWindow('/booking.html');
    } else {
        clients.openWindow('/');
    }
});
