#!/bin/bash
set -e

# Create the primary navigation menu
wp menu create "Primary Navigation" --allow-root

# Add pages to menu
wp menu item add-custom "Primary Navigation" "Home" "http://localhost:8080/" --allow-root
wp menu item add-custom "Primary Navigation" "Services" "http://localhost:8080/#services" --allow-root
wp menu item add-custom "Primary Navigation" "Jet Ski" "http://localhost:8080/#jetski" --allow-root
wp menu item add-custom "Primary Navigation" "Yachts" "http://localhost:8080/#boats" --allow-root
wp menu item add-custom "Primary Navigation" "Water Sports" "http://localhost:8080/#watersports" --allow-root
wp menu item add-custom "Primary Navigation" "Racing" "http://localhost:8080/#racing-lessons" --allow-root
wp menu item add-post "Primary Navigation" 6 --title="Lessons" --allow-root
wp menu item add-post "Primary Navigation" 7 --title="About Us" --allow-root
wp menu item add-post "Primary Navigation" 5 --title="Booking" --allow-root
wp menu item add-custom "Primary Navigation" "Contact" "http://localhost:8080/#contact" --allow-root

# Assign menu to primary location
wp menu location assign "Primary Navigation" primary --allow-root

echo "Menu created and assigned!"
