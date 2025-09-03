# Usage Examples

## Command Line

### Using curl
```bash
# Get your IP
curl http://localhost:8080/ip

# Get detailed information
curl http://localhost:8080/info

# Pretty print with jq
curl -s http://localhost:8080/info | jq .
```

### Using wget
```bash
wget -qO- http://localhost:8080/ip
```

## Python
```python
import requests

# Get IP address
response = requests.get('http://localhost:8080/ip')
data = response.json()
print(f"Your IP: {data['ip']}")

# Get detailed info
response = requests.get('http://localhost:8080/info')
info = response.json()
print(f"IP: {info['ip']}")
print(f"User Agent: {info['user_agent']}")
```

## JavaScript (Node.js)
```javascript
const axios = require('axios');

// Using axios
axios.get('http://localhost:8080/ip')
  .then(response => {
    console.log('Your IP:', response.data.ip);
  })
  .catch(error => {
    console.error('Error:', error);
  });

// Using fetch (Node.js 18+)
fetch('http://localhost:8080/ip')
  .then(response => response.json())
  .then(data => console.log('Your IP:', data.ip));
```

## JavaScript (Browser)
```javascript
// Get IP address
fetch('http://your-domain.com/ip')
  .then(response => response.json())
  .then(data => {
    console.log('Your IP:', data.ip);
    document.getElementById('ip-display').textContent = data.ip;
  });

// Get detailed info
async function getIPInfo() {
  try {
    const response = await fetch('http://your-domain.com/info');
    const info = await response.json();
    console.log('IP Info:', info);
  } catch (error) {
    console.error('Error:', error);
  }
}
```

## PHP
```php
<?php
// Get IP address
$response = file_get_contents('http://localhost:8080/ip');
$data = json_decode($response, true);
echo "Your IP: " . $data['ip'] . "\n";

// Using cURL
$ch = curl_init('http://localhost:8080/info');
curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
$response = curl_exec($ch);
curl_close($ch);

$info = json_decode($response, true);
print_r($info);
?>
```

## Go
```go
package main

import (
    "encoding/json"
    "fmt"
    "io/ioutil"
    "net/http"
)

type IPResponse struct {
    IP string `json:"ip"`
}

func main() {
    resp, err := http.Get("http://localhost:8080/ip")
    if err != nil {
        panic(err)
    }
    defer resp.Body.Close()

    body, err := ioutil.ReadAll(resp.Body)
    if err != nil {
        panic(err)
    }

    var ipResp IPResponse
    json.Unmarshal(body, &ipResp)
    fmt.Printf("Your IP: %s\n", ipResp.IP)
}
```

## Ruby
```ruby
require 'net/http'
require 'json'

# Get IP address
uri = URI('http://localhost:8080/ip')
response = Net::HTTP.get(uri)
data = JSON.parse(response)
puts "Your IP: #{data['ip']}"

# Get detailed info
uri = URI('http://localhost:8080/info')
response = Net::HTTP.get(uri)
info = JSON.parse(response)
puts "IP: #{info['ip']}"
puts "User Agent: #{info['user_agent']}"
```

## Java
```java
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import org.json.JSONObject;

public class IPClient {
    public static void main(String[] args) {
        try {
            URL url = new URL("http://localhost:8080/ip");
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("GET");

            BufferedReader reader = new BufferedReader(
                new InputStreamReader(conn.getInputStream())
            );
            String response = reader.readLine();
            reader.close();

            JSONObject json = new JSONObject(response);
            System.out.println("Your IP: " + json.getString("ip"));
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
```