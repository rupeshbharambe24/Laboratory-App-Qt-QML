
# Laboratory Application

## Overview
This is a laboratory application built with **PyQt6** and **QtQuick/QML** for a responsive, interactive GUI. The app provides device connection, data acquisition, processing, and reporting functionalities. It supports **dynamic theming** (light/dark) and **high-DPI scaling** for modern displays.



## Features
- Connect to a laboratory device and display connection status.
- Start acquisition, process data, and export reports.
- Live data visualization in a simple line graph.
- Dynamic **light/dark theme toggle**.
- High-DPI display support for crisp UI on 4K or retina screens.
- Toast notifications for user actions.

---

## Installation

1. **Clone the repository**:
```bash
git clone <repository-url>
cd <repository-folder>
````

2. **Install dependencies** (Python 3.10+ recommended):

```bash
pip install PyQt6 PyQt6-Charts
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

## Demo Video

A **1–2 minute demo** should showcase:

1. App startup and DPI scaling.
2. Connecting the device (status changes from *Disconnected → Ready*).
3. Triggering actions: Start Acquisition, Process Data, Export Report (toast messages appear).
4. Switching themes between **light** and **dark**.
5. Live graph updates and responsive layout.

> Tip: Use OBS Studio or built-in OS recording tools for recording.

---

## License

This project is open-source and available under the MIT License.

```

---

If you want, I can also **enhance this README** by adding a **diagram showing the UI layout and backend signal-slot connections**, which will make it much clearer for someone browsing your GitHub repo.  

Do you want me to do that?
```
Here’s the **complete `README.md`** ready to be used in your GitHub repository:

````markdown
# Laboratory Application

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

---

## Installation

1. **Clone the repository**:
```bash
git clone <repository-url>
cd <repository-folder>
````

2. **Install dependencies** (Python 3.10+ recommended):

```bash
pip install PyQt6 PyQt6-Charts
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



Do you want me to do that?
```
