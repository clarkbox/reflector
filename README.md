# IP Service - Nginx Configuration

A simple nginx configuration that returns the client's IP address in JSON format.

## Installation

1. Copy `ip-service.conf` to your nginx configuration directory:
   ```bash
   sudo cp ip-service.conf /etc/nginx/sites-available/
   sudo ln -s /etc/nginx/sites-available/ip-service.conf /etc/nginx/sites-enabled/
   ```

2. Test the configuration:
   ```bash
   sudo nginx -t
   ```

3. Reload nginx:
   ```bash
   sudo nginx -s reload
   ```

## Endpoints

- `/` - Returns IP with metadata in JSON
- `/ip` - Returns only IP in JSON  
- `/plain` - Returns IP as plain text
- `/info` - Returns detailed request information
- `/health` - Health check endpoint

## Example Responses

**GET /**
```json
{
  "ip": "192.168.1.100",
  "forwarded_for": "203.0.113.195",
  "user_agent": "curl/7.68.0",
  "timestamp": "2024-01-15T10:30:00+00:00"
}
```

**GET /ip**
```json
{
  "ip": "192.168.1.100"
}
```

**GET /plain**
```
192.168.1.100
```

**GET /info**
```json
{
  "ip": "192.168.1.100",
  "forwarded_for": "203.0.113.195",
  "user_agent": "curl/7.68.0",
  "method": "GET",
  "uri": "/info",
  "protocol": "HTTP/1.1",
  "host": "example.com",
  "timestamp": "2024-01-15T10:30:00+00:00",
  "server_addr": "10.0.0.1",
  "server_port": "80"
}
```

## Usage Examples

```bash
# Get your IP
curl http://localhost/ip

# Get plain text IP
curl http://localhost/plain

# Get detailed info
curl http://localhost/info | jq .

# Extract just the IP value
curl -s http://localhost/ip | jq -r .ip
```

## Notes

- If behind a proxy, the service reads the `X-Forwarded-For` header
- Change the `listen` port in the config file if needed
- For SSL, add SSL directives to the server block