# IP Address Service

A simple nginx-based service that returns the client's IP address and other request information in JSON format.

## Features

- Returns client IP address in JSON format
- Multiple endpoints for different use cases
- Lightweight and fast (nginx-based)
- Docker deployment ready
- Handles X-Forwarded-For headers for proxied requests

## Endpoints

### 1. Root Endpoint (`/`)
Returns client IP with additional information:
```json
{
  "ip": "192.168.1.100",
  "forwarded_for": "203.0.113.195, 70.41.3.18",
  "user_agent": "Mozilla/5.0...",
  "timestamp": "2024-01-15T10:30:00+00:00"
}
```

### 2. Simple IP Endpoint (`/ip`)
Returns only the client IP:
```json
{
  "ip": "192.168.1.100"
}
```

### 3. Plain Text Endpoint (`/plain`)
Returns IP as plain text:
```
192.168.1.100
```

### 4. Health Check (`/health`)
Returns service status:
```json
{
  "status": "ok"
}
```

### 5. Detailed Info Endpoint (`/info`)
Returns comprehensive request information:
```json
{
  "ip": "192.168.1.100",
  "forwarded_for": "203.0.113.195",
  "user_agent": "Mozilla/5.0...",
  "method": "GET",
  "uri": "/info",
  "protocol": "HTTP/1.1",
  "host": "example.com",
  "timestamp": "2024-01-15T10:30:00+00:00",
  "server_addr": "172.17.0.2",
  "server_port": "80"
}
```

## Quick Start

### Using Docker Compose

1. Clone this repository:
```bash
git clone <repository-url>
cd <repository-name>
```

2. Start the service:
```bash
docker-compose up -d
```

3. Test the service:
```bash
# Get your IP in JSON format
curl http://localhost:8080/

# Get just your IP
curl http://localhost:8080/ip

# Get your IP as plain text
curl http://localhost:8080/plain

# Get detailed information
curl http://localhost:8080/info
```

### Using Docker directly

```bash
docker run -d \
  --name ip-service \
  -p 8080:80 \
  -v $(pwd)/nginx/nginx.conf:/etc/nginx/nginx.conf:ro \
  -v $(pwd)/nginx/conf.d:/etc/nginx/conf.d:ro \
  nginx:alpine
```

### Using nginx directly

1. Copy the configuration files to your nginx configuration directory:
```bash
cp nginx/nginx.conf /etc/nginx/nginx.conf
cp nginx/conf.d/ip-service.conf /etc/nginx/conf.d/
```

2. Test the configuration:
```bash
nginx -t
```

3. Reload nginx:
```bash
nginx -s reload
```

## Configuration

The service listens on port 80 inside the container, which is mapped to port 8080 on the host by default. You can change this in the `docker-compose.yml` file.

### Behind a Reverse Proxy

If you're running this service behind a reverse proxy (like another nginx instance, Cloudflare, or AWS ALB), the service will automatically detect and display the `X-Forwarded-For` header, which contains the real client IP.

## Testing with curl

```bash
# Basic test
curl http://localhost:8080/

# With custom headers
curl -H "X-Forwarded-For: 1.2.3.4" http://localhost:8080/

# Pretty print JSON
curl http://localhost:8080/info | jq .

# Get only the IP value
curl -s http://localhost:8080/ip | jq -r .ip
```

## Production Considerations

1. **SSL/TLS**: In production, you should run this behind an SSL terminator or configure nginx with SSL certificates.

2. **Rate Limiting**: Consider adding rate limiting to prevent abuse:
```nginx
limit_req_zone $binary_remote_addr zone=iplimit:10m rate=10r/s;
limit_req zone=iplimit burst=20;
```

3. **Access Logs**: The current configuration logs all requests. In high-traffic scenarios, you might want to disable access logs or log to a centralized logging system.

4. **Security Headers**: Consider adding security headers like `X-Frame-Options`, `X-Content-Type-Options`, etc.

## License

MIT License