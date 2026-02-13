#!/bin/bash
# Setup WordPress with Marbella JetSki theme
set -e

wp theme activate marbellajetski --allow-root
wp rewrite structure '/%postname%/' --allow-root

# Create pages
wp post create --post_type=page --post_title='Home' --post_name=home --post_status=publish --allow-root
wp post create --post_type=page --post_title='Booking' --post_name=booking --post_status=publish --page_template=page-templates/template-booking.php --allow-root
wp post create --post_type=page --post_title='Lessons' --post_name=lessons --post_status=publish --page_template=page-templates/template-lessons.php --allow-root
wp post create --post_type=page --post_title='About Us' --post_name=about-us --post_status=publish --page_template=page-templates/template-about.php --allow-root
wp post create --post_type=page --post_title='Terms & Conditions' --post_name=terms --post_status=publish --page_template=page-templates/template-terms.php --allow-root
wp post create --post_type=page --post_title='Weather Policy' --post_name=weather-policy --post_status=publish --page_template=page-templates/template-weather.php --allow-root

# Set Home as static front page
HOME_ID=$(wp post list --post_type=page --name=home --field=ID --allow-root)
wp option update show_on_front page --allow-root
wp option update page_on_front "$HOME_ID" --allow-root

echo "Done! Visit http://localhost:8080"
