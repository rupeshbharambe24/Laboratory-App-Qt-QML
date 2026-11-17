# Laboratory Application

> Desktop front-end prototype for a laboratory instrument: PyQt6 backend + QtQuick/QML UI with light/dark theming and high-DPI support.

![Python](https://img.shields.io/badge/Python-3.10%2B-3776AB?logo=python&logoColor=white)
![PyQt6](https://img.shields.io/badge/PyQt6-QML-41CD52?logo=qt&logoColor=white)
![Status](https://img.shields.io/badge/status-prototype-orange)
![License](https://img.shields.io/badge/license-MIT-green)

## Overview
This is a laboratory application built with **PyQt6** and **QtQuick/QML** for a responsive, interactive GUI. The app provides device connection, data acquisition, processing, and reporting functionalities. It supports **dynamic theming** (light/dark) and **high-DPI scaling** for modern displays.

---

## Features
- Connect to a laboratory device and display connection status.
- Start acquisition, process data, and export reports.
- Live data visualization in a simple line graph.
- Dynamic **light/dark theme toggle**.
- High-DPI display support for crisp UI on 4K or retina screens.
- Toast notifications for user actions.

> **Note:** the `Backend` class is a stub for UI testing: device connection, acquisition, processing and export only update status and show toasts; no real instrument I/O is implemented.

### Demo

A screen recording of the UI is in [`assets/demo.mp4`](assets/demo.mp4).

---

## Installation

1. **Clone the repository**:
```bash
git clone https://github.com/rupeshbharambe24/Laboratory-App-Qt-QML.git
cd Laboratory-App-Qt-QML
```

2. **Install dependencies** (Python 3.10+ recommended):

```bash
pip install -r requirements.txt
```

---

## Running the Application

Run the application using:

```bash
python main.py
```

**Usage:**

* Click **Connect** to simulate device connection.
* Use **Start Acquisition**, **Process Data**, and **Export Report** buttons to trigger actions.
* Toggle between **light** and **dark** themes using the theme button in the toolbar.

---

## UI Layout

### Toolbar (Top)

* Connect button
* Status indicator
* Theme toggle button

### Left Panel (Actions Panel)

* Buttons: Start Acquisition, Process Data, Export Report

### Right Panel (Live Info Panel)

* Live data canvas (line graph)
* Key information grid (sample rate, channels, duration)

### Toast Notifications

* Appear at the bottom of the window when actions are triggered.

---

## Backend Connections

The Python `Backend` class handles all business logic and emits **signals**:

| Signal               | Description                            |
| -------------------- | -------------------------------------- |
| `statusChanged(str)` | Updates toolbar status indicator       |
| `themeChanged(str)`  | Switches between light and dark themes |
| `showToast(str)`     | Triggers toast popup message           |

UI buttons call backend **slots**:

* `connect_device()`
* `start_acquisition()`
* `process_data()`
* `export_report()`
* `toggle_theme()`

**Connections in QML**:

```qml
Connections {
    target: backend
    function onStatusChanged(status) { toolbar.status = status }
    function onThemeChanged(theme) { currentTheme = theme === "dark" ? darkTheme : lightTheme }
    function onShowToast(message) { toast.show(message) }
}
```

---

## DPI Scaling and Theming

* **DPI Scaling**: Enabled in `main.py` using:

```python
QGuiApplication.setHighDpiScaleFactorRoundingPolicy(Qt.HighDpiScaleFactorRoundingPolicy.PassThrough)
```

This ensures UI elements scale correctly on high-resolution displays (e.g., 4K monitors, retina displays).

* **Theming**:

  * Two theme objects: `lightTheme` and `darkTheme`.
  * All UI elements reference `currentTheme` for colors, spacing, fonts, borders.
  * Dynamic switching is handled by `backend.toggle_theme()` and QML `onThemeChanged`.
  * Toast notifications and Canvas graphs adapt automatically to the current theme.

---

## Project Structure

```text
Laboratory-App-Qt-QML/
├── main.py            # PyQt6 entry point + Backend (signals/slots)
├── ui/
│   └── Main.qml       # QtQuick UI: toolbar, actions panel, live canvas, toast
├── assets/
│   └── demo.mp4       # screen recording of the app
├── requirements.txt
└── LICENSE
```

---

## License

Released under the [MIT License](LICENSE).
