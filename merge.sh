#!/bin/bash

rm -f raw.txt merged_clean.txt final.txt whitelist.txt

# ===== list =====
urls=(
# =========== DNSFORGE
# ===  🟢 blocklist.list :: DNSFORGE
"https://dnsforge.de/blocklist.list"
# ===  🟢 hosts :: DNSFORGE
"https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts"
# ===  🟢 notrack-blocklist.txt :: DNSFORGE
"https://gitlab.com/quidsup/notrack-blocklists/raw/master/notrack-blocklist.txt"
# ===  🟢 notrack-malware.txt :: DNSFORGE
"https://gitlab.com/quidsup/notrack-blocklists/raw/master/notrack-malware.txt"
# ===  🟢 spy.txt :: DNSFORGE
"https://raw.githubusercontent.com/crazy-max/WindowsSpyBlocker/master/data/hosts/spy.txt"
# ===  🟢 oisd.nl :: DNSFORGE
"https://big.oisd.nl/"
# ===  🟢 basic.txt :: DNSFORGE
"https://blocklistproject.github.io/Lists/basic.txt"
# ===  🟢 phishing.txt :: DNSFORGE
"https://blocklistproject.github.io/Lists/phishing.txt"
# ===  🟢 ransomware.txt :: DNSFORGE
"https://blocklistproject.github.io/Lists/ransomware.txt"
# ===  🟢 tracking.txt :: DNSFORGE
"https://blocklistproject.github.io/Lists/tracking.txt"
# ===  🟢 domains.txt :: DNSFORGE
"https://hole.cert.pl/domains/v2/domains.txt"
# ===  🟢 adblock.txt :: DNSFORGE
"https://o0.pages.dev/Lite/adblock.txt"
# ===  🟢 AmazonFireTV.txt :: DNSFORGE
"https://perflyst.github.io/PiHoleBlocklist/AmazonFireTV.txt"
# ===  🟢 pro.txt :: DNSFORGE
"https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/pro.txt"
# ===  🟢 native.amazon.txt :: DNSFORGE
"https://raw.githubusercontent.com/hagezi/dns-blocklists/main/domains/native.amazon.txt"
# ===  🟢 native.apple.txt :: DNSFORGE
"https://raw.githubusercontent.com/hagezi/dns-blocklists/main/domains/native.apple.txt"
# ===  🟢 native.huawei.txt :: DNSFORGE
"https://raw.githubusercontent.com/hagezi/dns-blocklists/main/domains/native.huawei.txt"
# ===  🟢 native.winoffice.txt :: DNSFORGE
"https://raw.githubusercontent.com/hagezi/dns-blocklists/main/domains/native.winoffice.txt"
# ===  🟢 native.tiktok.txt :: DNSFORGE
"https://raw.githubusercontent.com/hagezi/dns-blocklists/main/domains/native.tiktok.txt"
# ===  🟢 native.lgwebos.txt :: DNSFORGE
"https://raw.githubusercontent.com/hagezi/dns-blocklists/main/domains/native.lgwebos.txt"
# ===  🟢 native.xiaomi.txt :: DNSFORGE
"https://raw.githubusercontent.com/hagezi/dns-blocklists/main/domains/native.xiaomi.txt"
# ===  🟢 native.oppo-realme.txt :: DNSFORGE
"https://raw.githubusercontent.com/hagezi/dns-blocklists/main/domains/native.oppo-realme.txt"
# ===  🟢 native.vivo.txt :: DNSFORGE
"https://raw.githubusercontent.com/hagezi/dns-blocklists/main/domains/native.vivo.txt"
# ===  🟢 quad9_blocklist.txt :: DNSFORGE
"https://raw.githubusercontent.com/AssoEchap/stalkerware-indicators/master/generated/quad9_blocklist.txt"
# ===  🟢 filter_50.txt :: DNSFORGE
"https://adguardteam.github.io/HostlistsRegistry/assets/filter_50.txt"
# ===  🟢 phishing_army_blocklist.txt :: DNSFORGE
"https://phishing.army/download/phishing_army_blocklist.txt"
# ===  🟢 d3host.txt :: DNSFORGE
"https://raw.githubusercontent.com/d3ward/toolz/master/src/d3host.txt"
# ===  🟢 phishing-filter-agh.txt :: DNSFORGE
"https://malware-filter.gitlab.io/malware-filter/phishing-filter-agh.txt"
# ===== gambling domain =====
# === X 🔴 gambling.txt :: DNSFORGE
#"https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/gambling.txt"
)

# ===== download =====
for url in "${urls[@]}"; do
  curl -sL "$url" >> raw.txt
  echo -e "\n" >> raw.txt
done

# ===== clean basic =====
grep -vE '^\s*$' raw.txt | \
grep -vE 'localhost|localdomain|broadcasthost' > cleaned.txt

# ===== remove duplicate =====
sort -u cleaned.txt > merged_clean.txt

# ===== whitelist =====
cat <<EOF > whitelist.txt
# ==== WHITELIST ====
# remove # to enable
# @@||google.com^
# @@||gstatic.com^
# @@||cloudflare.com^
@@||dnsforge.de^
EOF

# ===== final =====
cat whitelist.txt merged_clean.txt > final.txt

mv final.txt merged.txt

# ===== clean =====
rm raw.txt cleaned.txt merged_clean.txt whitelist.txt
