#!/bin/bash

rm -f merged.txt raw.txt clean.txt whitelist.txt final.txt

# ===== list =====
urls=(
# == blocklists used by dnsforge.de ==
"https://dnsforge.de/blocklist.list"
"https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts"
"https://gitlab.com/quidsup/notrack-blocklists/raw/master/notrack-blocklist.txt"
"https://gitlab.com/quidsup/notrack-blocklists/raw/master/notrack-malware.txt"
"https://raw.githubusercontent.com/crazy-max/WindowsSpyBlocker/master/data/hosts/spy.txt"
"https://big.oisd.nl/"
"https://blocklistproject.github.io/Lists/basic.txt"
"https://blocklistproject.github.io/Lists/phishing.txt"
"https://blocklistproject.github.io/Lists/ransomware.txt"
"https://blocklistproject.github.io/Lists/tracking.txt"
"https://hole.cert.pl/domains/v2/domains.txt"
"https://o0.pages.dev/Lite/adblock.txt"
"https://perflyst.github.io/PiHoleBlocklist/AmazonFireTV.txt"
"https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/pro.txt"
"https://raw.githubusercontent.com/hagezi/dns-blocklists/main/domains/native.amazon.txt"
"https://raw.githubusercontent.com/hagezi/dns-blocklists/main/domains/native.apple.txt"
"https://raw.githubusercontent.com/hagezi/dns-blocklists/main/domains/native.huawei.txt"
"https://raw.githubusercontent.com/hagezi/dns-blocklists/main/domains/native.winoffice.txt"
"https://raw.githubusercontent.com/hagezi/dns-blocklists/main/domains/native.tiktok.txt"
"https://raw.githubusercontent.com/hagezi/dns-blocklists/main/domains/native.lgwebos.txt"
"https://raw.githubusercontent.com/hagezi/dns-blocklists/main/domains/native.xiaomi.txt"
"https://raw.githubusercontent.com/hagezi/dns-blocklists/main/domains/native.oppo-realme.txt"
"https://raw.githubusercontent.com/hagezi/dns-blocklists/main/domains/native.vivo.txt"
"https://raw.githubusercontent.com/AssoEchap/stalkerware-indicators/master/generated/quad9_blocklist.txt"
"https://adguardteam.github.io/HostlistsRegistry/assets/filter_50.txt"
"https://phishing.army/download/phishing_army_blocklist.txt"
"https://raw.githubusercontent.com/d3ward/toolz/master/src/d3host.txt"
"https://malware-filter.gitlab.io/malware-filter/phishing-filter-agh.txt"
# ===== gambling domain =====
"https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/gambling.txt"
)

for url in "${urls[@]}"; do
  curl -sL "$url" >> raw.txt
done

# ===== extract domain =====
grep -Eo '([a-zA-Z0-9-]+\.)+[a-zA-Z]{2,}' raw.txt > clean.txt

# ===== Del junk =====
grep -vE 'localhost|localdomain|broadcasthost' clean.txt > tmp.txt

# ===== convert adblock =====
sed 's/^/||/' tmp.txt | sed 's/$/^/' > merged.txt

# ===== Del duplicate =====
sort -u merged.txt > merged_clean.txt

# ===== Make whitelist =====
cat <<EOF > whitelist.txt
@@||google.com^
@@||gstatic.com^
@@||cloudflare.com^
@@||cloudflare-dns.com^
@@||dnsforge.de^
EOF

# ===== Final =====
cat whitelist.txt merged_clean.txt > final.txt

# ===== Export =====
mv final.txt merged.txt

# ===== Clean =====
rm raw.txt clean.txt tmp.txt merged_clean.txt whitelist.txt
