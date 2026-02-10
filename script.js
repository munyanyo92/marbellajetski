/* ========================================
   MARBELLA JETSKI - Interactive JavaScript
   Premium Water Sports Website - Summer 2026
   ======================================== */

// Initialize functions after DOM loads
document.addEventListener('DOMContentLoaded', function() {
    setTimeout(() => {
        try {
            initNavigation();
        } catch(e) { console.log('Nav error:', e); }
        
        try {
            initSmoothScroll();
        } catch(e) { console.log('Scroll error:', e); }
        
        try {
            initBackToTop();
        } catch(e) { console.log('Back-to-top error:', e); }
        
        try {
            initCookieConsent();
        } catch(e) { console.log('Cookie error:', e); }
        
        try {
            initServiceWorker();
        } catch(e) { console.log('SW error:', e); }
        
        try {
            initSwiper();
        } catch(e) { console.log('Swiper error:', e); }
        
        try {
            initStats();
        } catch(e) { console.log('Stats error:', e); }
        
        try {
            initGallery();
        } catch(e) { console.log('Gallery error:', e); }
        
        try {
            initFAQ();
        } catch(e) { console.log('FAQ error:', e); }
        
        try {
            initActivityFilter();
        } catch(e) { console.log('Filter error:', e); }

        try {
            initWeather();
        } catch(e) { console.log('Weather error:', e); }
    }, 100);
});

/* ========== Navigation ========== */
function initNavigation() {
    const navbar = document.getElementById('navbar');
    const navToggle = document.getElementById('navToggle');
    const navMenu = document.getElementById('navMenu');
    const navLinks = document.querySelectorAll('.nav-link');
    
    // Scroll effect for navbar
    window.addEventListener('scroll', () => {
        if (window.scrollY > 50) {
            navbar.classList.add('scrolled');
        } else {
            navbar.classList.remove('scrolled');
        }
    });
    
    // Mobile menu toggle
    navToggle.addEventListener('click', () => {
        navMenu.classList.toggle('active');
        navToggle.classList.toggle('active');
    });
    
    // Close mobile menu on link click
    navLinks.forEach(link => {
        link.addEventListener('click', () => {
            navMenu.classList.remove('active');
            navToggle.classList.remove('active');
        });
    });
    
    // Active link on scroll
    window.addEventListener('scroll', () => {
        let current = '';
        const sections = document.querySelectorAll('section[id]');
        
        sections.forEach(section => {
            const sectionTop = section.offsetTop - 150;
            const sectionHeight = section.offsetHeight;
            
            if (window.scrollY >= sectionTop && window.scrollY < sectionTop + sectionHeight) {
                current = section.getAttribute('id');
            }
        });
        
        navLinks.forEach(link => {
            link.classList.remove('active');
            if (link.getAttribute('href') === `#${current}`) {
                link.classList.add('active');
            }
        });
    });
}

/* ========== Smooth Scroll ========== */
function initSmoothScroll() {
    document.querySelectorAll('a[href^="#"]').forEach(anchor => {
        anchor.addEventListener('click', function(e) {
            e.preventDefault();
            const targetId = this.getAttribute('href');
            
            if (targetId === '#') return;
            
            const target = document.querySelector(targetId);
            if (target) {
                const offsetTop = target.offsetTop - 80;
                window.scrollTo({
                    top: offsetTop,
                    behavior: 'smooth'
                });
            }
        });
    });
}

/* ========== Animated Stats Counter ========== */
function initStats() {
    const stats = document.querySelectorAll('.stat-number[data-count]');
    
    const observerOptions = {
        threshold: 0.5,
        rootMargin: '0px'
    };
    
    const statsObserver = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                const stat = entry.target;
                const target = parseInt(stat.getAttribute('data-count'));
                if (!isNaN(target)) {
                    animateCounter(stat, target);
                }
                statsObserver.unobserve(stat);
            }
        });
    }, observerOptions);
    
    stats.forEach(stat => {
        statsObserver.observe(stat);
    });
}

function animateCounter(element, target) {
    let current = 0;
    const increment = target / 100;
    const duration = 2000;
    const stepTime = duration / 100;
    
    const timer = setInterval(() => {
        current += increment;
        if (current >= target) {
            current = target;
            clearInterval(timer);
        }
        
        if (target >= 1000) {
            element.textContent = Math.floor(current).toLocaleString();
        } else {
            element.textContent = Math.floor(current);
        }
    }, stepTime);
}

/* ========== Swiper Testimonials ========== */
function initSwiper() {
    if (typeof Swiper !== 'undefined') {
        new Swiper('.testimonials-swiper', {
            slidesPerView: 1,
            spaceBetween: 30,
            loop: true,
            autoplay: {
                delay: 5000,
                disableOnInteraction: false
            },
            pagination: {
                el: '.swiper-pagination',
                clickable: true
            },
            breakpoints: {
                640: {
                    slidesPerView: 2
                },
                1024: {
                    slidesPerView: 3
                }
            }
        });

        // Jetski option image carousels
        document.querySelectorAll('.jetski-carousel').forEach(el => {
            new Swiper(el, {
                slidesPerView: 1,
                loop: true,
                autoplay: { delay: 4000, disableOnInteraction: false },
                pagination: { el: el.querySelector('.swiper-pagination'), clickable: true },
                effect: 'fade',
                fadeEffect: { crossFade: true }
            });
        });
    }
}

/* ========== Gallery Lightbox ========== */
const galleryImages = [
    'https://marbellajetski.com/wp-content/uploads/2023/05/IMG_0052-scaled.webp',
    'assets/media/photos/cranchi-39.jpg',
    'assets/media/photos/azimut-39.jpg',
    'https://marbellajetski.com/wp-content/uploads/2023/05/IMG_3961-scaled.webp',
    'https://marbellajetski.com/wp-content/uploads/2021/07/IMG_6208-scaled.jpg',
    'https://marbellajetski.com/wp-content/uploads/2023/05/IMG_3846-scaled.webp',
    'https://marbellajetski.com/wp-content/uploads/2023/05/DSC_0055-scaled.webp',
    'https://marbellajetski.com/wp-content/uploads/2023/05/DSC_0031-scaled.webp',
    'assets/media/racing/racing-benalmadena-1.jpg',
    'assets/media/racing/racing-circuit-benidorm.png',
    'assets/media/racing/promo-racing.jpg',
    'assets/media/racing/dani-stiers-race-start.jpg',
    'assets/media/racing/racing-jetskis-trailers.jpg',
    'assets/media/photos/blue-jetski.jpg',
    'assets/media/photos/high-res-jetski.jpg',
    'assets/media/photos/waterski-action.jpg',
    'assets/media/photos/catamaran-bali.jpg',
    'assets/media/photos/rinker-296-alt.jpg',
    'assets/media/photos/waterski-action-2.jpg'
];

let currentImageIndex = 0;

function initGallery() {
    const lightbox = document.getElementById('lightbox');
    
    // Close on overlay click
    lightbox.addEventListener('click', (e) => {
        if (e.target === lightbox) {
            closeLightbox();
        }
    });
    
    // Keyboard navigation
    document.addEventListener('keydown', (e) => {
        if (!lightbox.classList.contains('active')) return;
        
        if (e.key === 'Escape') closeLightbox();
        if (e.key === 'ArrowLeft') changeLightboxImage(-1);
        if (e.key === 'ArrowRight') changeLightboxImage(1);
    });
}

function openLightbox(index) {
    currentImageIndex = index;
    const lightbox = document.getElementById('lightbox');
    const lightboxImage = document.getElementById('lightboxImage');
    
    lightboxImage.src = galleryImages[index];
    lightbox.classList.add('active');
    document.body.style.overflow = 'hidden';
}

function closeLightbox() {
    const lightbox = document.getElementById('lightbox');
    lightbox.classList.remove('active');
    document.body.style.overflow = 'visible';
}

function changeLightboxImage(direction) {
    currentImageIndex += direction;
    
    if (currentImageIndex >= galleryImages.length) {
        currentImageIndex = 0;
    } else if (currentImageIndex < 0) {
        currentImageIndex = galleryImages.length - 1;
    }
    
    const lightboxImage = document.getElementById('lightboxImage');
    lightboxImage.style.opacity = '0';
    
    setTimeout(() => {
        lightboxImage.src = galleryImages[currentImageIndex];
        lightboxImage.style.opacity = '1';
    }, 200);
}

// Make functions globally available
window.openLightbox = openLightbox;
window.closeLightbox = closeLightbox;
window.changeLightboxImage = changeLightboxImage;

/* ========== FAQ Accordion ========== */
function initFAQ() {
    const faqItems = document.querySelectorAll('.faq-item');
    
    faqItems.forEach(item => {
        const question = item.querySelector('.faq-question');
        
        question.addEventListener('click', () => {
            const isActive = item.classList.contains('active');
            
            // Close all other items
            faqItems.forEach(otherItem => {
                otherItem.classList.remove('active');
                const btn = otherItem.querySelector('.faq-question');
                if (btn) btn.setAttribute('aria-expanded', 'false');
            });
            
            // Toggle current item
            if (!isActive) {
                item.classList.add('active');
                question.setAttribute('aria-expanded', 'true');
            }
        });
    });
}

/* ========== Activity Filter ========== */
function initActivityFilter() {
    const categoryBtns = document.querySelectorAll('.category-btn');
    const activityCards = document.querySelectorAll('.activity-card');
    
    categoryBtns.forEach(btn => {
        btn.addEventListener('click', () => {
            // Update active button
            categoryBtns.forEach(b => b.classList.remove('active'));
            btn.classList.add('active');
            
            const category = btn.dataset.category;
            
            // Filter activities
            activityCards.forEach(card => {
                const cardCategories = card.dataset.category;
                
                if (category === 'all' || cardCategories.includes(category)) {
                    card.style.display = 'block';
                    card.style.animation = 'fadeInUp 0.5s ease';
                } else {
                    card.style.display = 'none';
                }
            });
        });
    });
}

/* ========== Back to Top Button ========== */
function initBackToTop() {
    const backToTopBtn = document.getElementById('backToTop');
    
    window.addEventListener('scroll', () => {
        if (window.scrollY > 500) {
            backToTopBtn.classList.add('visible');
        } else {
            backToTopBtn.classList.remove('visible');
        }
    });
    
    backToTopBtn.addEventListener('click', () => {
        window.scrollTo({
            top: 0,
            behavior: 'smooth'
        });
    });
}

/* ========== Video Lazy Loading ========== */
document.addEventListener('DOMContentLoaded', () => {
    const video = document.getElementById('heroVideo');
    if (video) {
        video.play().catch(() => {
            // Autoplay was prevented, show a fallback
            console.log('Video autoplay prevented by browser');
        });
    }
});

/* ========== Scroll Progress Bar ========== */
// Removed

/* ========== Cookie Consent ========== */
function initCookieConsent() {
    // Check if consent was already given
    if (localStorage.getItem('cookieConsent')) return;
    
    const banner = document.createElement('div');
    banner.className = 'cookie-banner show';
    banner.innerHTML = `
        <p>
            <i class="fas fa-cookie-bite"></i>
            We use cookies to enhance your experience. By continuing to visit this site, you agree to our use of cookies.
            <a href="terms.html#cookies">Learn more</a>
        </p>
        <div class="cookie-buttons">
            <button class="cookie-btn accept" onclick="acceptCookies()">Accept All</button>
            <button class="cookie-btn decline" onclick="declineCookies()">Decline</button>
        </div>
    `;
    
    document.body.appendChild(banner);
}

window.acceptCookies = function() {
    localStorage.setItem('cookieConsent', 'accepted');
    document.querySelector('.cookie-banner').remove();
    showNotification('Thanks! Cookie preferences saved.', 'success');
};

window.declineCookies = function() {
    localStorage.setItem('cookieConsent', 'declined');
    document.querySelector('.cookie-banner').remove();
};

/* ========== Service Worker Registration ========== */
function initServiceWorker() {
    if ('serviceWorker' in navigator) {
        window.addEventListener('load', () => {
            navigator.serviceWorker.register('/sw.js')
                .then(registration => {
                    console.log('SW registered:', registration);
                })
                .catch(error => {
                    console.log('SW registration failed (expected in development):', error);
                });
        });
    }
}

/* ========== Image Lazy Loading ========== */
if ('IntersectionObserver' in window) {
    const imageObserver = new IntersectionObserver((entries, observer) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                const img = entry.target;
                if (img.dataset.src) {
                    img.src = img.dataset.src;
                    img.removeAttribute('data-src');
                    observer.unobserve(img);
                }
            }
        });
    });
    
    document.querySelectorAll('img[data-src]').forEach(img => {
        imageObserver.observe(img);
    });
}

/* ========== Console Easter Egg ========== */
console.log(`
%c🌊 MARBELLA JETSKI 🌊
%cCosta del Sol's Premier Water Sports Experience

%c✨ Looking for a job? We're always looking for talented people!
   Contact us at: jetskimarbella@gmail.com

%c🏆 Built with passion for Summer 2026
   Owner: Daniel Stiers - Pro Racing Champion
   Since 1998 - Over 25 Years of Excellence

`, 
'font-size: 24px; font-weight: bold; color: #0ea5e9;',
'font-size: 14px; color: #374151;',
'font-size: 12px; color: #10b981;',
'font-size: 11px; color: #6b7280;'
);

/* ========== Performance Optimization ========== */
// Debounce function for scroll events
function debounce(func, wait = 10) {
    let timeout;
    return function executedFunction(...args) {
        const later = () => {
            clearTimeout(timeout);
            func(...args);
        };
        clearTimeout(timeout);
        timeout = setTimeout(later, wait);
    };
}

// Throttle function for frequent events
function throttle(func, limit = 100) {
    let inThrottle;
    return function(...args) {
        if (!inThrottle) {
            func.apply(this, args);
            inThrottle = true;
            setTimeout(() => inThrottle = false, limit);
        }
    };
}

/* ========== Live Weather Widget (Open-Meteo — no API key) ========== */
function initWeather() {
    var el = document.getElementById('wx-temp');
    if (!el) return;

    // Marbella coordinates
    var lat = 36.5099, lon = -4.8854;
    var url = 'https://api.open-meteo.com/v1/forecast?latitude=' + lat
        + '&longitude=' + lon
        + '&current=temperature_2m,relative_humidity_2m,weather_code,wind_speed_10m'
        + '&daily=uv_index_max'
        + '&timezone=Europe%2FMadrid';

    fetch(url)
        .then(function(r) { return r.json(); })
        .then(function(d) {
            var c = d.current;
            if (!c) return;

            // Temperature
            var tempEl = document.getElementById('wx-temp');
            if (tempEl) tempEl.textContent = Math.round(c.temperature_2m) + '°C';

            // Weather description from WMO code
            var descEl = document.getElementById('wx-desc');
            if (descEl) descEl.textContent = wmoDesc(c.weather_code);

            // Wind speed
            var windEl = document.getElementById('wx-wind');
            if (windEl) windEl.textContent = Math.round(c.wind_speed_10m) + ' km/h';

            // Humidity
            var humEl = document.getElementById('wx-hum');
            if (humEl) humEl.textContent = Math.round(c.relative_humidity_2m) + '%';

            // Sea temp estimate (Marbella Mediterranean averages by month)
            var seaEl = document.getElementById('wx-sea');
            if (seaEl) {
                var month = new Date().getMonth(); // 0-11
                var seaTemps = [15, 14, 14, 15, 17, 20, 23, 25, 24, 21, 18, 16];
                seaEl.textContent = seaTemps[month] + '°C';
            }
        })
        .catch(function(err) {
            console.log('Weather fetch error:', err);
        });
}

function wmoDesc(code) {
    var map = {
        0: 'Clear sky', 1: 'Mostly clear', 2: 'Partly cloudy', 3: 'Overcast',
        45: 'Foggy', 48: 'Rime fog',
        51: 'Light drizzle', 53: 'Drizzle', 55: 'Heavy drizzle',
        61: 'Light rain', 63: 'Rain', 65: 'Heavy rain',
        71: 'Light snow', 73: 'Snow', 75: 'Heavy snow',
        80: 'Light showers', 81: 'Showers', 82: 'Heavy showers',
        95: 'Thunderstorm', 96: 'Thunderstorm + hail', 99: 'Thunderstorm + hail'
    };
    return map[code] || 'Fair';
}

/* F: Make service-card / jetski-option cards fully clickable */
document.querySelectorAll('.service-card, .jetski-option').forEach(function(card) {
    card.addEventListener('click', function(e) {
        if (e.target.closest('a')) return; // let real links work
        var link = card.querySelector('.service-link, .option-cta');
        if (link) link.click();
    });
});

