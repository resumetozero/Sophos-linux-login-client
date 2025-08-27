# Sophos Wi-Fi Client Setup & Script Usage

This guide explains how to set up the Sophos CAA (Client Authentication Agent) on **Ubuntu/Linux** and manage it using the provided `wifi_lan.sh` script.

---

## 📥 1. Download the Sophos Client
1. Log in to your organization’s network portal or Sophos user portal.  
2. Download the **Sophos CAA (caa_x64)** package for Linux.  
   - Typically it comes as a compressed file like `caa_x64.tar.gz`.  
3. Extract it to your home directory:  
   ```bash
   tar -xvzf caa_x64.tar.gz -C ~/
   ```

After extraction, you should have a directory like:
```
~/caa_x64/bin/caa
```

---

## ⚙️ 2. Prepare the Script
1. Place the `wifi_lan.sh` script in your home directory (or any preferred location).  
2. Make it executable:
   ```bash
   chmod +x ~/wifi_lan.sh
   ```

---

## 🔑 3. Fix Certification Errors
Sometimes the client fails to connect due to **certificate verification errors**. There are two possible solutions:

### Option A: Bypass verification (quick fix)
Edit the script and add `--no-verify` when starting the client:
```bash
"$APP" -d --no-verify >> "$LOG_FILE" 2>&1 &
```

### Option B: Use system CA certificates (safer fix)
Export the CA bundle path before running the script:
```bash
export SSL_CERT_FILE=/etc/ssl/certs/ca-certificates.crt
```

---

## 📝 4. Script Usage
The script allows you to **start** and **stop** the Sophos client easily.

### Start the client
```bash
./wifi_lan.sh start
```
- Overwrites the log file (`sophos.log`) each time.  
- Adds a timestamp at the top of the log.  

### Stop the client
```bash
./wifi_lan.sh stop
```

---

## 📂 5. Log File
Logs are stored at:
```
~/caa_x64/bin/sophos.log
```

Example first line:
```
=== Sophos client started at 2025-08-27 05:40:12 ===
```

---

## 🚀 6. Troubleshooting
- **Script not executable**  
  → Run `chmod +x wifi_lan.sh`.  
- **Client not found**  
  → Verify `~/caa_x64/bin/caa` exists.  
- **Certificate errors**  
  → Use **Option A** (`--no-verify`) or **Option B** (set `SSL_CERT_FILE`).  
- **Wi-Fi not connecting**  
  → Ensure your Wi-Fi interface (e.g., `wlo1`) is enabled and drivers are loaded.  

---

✅ That’s it! Now you can control the Sophos Wi-Fi client easily with `wifi_lan.sh`.
