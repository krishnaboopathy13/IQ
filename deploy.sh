#!/bin/bash
# IQ Enterprise — VPS Deploy Script
# Usage: chmod +x deploy.sh && ./deploy.sh
# Tested on Ubuntu 22.04 / 24.04

set -e

DOMAIN=${1:-"your-domain.com"}
DEPLOY_DIR="/var/www/iq-enterprise"

echo ""
echo "╔══════════════════════════════════════╗"
echo "║   IQ Enterprise v2.0 — Deploy       ║"
echo "╚══════════════════════════════════════╝"
echo ""

# 1. Install Nginx if missing
if ! command -v nginx &> /dev/null; then
  echo "→ Installing Nginx..."
  sudo apt-get update -qq
  sudo apt-get install -y nginx
fi

# 2. Create deploy directory
echo "→ Creating deploy directory: $DEPLOY_DIR"
sudo mkdir -p "$DEPLOY_DIR"
sudo mkdir -p "$DEPLOY_DIR/icons"

# 3. Copy app files
echo "→ Copying app files..."
sudo cp index.html     "$DEPLOY_DIR/"
sudo cp manifest.json  "$DEPLOY_DIR/"
sudo cp sw.js          "$DEPLOY_DIR/"
sudo cp -r icons/      "$DEPLOY_DIR/"

# 4. Set permissions
sudo chown -R www-data:www-data "$DEPLOY_DIR"
sudo chmod -R 755 "$DEPLOY_DIR"

# 5. Copy and enable Nginx config
echo "→ Configuring Nginx for domain: $DOMAIN"
sudo cp nginx.conf /etc/nginx/sites-available/iq-enterprise
sudo sed -i "s/your-domain.com/$DOMAIN/g" /etc/nginx/sites-available/iq-enterprise
sudo ln -sf /etc/nginx/sites-available/iq-enterprise /etc/nginx/sites-enabled/iq-enterprise
sudo rm -f /etc/nginx/sites-enabled/default

# 6. Test and reload Nginx
echo "→ Testing Nginx config..."
sudo nginx -t
echo "→ Reloading Nginx..."
sudo systemctl reload nginx

# 7. Optional: Install Certbot for HTTPS
if command -v certbot &> /dev/null; then
  echo "→ Certbot found — obtaining SSL certificate for $DOMAIN..."
  sudo certbot --nginx -d "$DOMAIN" -d "www.$DOMAIN" --non-interactive --agree-tos -m "admin@$DOMAIN"
else
  echo "⚠  Certbot not found. For HTTPS (required for camera/PWA), run:"
  echo "   sudo apt install certbot python3-certbot-nginx"
  echo "   sudo certbot --nginx -d $DOMAIN"
fi

echo ""
echo "✅ IQ Enterprise deployed!"
echo "   URL: http://$DOMAIN  (or https:// after Certbot)"
echo "   Dir: $DEPLOY_DIR"
echo ""
