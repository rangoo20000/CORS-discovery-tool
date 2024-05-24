#!/bin/bash
# Display logo
cat logo.txt
# Get domains from user
read -p "Please enter the domains (separated by spaces): " -a domains

# File to store gau links
output_file="gau-urls.txt"
> $output_file

# Extract links for each domain and save to file
for domain in "${domains[@]}"; do
    gau $domain >> $output_file
done

# File to store results
result_file="result.txt"
> $result_file

# Request each URL with curl and check for Access-Control-Allow-Origin header using gf cors
while read -r url; do
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
        echo $url >> $result_file
    fi
done < $output_file

echo "Process completed. Results are stored in $result_file."
