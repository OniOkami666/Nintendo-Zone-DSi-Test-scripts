# Theoretical redirect.cgi used by Nintendo Zone DSi

#!/usr/bin/env python3
import sys
import os
from urllib.parse import parse_qs

query_str = os.environ.get('QUERY_STRING', '')
params = parse_qs(query_str)

target_url = params.get('url', [None])[0]

if target_url:
    print("Status: 302 Found")
    print(f"Location: {target_url}")
    print("\n")
else:
    print("Status: 302 Found")
    print("Location: /index.html")
    print("\n")