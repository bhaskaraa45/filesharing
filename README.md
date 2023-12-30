# FileSharing Flutter App

FileSharing is a Flutter-based file-sharing application that allows users to share files through local networks offline. This app provides a seamless experience for both mobile devices, desktop and web browsers. Users can receive files on the web platform by simply opening a link generated by the sender.

## Features

- **Cross-Platform Compatibility:** FileSharing works on both mobile devices, desktop (using the Flutter app) and web browsers (via the website). You cannot share files through website but you can receive files.
- **Local Network File Sharing:** Users can share files with others on the same local network without the need for an internet connection.
- **Web-Based File Reception:** Receivers can easily obtain files through their web browsers by opening a link provided by the sender (e.g., http://host-ip:port/getFile).

## Tech Stack

- **Flutter:** The app is built using Flutter.
- **HTTP Requests:** The app utilizes HTTP requests for communication between devices.

## Usage

### Sending Files

1. Open the FileSharing app on your device.
2. Choose the file you want to share.
3. Click on the "Send" option.
4. Share the generated QR code or link(e.g., http://host-ip:port/getFile) with the recipient.

### Receiving Files

1. Scan the QR using our app or anyother scanner and the file will start downlaoding on your device(obviously offline) or you can simply open the provided link(on sender's screen) (e.g., http://host-ip:port/getFile) in your favourite web browser.
2. The file will be downloaded to your device in minutes depends on your local network connectivity and file size.

#### Permissions Needed
01. Storage (Photos and videos/ Music and audio)
02. Internet Access (connect with receiver/sender)
03. Camera Permission(for QR Scanner)

## Getting Started

### Run Locally

1. Clone the repository to your local machine.
   ```bash
   git clone https://github.com/bhaskaraa45/filesharing
2. Navigate to the Flutter project directory.   
   ```bash
   cd filesharing
   ```
3. Run the Flutter app locally on your device.
   ```bash
   flutter run
   ```


### Web Platform

Visit the FileSharing website at [filesharing-aa45.netlify.app](http://filesharing-aa45.netlify.app) using your web browser.

Happy File Sharing!
