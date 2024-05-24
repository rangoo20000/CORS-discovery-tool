#!/bin/bash
# Display logo
cat logo.txt
# Function to check CORS for a single URL
check_cors_for_url() {
    local url=$1

    # Extract domain from URL
    domain=$(echo $url | awk -F/ '{print $3}')

    # Send curl request and check response with gf cors
    response=$(curl -s -I -X GET -H "Origin: $domain" $url)

    # Check if Set-Cookie header exists in response
    set_cookie=$(echo "$response" | grep -i "set-cookie")

    if [[ -n "$set_cookie" ]]; then
        # Extract cookie value from Set-Cookie header
        cookie_value=$(echo "$set_cookie" | sed -n 's/.*Set-Cookie:\s*\(.*\)/\1/p')
        
        # Resend curl request with the obtained cookie value
        response=$(curl -s -I -X GET -H "Origin: $domain" -H "Cookie: $cookie_value" $url)
    else
        # Resend curl request without cookie
        response=$(curl -s -I -X GET -H "Origin: $domain" $url)
    fi
    
    # Check response with gf cors
    cors_check=$(echo "$response" | gf cors)

    if [[ -n "$cors_check" ]]; then
        echo "$url is CORS enabled."
    else
        echo "$url is not CORS enabled."
    fi
}

# Check CORS for a single URL provided by user
read -p "Please enter the URL you want to check: " url_to_check

check_cors_for_url "$url_to_check"
