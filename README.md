
# Sophos Client Setup for Wi-Fi Authentication

This guide explains how to set up and manage the **Sophos Client Authentication Agent (CAA)** on Ubuntu/Linux systems.  
The client is required for Wi-Fi login via the Sophos user portal.

---

## 📦 Installation Steps

1. **Download the Sophos CAA client**  
   - Obtain the Linux CAA client package (`caa_x64.tar.gz`) from your institution/company portal.
   - Extract it to your home directory:
     ```bash
     tar -xvzf caa_x64.tar.gz -C ~/
     ```

2. **Create a Start/Stop Script**  
   Save the provided script as `wifi_lan.sh` in your home directory and make it executable:
   ```bash
   chmod +x ~/wifi_lan.sh


3. **Prepare the Configuration File** (first time setup or after password change)

   * Create the config directory:

     ```bash
     mkdir -p ~/.caa
     ```
   * Create the file `~/.caa/caa.conf` with this format:

     ```
     Copernicus host: 192.168.1.1
     Username: <YOUR_USERNAME>
     Password: <YOUR_PASSWORD>
     ```
   * **Important**:

     * On first run, the client will encrypt the password automatically and replace it with `Encrypted password: <HASH>`.
     * If your portal host uses a different port (e.g., `4443`), the client will still detect it automatically.

4. **Run the Client**

   * Start:

     ```bash
     ~/wifi_lan.sh start
     ```
   * Stop:

     ```bash
     ~/wifi_lan.sh stop
     ```

   ✅ On success, the log file will be written to:

   ```
   ~/caa_x64/bin/sophos.log
   ```

---

## 🔑 Updating Password (after change)

If you change your portal/Wi-Fi password, you must reset the config:

1. Stop the client if running:

   ```bash
   ~/wifi_lan.sh stop
   ```

2. Remove old config files:

   ```bash
   rm -rf ~/.caa
   ```

3. Recreate the config:

   ```bash
   mkdir -p ~/.caa
   nano ~/.caa/caa.conf
   ```

   Insert:

   ```
   Copernicus host: 192.168.1.1
   Username: <YOUR_USERNAME>
   Password: <NEW_PASSWORD>
   ```

4. Start the client again:

   ```bash
   ~/wifi_lan.sh start
   ```

The client will encrypt the new password after first successful login.

---

## 📑 Logs & Debugging

* Logs: `~/caa_x64/bin/sophos.log`
* To run in **foreground (debug mode)**:

  ```bash
  ./caa -v
  ```
* To stop daemon manually:

  ```bash
  ./caa -s
  ```

---

## ⚠️ Common Issues

* **Login denied** → Wrong username/password in `~/.caa/caa.conf`. Reset config as described above.
* **Certificate errors** → Ensure `ca-cert.pem` is linked properly in `~/.caa/`.
* **Not connecting** → Verify the portal URL (e.g., [https://192.168.1.1:4443](https://192.168.1.1:4443)) is accessible in your browser.

---

## ✅ Summary

* Use `wifi_lan.sh` for easy start/stop.
* Edit `~/.caa/caa.conf` whenever you change your password.
* Check `sophos.log` for errors.
* First run will auto-encrypt your password.

---
