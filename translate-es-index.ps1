$file = "C:\Users\Usuario\Website Marbella Jetski\es\index.html"
$content = Get-Content -Path $file -Raw -Encoding UTF8

# ============================================================
# SECTION 1: HTML lang, meta tags, and structured data
# ============================================================

$content = $content.Replace('<html lang="en">', '<html lang="es">')

$content = $content.Replace(
    '<title>Marbella JetSki | #1 Jet Ski & Water Sports Experience on Costa del Sol</title>',
    '<title>Marbella JetSki | Alquiler de Motos de Agua y Deportes Acuáticos en la Costa del Sol</title>'
)

$content = $content.Replace(
    'content="Premier jet ski hire, luxury boat rentals & water sports in Marbella. 25+ years experience. Family-owned by 4x national champion Daniel Stiers. Book your Summer 2026 adventure!"',
    'content="Alquiler de motos de agua, charter de yates de lujo y deportes acuáticos en Marbella. Más de 25 años de experiencia. Empresa familiar del 4 veces campeón nacional Daniel Stiers. ¡Reserva tu aventura de verano 2026!"'
)

$content = $content.Replace(
    'content="jet ski marbella, water sports costa del sol, boat rental marbella, puerto banus excursions, watersports spain"',
    'content="motos de agua marbella, deportes acuáticos costa del sol, alquiler barcos marbella, excursiones puerto banús, actividades acuáticas españa"'
)

$content = $content.Replace(
    '<link rel="canonical" href="https://marbellajetski.com">',
    '<link rel="canonical" href="https://marbellajetski.com/es/">'
)

# OG title
$content = $content.Replace(
    'content="Marbella JetSki | #1 Water Sports Experience on Costa del Sol"',
    'content="Marbella JetSki | Deportes Acuáticos en la Costa del Sol"'
)

# OG description (file uses raw &)
$content = $content.Replace(
    'content="Premier jet ski hire, luxury yacht charters & water sports in Marbella. 25+ years experience. Family-owned by 4x national champion Daniel Stiers."',
    'content="Alquiler de motos de agua, chárter de yates de lujo y deportes acuáticos en Marbella. Más de 25 años de experiencia. Empresa familiar del 4 veces campeón nacional Daniel Stiers."'
)

$content = $content.Replace(
    '<meta property="og:locale" content="en_GB">',
    '<meta property="og:locale" content="es_ES">'
)

# Twitter title
$content = $content.Replace(
    'content="Marbella JetSki | #1 Water Sports Experience"',
    'content="Marbella JetSki | Deportes Acuáticos en Marbella"'
)

# Twitter description (file uses raw &)
$content = $content.Replace(
    'content="Premier jet ski hire, luxury yacht charters & water sports on Costa del Sol."',
    'content="Alquiler de motos de agua, chárter de yates de lujo y deportes acuáticos en la Costa del Sol."'
)

# JSON-LD description (file uses raw &)
$content = $content.Replace(
    '"description": "Premier jet ski hire, luxury boat rentals & water sports in Marbella"',
    '"description": "Alquiler de motos de agua, barcos de lujo y deportes acuáticos en Marbella"'
)

# JSON-LD founder jobTitle (file uses raw &)
$content = $content.Replace(
    '"Founder & Pro Racing Champion"',
    '"Fundador y Campeón de Competición"'
)

# ============================================================
# SECTION 2: Skip link
# ============================================================

$content = $content.Replace('>Skip to content</a>', '>Ir al contenido</a>')

# ============================================================
# SECTION 3: Language Selector (swap to English flag)
# ============================================================

$content = $content.Replace(
    'href="es/index.html" class="nav-lang" title="Versión en español"',
    'href="../index.html" class="nav-lang" title="English version"'
)
$content = $content.Replace(
    '<img src="https://flagcdn.com/w40/es.png" alt="Español" width="24" height="16">',
    '<img src="https://flagcdn.com/w40/gb.png" alt="English" width="24" height="16">'
)
$content = $content.Replace('<span>ES</span>', '<span>EN</span>')

# ============================================================
# SECTION 4: Navigation
# ============================================================

$content = $content.Replace('>Home</a>', '>Inicio</a>')
$content = $content.Replace('>Services</a>', '>Servicios</a>')
$content = $content.Replace('>Jet Ski</a>', '>Motos de Agua</a>')
$content = $content.Replace('>Water Sports</a>', '>Deportes</a>')
$content = $content.Replace('>Yachts</a>', '>Yates</a>')
$content = $content.Replace('>Racing</a>', '>Competición</a>')
# Nav uses &amp; (confirmed in file)
$content = $content.Replace('>About &amp; Lessons</a>', '>Sobre Nosotros</a>')
# Contact in nav (only nav-link context uses ">Contact</a>")
$content = $content.Replace('class="nav-link">Contact</a>', 'class="nav-link">Contacto</a>')
# Nav CTA button
$content = $content.Replace('<span>Book Now</span>', '<span>Reservar</span>')

# ============================================================
# SECTION 5: Hero Section
# ============================================================

# Promo overlay (these 2 lines use &amp; in the actual file)
$content = $content.Replace(
    '<strong>Book Before Summer &amp; Save 10%!</strong>',
    '<strong>¡Reserva Antes del Verano y Ahorra un 10%!</strong>'
)
$content = $content.Replace(
    '<span>Early bird discount on all jet ski &amp; yacht bookings for June–September 2026</span>',
    '<span>Descuento por reserva anticipada en motos de agua y yates para junio–septiembre 2026</span>'
)

# Hero title
$content = $content.Replace(
    '<span class="title-line">Experience the</span>',
    '<span class="title-line">Vive la</span>'
)
$content = $content.Replace(
    '<span class="title-highlight">Ultimate Thrill</span>',
    '<span class="title-highlight">Máxima Emoción</span>'
)
$content = $content.Replace(
    '<span class="title-line">on the Mediterranean</span>',
    '<span class="title-line">en el Mediterráneo</span>'
)

# Hero subtitle
$content = $content.Replace(
    'Premium Jet Ski Rentals · Luxury Yacht Charters · Water Sports Adventures',
    'Alquiler de Motos de Agua · Chárter de Yates de Lujo · Aventuras Acuáticas'
)

# Hero stats
$content = $content.Replace('<span class="stat-label">Established</span>', '<span class="stat-label">Desde</span>')
$content = $content.Replace('<span class="stat-label">Activities</span>', '<span class="stat-label">Actividades</span>')
$content = $content.Replace('<span class="stat-label">Rating</span>', '<span class="stat-label">Valoración</span>')

# Hero action buttons
$content = $content.Replace('<span>Book Your Adventure</span>', '<span>Reserva Tu Aventura</span>')
$content = $content.Replace('<span>WhatsApp Us</span>', '<span>Escríbenos por WhatsApp</span>')

# Weather widget
$content = $content.Replace('<span class="weather-label">sea</span>', '<span class="weather-label">mar</span>')
$content = $content.Replace('<span class="weather-label">humidity</span>', '<span class="weather-label">humedad</span>')

# ============================================================
# SECTION 6: Services Section
# ============================================================

$content = $content.Replace('<span class="section-tag">What We Offer</span>', '<span class="section-tag">Lo Que Ofrecemos</span>')

$content = $content.Replace(
    'Your Aquatic <span class="gradient-text">Adventure</span> Awaits',
    'Tu <span class="gradient-text">Aventura</span> Acuática Te Espera'
)

$content = $content.Replace(
    'From adrenaline-pumping jet ski rides to relaxing yacht cruises, we have the perfect experience for everyone',
    'Desde emocionantes paseos en moto de agua hasta relajados cruceros en yate, tenemos la experiencia perfecta para todos'
)

$content = $content.Replace('<span class="service-tag">Most Popular</span>', '<span class="service-tag">Más Popular</span>')
$content = $content.Replace('<h3>Jet Ski Hire</h3>', '<h3>Alquiler de Motos de Agua</h3>')


$content = $content.Replace(
    'Experience the thrill on our latest Yamaha jet skis. Circuit rides or coastal excursions available.',
    'Vive la emoción en nuestras motos de agua Yamaha de última generación. Circuito o excursiones costeras.'
)

# From labels (all instances in service cards)
$content = $content.Replace('<span class="from">From</span>', '<span class="from">Desde</span>')

$content = $content.Replace('<span>Explore Options</span>', '<span>Ver Opciones</span>')

$content = $content.Replace('<span class="service-tag">Luxury</span>', '<span class="service-tag">Lujo</span>')
$content = $content.Replace('<h3>Yacht Charters</h3>', '<h3>Chárter de Yates</h3>')

$content = $content.Replace(
    'Cruise the coast in style. Captain, fuel, drinks and paddleboard included.',
    'Navega por la costa con estilo. Capitán, combustible, bebidas y paddle surf incluidos.'
)

# Duration labels (all instances)
$content = $content.Replace('<span class="duration">/ hour</span>', '<span class="duration">/ hora</span>')
$content = $content.Replace('<span class="duration">/ person</span>', '<span class="duration">/ persona</span>')

$content = $content.Replace('<span>View Fleet</span>', '<span>Ver Flota</span>')

$content = $content.Replace('<span class="service-tag">Family Fun</span>', '<span class="service-tag">Diversión Familiar</span>')
$content = $content.Replace('<h3>Water Sports</h3>', '<h3>Deportes Acuáticos</h3>')

# File uses raw & here
$content = $content.Replace(
    'Wakeboarding, banana boats, crazy sofa, donuts & more for all ages!',
    'Wakeboard, banana boat, crazy sofa, donuts ¡y mucho más para todas las edades!'
)

$content = $content.Replace('<span>See Activities</span>', '<span>Ver Actividades</span>')

$content = $content.Replace('<span class="service-tag">Adventure</span>', '<span class="service-tag">Aventura</span>')
$content = $content.Replace('<h3>Guided Excursions</h3>', '<h3>Excursiones Guiadas</h3>')

$content = $content.Replace(
    'Explore Puerto Banús, Fuengirola and hidden coves with our expert guides.',
    'Descubre Puerto Banús, Fuengirola y calas escondidas con nuestros guías expertos.'
)

$content = $content.Replace('<span>Book Tour</span>', '<span>Reservar Tour</span>')

# ============================================================
# SECTION 7: Why Choose Us
# ============================================================

$content = $content.Replace(
    '<span class="section-tag">Why Marbella JetSki?</span>',
    '<span class="section-tag">¿Por Qué Marbella JetSki?</span>'
)

$content = $content.Replace(
    'The <span class="gradient-text">Difference</span> Is Clear',
    'La <span class="gradient-text">Diferencia</span> Es Clara'
)

$content = $content.Replace(
    'We''re not just another rental company — we''re the Costa del Sol''s most trusted water sports centre',
    'No somos una empresa de alquiler más — somos el centro de deportes acuáticos de mayor confianza de la Costa del Sol'
)

$content = $content.Replace('<h4>GPS-Tracked Fleet (OtoTrak)</h4>', '<h4>Flota con GPS (OtoTrak)</h4>')

$content = $content.Replace(
    'Every jet ski is <strong>live-tracked via OtoTrak GPS</strong> for real-time monitoring. Our operations centre tracks speed, position, and perimeter — ensuring total safety at all times.',
    'Cada moto de agua está <strong>rastreada en tiempo real mediante GPS OtoTrak</strong>. Nuestro centro de operaciones controla velocidad, posición y perímetro, garantizando la máxima seguridad en todo momento.'
)

$content = $content.Replace('<h4>Premium Jet Ski Experiences</h4>', '<h4>Experiencias Premium en Moto de Agua</h4>')

$content = $content.Replace(
    'We combine <strong>safety, quality, and excitement</strong> to deliver the best jet ski experience on the Costa del Sol. Professional equipment, expert team, and unforgettable memories.',
    'Combinamos <strong>seguridad, calidad y emoción</strong> para ofrecer la mejor experiencia en moto de agua de la Costa del Sol. Equipamiento profesional, equipo experto y recuerdos inolvidables.'
)

$content = $content.Replace('<h4>Maritime Qualified Team</h4>', '<h4>Equipo con Titulación Marítima</h4>')

$content = $content.Replace(
    'Our <strong>entire team holds maritime safety qualifications</strong>. Every ride includes a mandatory safety briefing, certified equipment, and a support boat within 300m.',
    '<strong>Todo nuestro equipo cuenta con titulaciones de seguridad marítima</strong>. Cada actividad incluye briefing de seguridad obligatorio, equipamiento certificado y embarcación de apoyo a menos de 300 m.'
)

$content = $content.Replace('<h4>Professional Photos</h4>', '<h4>Fotos Profesionales</h4>')

$content = $content.Replace(
    'Our team captures <strong>high-quality digital photos during your activity</strong>. After the session, browse and purchase your memories. Leave your phone safe on shore!',
    'Nuestro equipo captura <strong>fotos digitales de alta calidad durante tu actividad</strong>. Después de la sesión, revisa y compra tus recuerdos. ¡Deja el móvil a salvo en tierra!'
)

$content = $content.Replace('<h4>Family Business Since 1998</h4>', '<h4>Empresa Familiar Desde 1998</h4>')

$content = $content.Replace(
    'Over <strong>25 years of trusted experience</strong>. STIERS E HIJOS S.L. has served tens of thousands of happy customers with a personal, family touch.',
    'Más de <strong>25 años de experiencia y confianza</strong>. STIERS E HIJOS S.L. ha atendido a decenas de miles de clientes satisfechos con un trato personal y familiar.'
)

# File uses raw & here
$content = $content.Replace('<h4>ISO 9001 & 14001 Certified</h4>', '<h4>Certificación ISO 9001 y 14001</h4>')

$content = $content.Replace(
    'Certified by OCA Global for both <strong>quality and environmental management</strong>. Daily mechanical inspections and up-to-date ITB certifications on all craft.',
    'Certificados por OCA Global en <strong>gestión de calidad y medioambiental</strong>. Inspecciones mecánicas diarias y certificaciones ITB actualizadas en todas las embarcaciones.'
)

# ============================================================
# SECTION 8: Jet Ski Section
# ============================================================

$content = $content.Replace('<span class="section-tag">Jet Ski Hire</span>', '<span class="section-tag">Alquiler de Motos de Agua</span>')

$content = $content.Replace(
    'Feel the <span class="gradient-text">Power</span>',
    'Siente la <span class="gradient-text">Potencia</span>'
)

$content = $content.Replace(
    'Latest 2024-2025 Yamaha VX (TR-1 HO, 1049 cc, ~125 hp) — GPS-tracked for safety and performance',
    'Yamaha VX 2024-2025 (TR-1 HO, 1049 cc, ~125 CV) — rastreadas por GPS para tu seguridad'
)

$content = $content.Replace('<span>Perfect for Beginners</span>', '<span>Ideal para Principiantes</span>')
$content = $content.Replace('<h3>Jet Ski in the Circuit</h3>', '<h3>Moto de Agua en Circuito</h3>')

# Difficulty labels (all instances)
$content = $content.Replace('<span class="difficulty-label">Difficulty:</span>', '<span class="difficulty-label">Dificultad:</span>')

# Circuit difficulty: Easy
$content = $content.Replace(
    'Perfect for beginners or those wanting a fun ride in a safe, controlled environment. Circuit with 4 buoys within a controlled perimeter. Supervised by instructors with support boats. Max. 4 jet skis simultaneously. All jet skis are GPS-tracked for operational safety (OtoTrak system).',
    'Perfecto para principiantes o para quienes buscan diversión en un entorno seguro y controlado. Circuito con 4 boyas dentro de un perímetro controlado. Supervisado por instructores con embarcaciones de apoyo. Máx. 4 motos de agua simultáneamente. Todas las motos están rastreadas por GPS (sistema OtoTrak).'
)

$content = $content.Replace(
    'Each jet ski can carry 2 people and you can swap driver during the session — same price.',
    'Cada moto de agua admite 2 personas y podéis intercambiar el piloto durante la sesión — mismo precio.'
)

# Popular badges (all instances)
$content = $content.Replace('<span class="popular-badge">Most Popular</span>', '<span class="popular-badge">Más Popular</span>')

# Pricing time labels — do longer strings first to avoid partial matches
$content = $content.Replace('<i class="fas fa-clock"></i> 1 hour excursion', '<i class="fas fa-clock"></i> Excursión 1 hora')
$content = $content.Replace('<i class="fas fa-clock"></i> 2 hour excursion', '<i class="fas fa-clock"></i> Excursión 2 horas')
$content = $content.Replace('<i class="fas fa-clock"></i> 20 minutes', '<i class="fas fa-clock"></i> 20 minutos')
$content = $content.Replace('<i class="fas fa-clock"></i> 30 minutes', '<i class="fas fa-clock"></i> 30 minutos')
$content = $content.Replace('<i class="fas fa-clock"></i> 1 hour</span>', '<i class="fas fa-clock"></i> 1 hora</span>')

# VAT note (all instances)
$content = $content.Replace('All prices include VAT (IVA)', 'Todos los precios incluyen IVA')

# Circuit features
$content = $content.Replace('Safety briefing included', 'Briefing de seguridad incluido')
$content = $content.Replace('Life jacket provided', 'Chaleco salvavidas incluido')
$content = $content.Replace('Instructor supervision', 'Supervisión de instructor')
$content = $content.Replace('GPS tracked (OtoTrak)', 'Rastreo GPS (OtoTrak)')

$content = $content.Replace('<span>Book Circuit Ride</span>', '<span>Reservar Circuito</span>')

# Excursion option
$content = $content.Replace('<span>Coastal Adventure</span>', '<span>Aventura Costera</span>')
$content = $content.Replace('<h3>Jet Ski Excursions</h3>', '<h3>Excursiones en Moto de Agua</h3>')
$content = $content.Replace('<span>Moderate</span>', '<span>Moderada</span>')

$content = $content.Replace(
    'Guided excursions in the open sea along the stunning Costa del Sol coastline. Choose from Puerto Banús, Fuengirola, or our signature Marbella Coastal Tour. Discover hidden coves and breathtaking views of Marbella''s coast and landmarks. Possible dolphin sightings along the route (not guaranteed). All jet skis are GPS-tracked for your safety.',
    'Excursiones guiadas en mar abierto a lo largo de la impresionante costa de la Costa del Sol. Elige entre Puerto Banús, Fuengirola o nuestro Tour Costero por Marbella. Descubre calas escondidas y vistas espectaculares de la costa y los monumentos de Marbella. Posible avistamiento de delfines en la ruta (no garantizado). Todas las motos están rastreadas por GPS para tu seguridad.'
)

$content = $content.Replace(
    '<strong>Minimum 2 jet skis required. Maximum 4 jet skis per excursion.</strong>',
    '<strong>Mínimo 2 motos de agua. Máximo 4 motos por excursión.</strong>'
)

$content = $content.Replace(
    'Each jet ski can carry 2 people (1–2 persons) and you can swap driver during the session — same price per jet ski.',
    'Cada moto de agua admite 2 personas (1-2) y podéis intercambiar el piloto durante la sesión — mismo precio por moto.'
)

$content = $content.Replace('<span>Marbella Coastal</span>', '<span>Costa de Marbella</span>')

# Excursion features
$content = $content.Replace('Guided tour with expert', 'Tour guiado con experto')
$content = $content.Replace('Photo stops at scenic points', 'Paradas fotográficas en puntos panorámicos')
$content = $content.Replace('Support boat nearby', 'Embarcación de apoyo cercana')
$content = $content.Replace('Possible dolphin sighting', 'Posible avistamiento de delfines')

$content = $content.Replace('<span>Book Excursion</span>', '<span>Reservar Excursión</span>')

# ============================================================
# SECTION 9: Water Sports Section
# ============================================================

# File uses raw & here
$content = $content.Replace(
    '<span class="section-tag">Water Sports & Activities</span>',
    '<span class="section-tag">Deportes Acuáticos y Actividades</span>'
)

$content = $content.Replace(
    'Endless <span class="gradient-text">Fun</span> for Everyone',
    '<span class="gradient-text">Diversión</span> Sin Límites para Todos'
)

$content = $content.Replace(
    'From adrenaline-pumping wakeboarding to family-friendly towables - we have it all!',
    'Desde wakeboard lleno de adrenalina hasta hinchables para toda la familia - ¡lo tenemos todo!'
)

# Filter buttons
$content = $content.Replace('>All Activities</button>', '>Todas las Actividades</button>')
$content = $content.Replace('>Individual Sports</button>', '>Deportes Individuales</button>')
$content = $content.Replace('>Family Fun</button>', '>Diversión Familiar</button>')
$content = $content.Replace('>Thrill Seekers</button>', '>Sensaciones Fuertes</button>')
$content = $content.Replace('>Relaxed</button>', '>Relajado</button>')

# Difficulty badges — do longer/more specific first
$content = $content.Replace('<span class="difficulty-badge high">High Intensity</span>', '<span class="difficulty-badge high">Alta Intensidad</span>')
$content = $content.Replace('<span class="difficulty-badge easy">Easy-Medium</span>', '<span class="difficulty-badge easy">Fácil-Media</span>')
$content = $content.Replace('<span class="difficulty-badge medium">Medium-High</span>', '<span class="difficulty-badge medium">Media-Alta</span>')
$content = $content.Replace('<span class="difficulty-badge medium">Medium</span>', '<span class="difficulty-badge medium">Media</span>')
$content = $content.Replace('<span class="difficulty-badge easy">Easy</span>', '<span class="difficulty-badge easy">Fácil</span>')
# Plain span difficulty in jet ski section
$content = $content.Replace('<span>Easy</span>', '<span>Fácil</span>')

# Activity card descriptions
$content = $content.Replace(
    'Glide across the water with maximum adrenaline. Perfect for thrill-seekers!',
    'Deslízate sobre el agua con la máxima adrenalina. ¡Perfecto para amantes de las emociones fuertes!'
)

$content = $content.Replace(
    'Classic water skiing at full speed. An iconic water sport experience!',
    'Esquí acuático clásico a toda velocidad. ¡Una experiencia icónica!'
)

$content = $content.Replace(
    'The favourite for all ages! Hold on tight for a wild ride.',
    '¡El favorito para todas las edades! Agárrate fuerte para un paseo salvaje.'
)

$content = $content.Replace(
    'Surf the waves at high speed - can you stay on?',
    'Surca las olas a toda velocidad - ¿podrás mantenerte?'
)

$content = $content.Replace(
    'The classic water challenge! Great for groups and parties.',
    '¡El clásico desafío acuático! Genial para grupos y fiestas.'
)

$content = $content.Replace(
    'Fly over the waves with stability. Feel the wind!',
    'Vuela sobre las olas con estabilidad. ¡Siente el viento!'
)

$content = $content.Replace(
    'Towable action with unique spins and turns!',
    '¡Acción remolcada con giros y vueltas únicas!'
)

$content = $content.Replace(
    'Explore the coast at your own pace. Great workout too!',
    'Explora la costa a tu ritmo. ¡También es un gran ejercicio!'
)

$content = $content.Replace(
    'Relaxing family fun with slide! Perfect for calm waters.',
    'Diversión familiar relajada con tobogán. ¡Perfecto para aguas tranquilas!'
)

$content = $content.Replace(
    'Explore the coastline together! Perfect for couples and friends who love paddling.',
    '¡Explora la costa juntos! Perfecto para parejas y amigos que disfrutan remando.'
)

# Activity titles
$content = $content.Replace('<h4>Stand-Up Paddleboarding</h4>', '<h4>Paddle Surf</h4>')
$content = $content.Replace('<h4>Pedal Boats</h4>', '<h4>Hidropedales</h4>')
$content = $content.Replace('<h4>Double Kayaks</h4>', '<h4>Kayak Doble</h4>')

# Capacity badges
$content = $content.Replace('Up to 6', 'Hasta 6')
$content = $content.Replace('Up to 8', 'Hasta 8')
$content = $content.Replace('2 people', '2 personas')

# Activity book buttons (all instances)
$content = $content.Replace('class="activity-book">Book Now <i', 'class="activity-book">Reservar <i')

# ============================================================
# SECTION 10: Yacht Section
# ============================================================

$content = $content.Replace('<span class="section-tag">Luxury Fleet</span>', '<span class="section-tag">Flota de Lujo</span>')

# File uses raw & here
$content = $content.Replace(
    'Yacht & Boat <span class="gradient-text">Charters</span>',
    'Chárter de Yates y <span class="gradient-text">Barcos</span>'
)

$content = $content.Replace(
    'Cruise Marbella''s stunning coastline in style. All-inclusive luxury experiences.',
    'Navega por la impresionante costa de Marbella con estilo. Experiencias de lujo todo incluido.'
)

# Yacht features
$content = $content.Replace('<span>Professional Captain</span>', '<span>Capitán Profesional</span>')
$content = $content.Replace('<span>Fuel Included</span>', '<span>Combustible Incluido</span>')
# File uses raw &
$content = $content.Replace('<span>Drinks & Wine</span>', '<span>Bebidas y Vino</span>')
$content = $content.Replace('<span>Paddleboard</span>', '<span>Paddle Surf</span>')
$content = $content.Replace('<span>Refreshments</span>', '<span>Refrescos</span>')

# Rinker card
$content = $content.Replace('<div class="yacht-badge">Value Pick</div>', '<div class="yacht-badge">Mejor Valor</div>')

# View Details overlays (all instances)
$content = $content.Replace('<i class="fas fa-expand"></i> View Details', '<i class="fas fa-expand"></i> Ver Detalles')

# Rinker specs
$content = $content.Replace('<i class="fas fa-anchor"></i> Puerto Banús Dock 5', '<i class="fas fa-anchor"></i> Puerto Banús Muelle 5')

# Rinker description (file uses raw &)
$content = $content.Replace(
    'Spacious cruiser with cabin. Welcome drink, stereo, fuel & VAT all included.',
    'Crucero espacioso con cabina. Bebida de bienvenida, equipo de sonido, combustible e IVA incluidos.'
)

# Full Prices toggle (all instances)
$content = $content.Replace('Full Prices', 'Ver Precios')

# Yacht pricing hour labels
$content = $content.Replace('<span>1 hour</span>', '<span>1 hora</span>')
$content = $content.Replace('<span>2 hours</span>', '<span>2 horas</span>')
$content = $content.Replace('<span>3 hours</span>', '<span>3 horas</span>')
$content = $content.Replace('<span>4 hours</span>', '<span>4 horas</span>')
$content = $content.Replace('<span>6 hours</span>', '<span>6 horas</span>')
$content = $content.Replace('<span>8 hours</span>', '<span>8 horas</span>')

# Book This Boat (all instances — yacht cards and modal)
$content = $content.Replace('Book This Boat', 'Reservar Este Barco')

# Cranchi specs
$content = $content.Replace('<i class="fas fa-bed"></i> Lower Cabin', '<i class="fas fa-bed"></i> Cabina Inferior')

# Cranchi description
$content = $content.Replace(
    'Elegant Italian open-concept design with lower cabin. Ideal for celebrations and VIP experiences.',
    'Elegante diseño italiano de concepto abierto con cabina inferior. Ideal para celebraciones y experiencias VIP.'
)

# Azimut badge
$content = $content.Replace('<div class="yacht-badge luxury">Flybridge Luxury</div>', '<div class="yacht-badge luxury">Lujo Flybridge</div>')

# Azimut description
$content = $content.Replace(
    'The ultimate luxury flybridge yacht. Two champagne bottles, wine, paddle surf, and full insurance included.',
    'El yate flybridge de máximo lujo. Dos botellas de champán, vino, paddle surf y seguro completo incluidos.'
)

# Catamaran badge
$content = $content.Replace('<div class="yacht-badge luxury">Catamaran</div>', '<div class="yacht-badge luxury">Catamarán</div>')

# Catamaran specs
$content = $content.Replace('<i class="fas fa-bed"></i> 4 cabins / 4 WC', '<i class="fas fa-bed"></i> 4 cabinas / 4 WC')

# Catamaran description (file uses raw &)
$content = $content.Replace(
    'Spacious catamaran with 7 m beam and twin Volvo engines. Includes towels, paddle surf, snorkel, rosé, beer, cava & soft drinks.',
    'Catamarán espacioso con 7 m de manga y motores Volvo gemelos. Incluye toallas, paddle surf, snorkel, rosado, cerveza, cava y refrescos.'
)

# Yacht section note
$content = $content.Replace(
    'All boats operated by <strong>Marbella Ocean Boats</strong> from Puerto Banús. Every charter includes professional captain, fuel, insurance, and refreshments.',
    'Todos los barcos operados por <strong>Marbella Ocean Boats</strong> desde Puerto Banús. Cada chárter incluye capitán profesional, combustible, seguro y refrescos.'
)

$content = $content.Replace(
    '>Contact us for custom packages.</a>',
    '>Contáctanos para paquetes personalizados.</a>'
)

# ============================================================
# SECTION 11: About Section
# ============================================================

$content = $content.Replace('<span class="section-tag">Our Story</span>', '<span class="section-tag">Nuestra Historia</span>')

$content = $content.Replace(
    'About <span class="gradient-text">Us</span>',
    'Sobre <span class="gradient-text">Nosotros</span>'
)

$content = $content.Replace(
    '<h3 class="about-subtitle">Family Business Since 1998</h3>',
    '<h3 class="about-subtitle">Empresa Familiar Desde 1998</h3>'
)

$content = $content.Replace(
    '<strong>Marbella JetSki</strong> (STIERS E HIJOS S.L.) has been the Costa del Sol''s trusted water sports centre since 1998. We offer jet ski rides, coastal excursions, yacht charters, water sports, and professional racing lessons.',
    '<strong>Marbella JetSki</strong> (STIERS E HIJOS S.L.) es el centro de deportes acuáticos de confianza de la Costa del Sol desde 1998. Ofrecemos paseos en moto de agua, excursiones costeras, chárter de yates, deportes acuáticos y clases profesionales de competición.'
)

$content = $content.Replace(
    'Our director, Daniel Stiers, is also a <strong>professional jet ski racing pilot</strong> — 4x Spanish National Champion, Andalusia Champion, and Copa del Rey medallist. He offers private racing lessons for customers looking for the ultimate experience.',
    'Nuestro director, Daniel Stiers, es también <strong>piloto profesional de competición de motos de agua</strong> — 4 veces Campeón de España, Campeón de Andalucía y medallista de la Copa del Rey. Ofrece clases privadas de competición para quienes buscan la experiencia definitiva.'
)

# Achievement: ISO certification text (file uses raw &)
$content = $content.Replace(
    '<span>Quality & Environmental Certified</span>',
    '<span>Certificado de Calidad y Medioambiente</span>'
)

# About quote
$content = $content.Replace(
    '"Every customer who rides with us should feel the same thrill I feel when I race. Safety, excitement, and unforgettable memories — that''s what we deliver."',
    '"Cada cliente que monta con nosotros debería sentir la misma emoción que yo siento cuando compito. Seguridad, emoción y recuerdos inolvidables — eso es lo que ofrecemos."'
)

# File uses raw & here
$content = $content.Replace(
    '— Daniel Stiers, Director & 4x Spanish Champion',
    '— Daniel Stiers, Director y 4 Veces Campeón de España'
)

# ============================================================
# SECTION 12: Videos Section
# ============================================================

$content = $content.Replace(
    'See Us in <span class="gradient-text">Action</span>',
    'Míranos en <span class="gradient-text">Acción</span>'
)

$content = $content.Replace(
    'Watch what a day on the water with Marbella JetSki looks like',
    'Descubre cómo es un día en el agua con Marbella JetSki'
)

$content = $content.Replace(
    '<i class="fas fa-play-circle"></i> Load More Videos <span class="load-more-count">(3 more)</span>',
    '<i class="fas fa-play-circle"></i> Cargar Más Vídeos <span class="load-more-count">(3 más)</span>'
)

# ============================================================
# SECTION 13: Gallery Section
# ============================================================

$content = $content.Replace('<span class="section-tag">Gallery</span>', '<span class="section-tag">Galería</span>')

$content = $content.Replace(
    'Photo <span class="gradient-text">Gallery</span>',
    '<span class="gradient-text">Galería</span> de Fotos'
)

$content = $content.Replace(
    'Experience the thrill of Costa del Sol''s best water sports adventures',
    'Vive la emoción de las mejores aventuras acuáticas de la Costa del Sol'
)

$content = $content.Replace(
    '<i class="fas fa-images"></i> Load More Photos <span class="load-more-count">(12 more)</span>',
    '<i class="fas fa-images"></i> Cargar Más Fotos <span class="load-more-count">(12 más)</span>'
)

$content = $content.Replace(
    'Follow us for more action shots and behind-the-scenes content!',
    '¡Síguenos para más fotos de acción y contenido detrás de cámaras!'
)

# ============================================================
# SECTION 14: Testimonials
# ============================================================

$content = $content.Replace(
    '<span class="section-tag badge-premium">Customer Reviews</span>',
    '<span class="section-tag badge-premium">Opiniones de Clientes</span>'
)

$content = $content.Replace(
    'What Our <span class="gradient-text">Guests</span> Say',
    'Lo Que Dicen Nuestros <span class="gradient-text">Clientes</span>'
)

$content = $content.Replace(
    '<span class="rating-text">4.9/5 based on 500+ reviews</span>',
    '<span class="rating-text">4.9/5 basado en más de 500 opiniones</span>'
)

$content = $content.Replace(
    '<i class="fas fa-pen"></i> Write a Review',
    '<i class="fas fa-pen"></i> Escribe una Opinión'
)

# Testimonial quotes
$content = $content.Replace(
    '"Absolutely incredible experience! The jet ski excursion to Puerto Banús was the highlight of our trip. The staff was professional and made us feel safe the entire time."',
    '"¡Experiencia absolutamente increíble! La excursión en moto de agua a Puerto Banús fue lo mejor de nuestro viaje. El personal fue profesional y nos hizo sentir seguros en todo momento."'
)

$content = $content.Replace(
    '"We booked the yacht for my wife''s birthday and it exceeded all expectations. The crew was fantastic, drinks were flowing, and the views were breathtaking!"',
    '"Reservamos el yate para el cumpleaños de mi mujer y superó todas las expectativas. La tripulación fue fantástica, las bebidas no paraban y ¡las vistas eran impresionantes!"'
)

$content = $content.Replace(
    '"The kids absolutely loved the banana boat! We''ve been coming back every summer for the past 5 years. A family tradition now!"',
    '"¡A los niños les encantó el banana boat! Llevamos volviendo cada verano desde hace 5 años. ¡Ya es una tradición familiar!"'
)

$content = $content.Replace(
    '"As someone who''s never been on a jet ski before, I was nervous. But Daniel and his team made me feel so comfortable. By the end, I didn''t want to get off! Amazing experience."',
    '"Como alguien que nunca había montado en moto de agua, estaba nervioso. Pero Daniel y su equipo me hicieron sentir muy cómodo. Al final, ¡no quería bajarme! Experiencia increíble."'
)

# ============================================================
# SECTION 15: Booking Section
# ============================================================

$content = $content.Replace('<span class="section-tag">Reserve Your Spot</span>', '<span class="section-tag">Reserva Tu Plaza</span>')

$content = $content.Replace(
    'Book Your <span class="gradient-text">Adventure</span>',
    'Reserva Tu <span class="gradient-text">Aventura</span>'
)

$content = $content.Replace(
    'Summer 2026 bookings now open! Secure your dates early.',
    '¡Reservas para verano 2026 ya abiertas! Asegura tus fechas con antelación.'
)

$content = $content.Replace('<strong>Fully Insured</strong>', '<strong>Totalmente Asegurado</strong>')
$content = $content.Replace('<span>Civil liability coverage</span>', '<span>Cobertura de responsabilidad civil</span>')
$content = $content.Replace('<strong>Free Cancellation</strong>', '<strong>Cancelación Gratuita</strong>')
$content = $content.Replace('<span>24h+ notice = full refund</span>', '<span>Aviso +24h = reembolso total</span>')
$content = $content.Replace('<strong>Weather Guarantee</strong>', '<strong>Garantía Meteorológica</strong>')
$content = $content.Replace('<span>Bad weather = free reschedule</span>', '<span>Mal tiempo = reprogramación gratis</span>')

$content = $content.Replace('<span>Book Online Now</span>', '<span>Reservar Online Ahora</span>')

$content = $content.Replace('<span>or contact us directly</span>', '<span>o contáctanos directamente</span>')

$content = $content.Replace(
    '<i class="fas fa-clock"></i> Open daily 11am – 8pm · Walk-ins welcome at Playa de las Dunas',
    '<i class="fas fa-clock"></i> Abierto todos los días de 11h a 20h · Sin cita previa en Playa de las Dunas'
)

# ============================================================
# SECTION 16: FAQ Section
# ============================================================

$content = $content.Replace('<span class="section-tag">Have Questions?</span>', '<span class="section-tag">¿Tienes Preguntas?</span>')

$content = $content.Replace(
    'Frequently Asked <span class="gradient-text">Questions</span>',
    'Preguntas <span class="gradient-text">Frecuentes</span>'
)

# FAQ Q1
$content = $content.Replace(
    'What age do you need to be to participate?',
    '¿Qué edad se necesita para participar?'
)
$content = $content.Replace(
    'To ride a jet ski, you need to be at least 18 years old, or 16 with signed parental consent. For family activities like pedal boats and banana boats, children can participate when accompanied by an adult.',
    'Para montar en moto de agua hay que tener al menos 18 años, o 16 con consentimiento paterno firmado. Para actividades familiares como hidropedales y banana boat, los niños pueden participar acompañados de un adulto.'
)

# FAQ Q2
$content = $content.Replace(
    'Do I need a licence to hire a jet ski?',
    '¿Necesito licencia para alquilar una moto de agua?'
)
$content = $content.Replace(
    'No licence is required! We provide a comprehensive safety briefing before every activity. Our jet skis are easy to operate, and our instructors will ensure you''re comfortable before heading out.',
    '¡No se necesita licencia! Ofrecemos un briefing de seguridad completo antes de cada actividad. Nuestras motos de agua son fáciles de manejar y nuestros instructores se asegurarán de que te sientas cómodo antes de salir.'
)

# FAQ Q3 (includes path fix from terms.html to ../terms.html)
$content = $content.Replace(
    'What happens if I need to cancel?',
    '¿Qué pasa si necesito cancelar?'
)
$content = $content.Replace(
    'Cancel 24+ hours in advance for a full refund or free reschedule. Less than 24 hours notice incurs a 50% charge. Weather-related cancellations are always 100% refunded. See our full <a href="terms.html#cancellation">cancellation policy</a>.',
    'Cancela con más de 24 horas de antelación para un reembolso total o reprogramación gratuita. Con menos de 24 horas se cobra el 50%. Las cancelaciones por mal tiempo siempre se reembolsan al 100%. Consulta nuestra <a href="../terms.html#cancellation">política de cancelación</a>.'
)

# FAQ Q4
$content = $content.Replace('Is insurance included?', '¿Está incluido el seguro?')
$content = $content.Replace(
    'Yes! All activities include Civil Liability Insurance. This covers third-party injuries and property damage during normal use. Please note that damage caused by negligence or failure to follow safety instructions may result in repair charges at market rates.',
    '¡Sí! Todas las actividades incluyen Seguro de Responsabilidad Civil. Cubre lesiones a terceros y daños materiales durante el uso normal. Los daños causados por negligencia o incumplimiento de las instrucciones de seguridad pueden resultar en cargos de reparación a precios de mercado.'
)

# FAQ Q5
$content = $content.Replace('What payment methods do you accept?', '¿Qué métodos de pago aceptáis?')
$content = $content.Replace(
    'We accept credit/debit cards (Visa, Mastercard), bank transfer, and cash on-site.',
    'Aceptamos tarjetas de crédito/débito (Visa, Mastercard), transferencia bancaria y efectivo en el lugar.'
)

# FAQ Q6
$content = $content.Replace('What happens in bad weather?', '¿Qué pasa con el mal tiempo?')
$content = $content.Replace(
    'Safety comes first. Our qualified staff monitor AEMET weather data before every session. If conditions are unsafe, we''ll reschedule you free of charge or issue a 100% refund — no questions asked. The decision is made by our team and is final.',
    'La seguridad es lo primero. Nuestro personal cualificado monitoriza los datos meteorológicos de AEMET antes de cada sesión. Si las condiciones no son seguras, te reprogramamos gratis o te devolvemos el 100%, sin preguntas. La decisión la toma nuestro equipo y es definitiva.'
)

# FAQ Q7
$content = $content.Replace('Are activities available year-round?', '¿Las actividades están disponibles todo el año?')
$content = $content.Replace(
    'Our main season runs from May to October, with peak availability during summer months. We may operate on good weather days during off-season — contact us to check availability!',
    'Nuestra temporada principal va de mayo a octubre, con máxima disponibilidad en verano. Podemos operar en días de buen tiempo fuera de temporada — ¡contáctanos para consultar disponibilidad!'
)

# FAQ Q8
$content = $content.Replace('What should I bring?', '¿Qué debo traer?')
$content = $content.Replace(
    'Just bring swimwear, sunscreen, a towel, and a valid ID (passport or national ID for jet ski riders). We provide all safety equipment including life jackets and helmets. We recommend water shoes and bringing a change of clothes. Leave your phone on shore — it''s not permitted in the water.',
    'Solo trae bañador, protector solar, toalla y un documento de identidad válido (pasaporte o DNI para pilotos de moto de agua). Proporcionamos todo el equipamiento de seguridad: chalecos salvavidas y cascos. Recomendamos escarpines y llevar ropa de cambio. Deja el móvil en tierra — no está permitido en el agua.'
)

# FAQ Q9
$content = $content.Replace('Do you take photos and videos?', '¿Hacéis fotos y vídeos?')
$content = $content.Replace(
    'Yes! Professional photos and videos of your experience are available with every activity. Our staff capture the action so you can focus on the fun. With your consent, we may also use images for promotional purposes.',
    '¡Sí! Fotos y vídeos profesionales de tu experiencia están disponibles en cada actividad. Nuestro equipo captura la acción para que tú disfrutes. Con tu consentimiento, también podemos usar las imágenes con fines promocionales.'
)

# FAQ Q10
$content = $content.Replace('How do I get there? Is there parking?', '¿Cómo llego? ¿Hay aparcamiento?')
$content = $content.Replace(
    'We''re located at Playa de las Dunas, Urbanización Pinomar, Marbella (exit at km 189.5 on the AP-7). Free street parking is available nearby. We''re directly on the beach — look for the Marbella JetSki flags!',
    'Estamos en Playa de las Dunas, Urbanización Pinomar, Marbella (salida km 189.5 de la AP-7). Aparcamiento gratuito en la calle disponible cerca. Estamos directamente en la playa — ¡busca las banderas de Marbella JetSki!'
)
$content = $content.Replace('>Get directions on Google Maps</a>', '>Cómo llegar en Google Maps</a>')

# FAQ Q11
$content = $content.Replace('Can I book for a group or party?', '¿Puedo reservar para un grupo o fiesta?')
$content = $content.Replace(
    'Absolutely! We cater for stag/hen parties, birthdays, corporate events, and large groups. Our group activities (banana boat, crazy sofa, donut ride) are priced per person (€20/pp), and we offer yacht charters for up to 12 guests. Contact us on',
    '¡Por supuesto! Organizamos despedidas de soltero/a, cumpleaños, eventos corporativos y grupos grandes. Nuestras actividades grupales (banana boat, crazy sofa, donut ride) tienen precio por persona (€20/pp) y ofrecemos yates para hasta 12 invitados. Contáctanos por'
)
$content = $content.Replace('for custom group packages.', 'para paquetes de grupo personalizados.')

# FAQ Q12
$content = $content.Replace('Do I need to book in advance?', '¿Es necesario reservar con antelación?')
$content = $content.Replace(
    'We strongly recommend booking in advance during peak season (June–September) as slots fill up fast. Walk-ins are welcome when availability allows. You can book online, via WhatsApp, by phone, or in person at our beach location.',
    'Recomendamos encarecidamente reservar con antelación en temporada alta (junio-septiembre) ya que las plazas se agotan rápido. Se aceptan visitas sin reserva cuando hay disponibilidad. Puedes reservar online, por WhatsApp, por teléfono o en persona en nuestra playa.'
)

# FAQ Q13
$content = $content.Replace('What safety measures do you have in place?', '¿Qué medidas de seguridad tenéis?')
$content = $content.Replace(
    'Safety is our top priority. Every participant receives a <strong>10-15 minute mandatory safety briefing</strong> covering handling, hand signals, navigation rules, and emergency procedures. We provide ISO 12402-5 life jackets and CE helmets, and our 2024-2025 Yamaha VX jet skis are GPS-tracked (OtoTrak) with automatic power cut-off. A <strong>professional support boat with a qualified skipper</strong> is always within 300m, equipped with a first aid kit. We also monitor real-time weather conditions via State Ports and AEMET before every session.',
    'La seguridad es nuestra máxima prioridad. Cada participante recibe un <strong>briefing de seguridad obligatorio de 10-15 minutos</strong> que cubre manejo, señales manuales, normas de navegación y procedimientos de emergencia. Proporcionamos chalecos salvavidas ISO 12402-5 y cascos CE, y nuestras motos Yamaha VX 2024-2025 están rastreadas por GPS (OtoTrak) con corte de potencia automático. Una <strong>embarcación de apoyo profesional con patrón cualificado</strong> está siempre a menos de 300 m, equipada con botiquín de primeros auxilios. También monitorizamos las condiciones meteorológicas en tiempo real mediante Puertos del Estado y AEMET antes de cada sesión.'
)

# FAQ Q14
$content = $content.Replace('What qualifications does your team hold?', '¿Qué titulaciones tiene vuestro equipo?')
$content = $content.Replace(
    'Our entire team holds <strong>maritime safety qualifications</strong>. Owner Daniel Stiers is a 4x Spanish National Champion (RFEM 2024). All craft undergo daily mechanical inspections and hold up-to-date ITB (technical boat inspection) certifications. We are ISO 9001 (quality) and ISO 14001 (environmental) certified by OCA Global, and full equipment checks are performed after every use.',
    'Todo nuestro equipo cuenta con <strong>titulaciones de seguridad marítima</strong>. El propietario Daniel Stiers es 4 veces Campeón de España (RFEM 2024). Todas las embarcaciones pasan inspecciones mecánicas diarias y tienen certificaciones ITB (inspección técnica de embarcaciones) actualizadas. Estamos certificados en ISO 9001 (calidad) e ISO 14001 (medioambiente) por OCA Global, y se realizan revisiones completas del equipamiento después de cada uso.'
)

# ============================================================
# SECTION 17: Contact Section
# ============================================================

$content = $content.Replace('<span class="section-tag">Get in Touch</span>', '<span class="section-tag">Contacta con Nosotros</span>')

$content = $content.Replace(
    'Contact <span class="gradient-text">Us</span>',
    '<span class="gradient-text">Contacto</span>'
)

$content = $content.Replace(
    'Ready to make your aquatic adventure a reality? Reach out to us through any of these channels!',
    '¿Listo para hacer realidad tu aventura acuática? ¡Contáctanos por cualquiera de estos canales!'
)

$content = $content.Replace('<strong>Phone</strong>', '<strong>Teléfono</strong>')
$content = $content.Replace('<span>Quick Response!</span>', '<span>¡Respuesta Rápida!</span>')
$content = $content.Replace('<strong>Hours</strong>', '<strong>Horario</strong>')
$content = $content.Replace('<span>Daily 11am - 8pm</span>', '<span>Todos los días 11h - 20h</span>')
$content = $content.Replace('<strong>Location</strong>', '<strong>Ubicación</strong>')
$content = $content.Replace('<h4>Follow Us</h4>', '<h4>Síguenos</h4>')

# ============================================================
# SECTION 18: Footer
# ============================================================

$content = $content.Replace(
    'Costa del Sol''s premier water sports destination. Family-owned since 1998, led by 4x Spanish National Champion Daniel Stiers.',
    'El destino de deportes acuáticos líder de la Costa del Sol. Empresa familiar desde 1998, dirigida por el 4 veces Campeón de España Daniel Stiers.'
)

$content = $content.Replace('<h4>Quick Links</h4>', '<h4>Enlaces Rápidos</h4>')

# Footer quick links (use specific patterns to avoid conflicts)
$content = $content.Replace('>Jet Ski Hire</a>', '>Alquiler Motos de Agua</a>')
# ">Water Sports</a>" is safe — only remaining after nav already changed ">Water Sports</a>" to ">Deportes</a>"
# Actually, nav has class="nav-link" and footer doesn't have that class, but the text is the same.
# CAREFUL: ">Water Sports</a>" was already replaced to ">Deportes</a>" in nav section.
# Let me check: footer has <a href="#watersports">Water Sports</a>, and nav has <a href="#watersports" class="nav-link">Water Sports</a>
# Since nav replacement was ">Water Sports</a>" → ">Deportes</a>", it would match BOTH.
# But for the footer we want ">Deportes Acuáticos</a>".
# The nav was already handled by ">Water Sports</a>" → ">Deportes</a>" which catches all ">Water Sports</a>" instances.
# So the footer's "Water Sports" link is ALREADY changed to "Deportes" by the nav replacement.
# We need to fix this. Let's replace the footer one specifically:
# Actually, let me reconsider. The nav replacement ">Water Sports</a>" would catch both nav and footer.
# Since the footer should be "Deportes Acuáticos", not "Deportes", I need to handle this differently.
# Let me use a more specific pattern for the footer after the nav already changed it:
$content = $content.Replace(
    'href="#watersports">Deportes</a>',
    'href="#watersports">Deportes Acuáticos</a>'
)

$content = $content.Replace('>Yacht Charters</a>', '>Chárter de Yates</a>')
$content = $content.Replace('>About Us</a>', '>Sobre Nosotros</a>')
# File uses raw &
$content = $content.Replace('>Lessons & Training</a>', '>Clases y Formación</a>')

$content = $content.Replace('<h4>Information</h4>', '<h4>Información</h4>')

$content = $content.Replace('>Book Online</a>', '>Reservar Online</a>')
$content = $content.Replace('>Legal Notice</a>', '>Aviso Legal</a>')
# File uses raw &
$content = $content.Replace('>Terms & Conditions</a>', '>Términos y Condiciones</a>')
$content = $content.Replace('>Privacy Policy</a>', '>Política de Privacidad</a>')
$content = $content.Replace('>Cancellation Policy</a>', '>Política de Cancelación</a>')
$content = $content.Replace('>Weather Policy</a>', '>Política Meteorológica</a>')
$content = $content.Replace('>Cookie Policy</a>', '>Política de Cookies</a>')

$content = $content.Replace('<h4>Contact Us</h4>', '<h4>Contacto</h4>')
$content = $content.Replace('<span>Daily: 11am - 8pm</span>', '<span>Todos los días: 11h - 20h</span>')

$content = $content.Replace(
    'Designed with 💙 for Summer 2026',
    'Diseñado con 💙 para el Verano 2026'
)

$content = $content.Replace('Open in Google Maps', 'Abrir en Google Maps')

# ============================================================
# SECTION 19: Floating WhatsApp & Back to Top
# ============================================================

$content = $content.Replace(
    '<span class="whatsapp-tooltip">Chat with us!</span>',
    '<span class="whatsapp-tooltip">¡Escríbenos!</span>'
)

# ============================================================
# SECTION 20: Fix remaining path references
# ============================================================

$content = $content.Replace(
    'href="about-daniel.html#racing-videos"',
    'href="../about-daniel.html#racing-videos"'
)

$content = $content.Replace(
    'href="styles.css?v=2026021101"',
    'href="../styles.css?v=2026021101"'
)

$content = $content.Replace(
    'src="script.js?v=2026020924"',
    'src="../script.js?v=2026020924"'
)

# ============================================================
# SECTION 21: WhatsApp message text translations
# ============================================================

# Water sports experience (hero + booking section)
$content = $content.Replace(
    'text=Hi!%20I%27d%20like%20to%20book%20a%20water%20sports%20experience!',
    'text=Hola!%20Me%20gustar%C3%ADa%20reservar%20una%20experiencia%20de%20deportes%20acu%C3%A1ticos'
)

# Rinker 296
$content = $content.Replace(
    'text=Hi!%20I%27d%20like%20to%20book%20the%20Rinker%20296',
    'text=Hola!%20Me%20gustar%C3%ADa%20reservar%20el%20Rinker%20296'
)

# Cranchi 39
$content = $content.Replace(
    'text=Hi!%20I%27d%20like%20to%20book%20the%20Cranchi%2039',
    'text=Hola!%20Me%20gustar%C3%ADa%20reservar%20el%20Cranchi%2039'
)

# Azimut 39 Fly
$content = $content.Replace(
    'text=Hi!%20I%27d%20like%20to%20book%20the%20Azimut%2039%20Fly',
    'text=Hola!%20Me%20gustar%C3%ADa%20reservar%20el%20Azimut%2039%20Fly'
)

# Catamaran Bali 4.0
$content = $content.Replace(
    'text=Hi!%20I%27d%20like%20to%20book%20the%20Catamaran%20Bali%204.0',
    'text=Hola!%20Me%20gustar%C3%ADa%20reservar%20el%20Catamar%C3%A1n%20Bali%204.0'
)

# Yacht charters info
$content = $content.Replace(
    'text=Hi!%20I%27d%20like%20information%20about%20yacht%20charters',
    'text=Hola!%20Me%20gustar%C3%ADa%20informaci%C3%B3n%20sobre%20ch%C3%A1rter%20de%20yates'
)

# Floating WhatsApp button (uses I'm not I%27d)
$content = $content.Replace(
    'text=Hi!%20I''m%20interested%20in%20booking%20a%20water%20sports%20experience%20in%20Marbella.%20Can%20you%20help%20me?',
    'text=Hola!%20Estoy%20interesado%20en%20reservar%20una%20experiencia%20de%20deportes%20acu%C3%A1ticos%20en%20Marbella.%20%C2%BFPuedes%20ayudarme%3F'
)

# Group booking WhatsApp (uses I'd not I%27d)
$content = $content.Replace(
    'text=Hi!%20I''d%20like%20to%20enquire%20about%20a%20group%20booking.',
    'text=Hola!%20Me%20gustar%C3%ADa%20consultar%20sobre%20una%20reserva%20de%20grupo.'
)

# ============================================================
# SECTION 22: Boat modal text
# ============================================================

$content = $content.Replace(
    '<i class="fas fa-check-circle"></i> What''s Included',
    '<i class="fas fa-check-circle"></i> Qué Incluye'
)

$content = $content.Replace(
    '<i class="fas fa-tag"></i> Charter Rates',
    '<i class="fas fa-tag"></i> Tarifas de Chárter'
)

# ============================================================
# SECTION 23: Final catch-all — Promo button "Book Now"
# (All other "Book Now" patterns already replaced above)
# ============================================================

# Footer link: ">Book Now</a>"
$content = $content.Replace('>Book Now</a>', '>Reservar</a>')

# Hero promo button: the only remaining bare "Book Now" text
$content = $content.Replace('Book Now', 'Reservar')

# ============================================================
# WRITE THE FILE
# ============================================================

Set-Content -Path $file -Value $content -NoNewline -Encoding UTF8

Write-Host "Translation complete"
