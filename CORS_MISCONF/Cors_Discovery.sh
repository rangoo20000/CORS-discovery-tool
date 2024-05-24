#!/bin/bash
# Display logo
cat logo.txt
# Get cookie from user
read -p "Please enter the cookie value (leave empty for no cookie): " cookie_value

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

    # Check if cookie_value is provided by user
    if [ -n "$cookie_value" ]; then
        # Send curl request with cookie
        response=$(curl -s -I -X GET -H "Origin: $domain" -H "Cookie: $cookie_value" $url)
    else
        # Send curl request without cookie
        response=$(curl -s -I -X GET -H "Origin: $domain" $url)
    fi
    
    # Check response with gf cors
    cors_check=$(echo "$response" | gf cors)

    if [[ -n "$cors_check" ]]; then
        echo $url >> $result_file
    fi
done < $output_file

echo "Process completed. Results are stored in $result_file."

