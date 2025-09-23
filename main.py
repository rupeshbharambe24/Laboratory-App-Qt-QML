#!/usr/bin/env python3
import os
import sys
from pathlib import Path
from PyQt6.QtCore import Qt
from PyQt6.QtCore import QObject, pyqtSignal, pyqtSlot, QUrl, Qt
from PyQt6.QtGui import QGuiApplication
from PyQt6.QtQml import QQmlApplicationEngine
from PyQt6.QtCharts import QChartView  # Import charts module

class Backend(QObject):
    """Minimal backend for frontend testing"""
    statusChanged = pyqtSignal(str)
    themeChanged = pyqtSignal(str)
    showToast = pyqtSignal(str)
    
    def __init__(self):
        super().__init__()
        self._status = "Disconnected"
        self._theme = "light"
    
    @pyqtSlot()
    def connect_device(self):
        self._status = "Ready"
        self.statusChanged.emit(self._status)
        self.showToast.emit("Device connected successfully")
    
    @pyqtSlot()
    def start_acquisition(self):
        self.showToast.emit("Start Acquisition executed")
    
    @pyqtSlot()
    def process_data(self):
        self.showToast.emit("Process Data executed")
    
    @pyqtSlot()
    def export_report(self):
        self.showToast.emit("Export Report executed")
    
    @pyqtSlot()
    def toggle_theme(self):
        self._theme = "dark" if self._theme == "light" else "light"
        self.themeChanged.emit(self._theme)
        self.showToast.emit(f"Switched to {self._theme} theme")

def main():
    # Enable high DPI scaling
    QGuiApplication.setHighDpiScaleFactorRoundingPolicy(
        Qt.HighDpiScaleFactorRoundingPolicy.PassThrough
    )
    
    app = QGuiApplication(sys.argv)
    app.setApplicationName("Laboratory App")
    app.setOrganizationName("LabCorp")
    
    # Create QML engine
    engine = QQmlApplicationEngine()
    
    # Register backend
    backend = Backend()
    engine.rootContext().setContextProperty("backend", backend)
    
    # Get the absolute path to the QML file
    current_dir = Path(__file__).parent
    qml_file = current_dir / "ui" / "Main.qml"
    
    # Load main QML file
    engine.load(QUrl.fromLocalFile(str(qml_file)))
    
    if not engine.rootObjects():
        print("Error: Failed to load QML file")
        sys.exit(-1)
    
    sys.exit(app.exec())

if __name__ == "__main__":
    main()