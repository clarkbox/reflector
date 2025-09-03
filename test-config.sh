#!/bin/bash

echo "Testing nginx configuration..."
echo "=============================="
echo ""

# Check if nginx is installed
if ! command -v nginx &> /dev/null; then
    echo "nginx is not installed. Please install nginx to test the configuration."
    echo "On Ubuntu/Debian: sudo apt-get install nginx"
    echo "On CentOS/RHEL: sudo yum install nginx"
    echo "On macOS: brew install nginx"
    exit 1
fi

# Test the configuration
echo "Testing nginx configuration syntax..."
nginx -t -c $(pwd)/nginx/nginx.conf

echo ""
echo "Configuration files created:"
echo "- nginx/nginx.conf"
echo "- nginx/conf.d/ip-service.conf"
echo "- docker-compose.yml"
echo "- README.md"
echo ""
echo "To deploy with Docker:"
echo "1. Make sure Docker and Docker Compose are installed"
echo "2. Run: docker-compose up -d"
echo "3. Access the service at http://localhost:8080/"
echo ""
echo "Available endpoints:"
echo "- / (JSON with IP and metadata)"
echo "- /ip (JSON with IP only)"
echo "- /plain (Plain text IP)"
echo "- /info (Detailed JSON info)"
echo "- /health (Health check)"