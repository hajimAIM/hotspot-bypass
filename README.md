# Ultimate Hotspot Bypass Tool (Stable)

A powerful Windows batch script designed to bypass mobile hotspot restrictions by modifying Time To Live (TTL) settings and managing IPv6 configurations.

---

## 🇬🇧 English

### Description
This tool helps you bypass hotspot limits imposed by mobile carriers. It modifies your Windows outgoing TTL (Time To Live) to mimic mobile device traffic (TTL 65) or standard PC traffic (TTL 129). It also includes an automatic scanner to find the best settings for your network and detects IPv6 leaks which can reveal your tethering usage.

### Features
- **Manual Bypass**: Quickly apply common TTL values:
  - **TTL 65**: Mimics Android/iOS device traffic (Best for most mobile-heavy plans).
  - **TTL 129**: Mimics standard Windows traffic (Useful for desktop-heavy plans).
- **Auto-Scanner**: Automatically scans TTL ranges (50-70 & 110-130) to find a working configuration.
- **IPv6 Protection**: Detects if IPv6 is enabled and helps you disable it to prevent data leaks.
- **Connectivity Verification**: Built-in 15MB download test to confirm the bypass is working.
- **One-Click Reset**: Easily restore default Windows settings (TTL 128) and re-enable IPv6.

### How to Use
1. Right-click `hotspot-bypass.cmd` and select **Run as Administrator** (or the script will ask for permissions).
2. Choose an option from the menu:
   - Press `2` or `3` to manually apply a bypass.
   - Press `5` so the tool automatically finds the best bypass for you.
3. If prompted about IPv6, it is **recommended to disable it** (Select `Y`).
4. Wait for the download test to show `[PASS]`.

### Disclaimer
This tool is for educational purposes and network testing only. Please respect your mobile carrier's terms of service. Use at your own risk.

---

## 🇲🇾 Bahasa Melayu

### Penerangan
Alat ini membantu anda memintas had hotspot yang dikenakan oleh syarikat telekomunikasi. Ia mengubah TTL (Time To Live) Windows anda untuk meniru trafik peranti mudah alih (TTL 65) atau trafik PC biasa (TTL 129). Ia juga dilengkapi dengan pengimbas automatik untuk mencari tetapan terbaik bagi rangkaian anda dan mengesan kebocoran IPv6 yang boleh mendedahkan penggunaan hotspot anda.

### Ciri-ciri
- **Pintas Manual**: Tetapkan nilai TTL biasa dengan pantas:
  - **TTL 65**: Meniru trafik peranti Android/iOS (Terbaik untuk kebanyakan pelan mudah alih).
  - **TTL 129**: Meniru trafik Windows biasa (Berguna untuk pelan desktop).
- **Pengimbas Automatik (Auto-Scanner)**: Mengimbas rentang TTL (50-70 & 110-130) secara automatik untuk mencari konfigurasi yang berfungsi.
- **Perlindungan IPv6**: Mengesan jika IPv6 diaktifkan dan membantu anda mematikannya untuk mengelakkan kebocoran data.
- **Pengesahan Sambungan**: Ujian muat turun 15MB terbina dalam untuk memastikan pintasan berfungsi.
- **Reset Satu Klik**: Kembalikan tetapan asal Windows (TTL 128) dan aktifkan semula IPv6 dengan mudah.

### Cara Penggunaan
1. Klik kanan pada `hotspot-bypass.cmd` dan pilih **Run as Administrator** (atau skrip akan meminta kebenaran).
2. Pilih satu pilihan dari menu:
   - Tekan `2` atau `3` untuk memintas secara manual.
   - Tekan `5` untuk membiarkan alat mencari pintasan terbaik secara automatik.
3. Jika ditanya mengenai IPv6, **disyorkan untuk mematikannya** (Pilih `Y`).
4. Tunggu sehingga ujian muat turun menunjukkan `[PASS]`.

### Penafian
Alat ini adalah untuk tujuan pendidikan dan ujian rangkaian sahaja. Sila patuhi terma perkhidmatan syarikat telekomunikasi anda. Gunakan atas risiko anda sendiri.

