import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Window

ApplicationWindow {
    id: mainWindow
    width: 1200
    height: 800
    minimumWidth: 1000
    minimumHeight: 600
    title: "Laboratory Application"
    visible: true

    // Theme properties - defined inline to avoid import issues
    property var lightTheme: {
        "primary": "#2c3e50",
        "secondary": "#3498db", 
        "accent": "#e74c3c",
        "background": "#ecf0f1",
        "surface": "#ffffff",
        "text": "#2c3e50",
        "textSecondary": "#7f8c8d",
        "border": "#bdc3c7",
        "success": "#27ae60",
        "warning": "#f39c12",
        "error": "#e74c3c",
        "fontSizeSmall": 12,
        "fontSizeMedium": 14,
        "fontSizeLarge": 18,
        "fontSizeTitle": 24,
        "spacingSmall": 4,
        "spacingMedium": 8,
        "spacingLarge": 16,
        "spacingXLarge": 24,
        "borderRadius": 6,
        "borderWidth": 1
    }
    
    property var darkTheme: {
        "primary": "#34495e",
        "secondary": "#3498db",
        "accent": "#e74c3c", 
        "background": "#2c3e50",
        "surface": "#34495e",
        "text": "#ecf0f1",
        "textSecondary": "#bdc3c7",
        "border": "#566573",
        "success": "#27ae60",
        "warning": "#f39c12",
        "error": "#e74c3c",
        "fontSizeSmall": 12,
        "fontSizeMedium": 14,
        "fontSizeLarge": 18,
        "fontSizeTitle": 24,
        "spacingSmall": 4,
        "spacingMedium": 8,
        "spacingLarge": 16,
        "spacingXLarge": 24,
        "borderRadius": 6,
        "borderWidth": 1
    }
    
    property var currentTheme: lightTheme
    property string themeName: "light"

    // Toast component
    Popup {
        id: toast
        property string message: ""
        
        x: (parent.width - width) / 2
        y: parent.height - height - 50
        width: 300
        height: 60
        modal: false
        focus: false
        closePolicy: Popup.NoAutoClose
        
        background: Rectangle {
            color: currentTheme.surface
            border.color: currentTheme.border
            border.width: currentTheme.borderWidth
            radius: currentTheme.borderRadius
            opacity: 0.95
        }
        
        contentItem: Label {
            text: toast.message
            font.pixelSize: currentTheme.fontSizeMedium
            color: currentTheme.text
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
        
        onOpened: {
            timer.start()
        }
        
        Timer {
            id: timer
            interval: 3000
            onTriggered: toast.close()
        }
        
        function show(msg) {
            message = msg
            open()
        }
    }

    // Toolbar component
    Rectangle {
        id: toolbar
        width: parent.width
        height: 60
        color: currentTheme.surface
        
        property string status: "Disconnected"
        
        Row {
            anchors.fill: parent
            anchors.margins: currentTheme.spacingLarge
            spacing: currentTheme.spacingLarge
            
            // Connect Button
            Button {
                id: connectBtn
                text: "Connect"
                height: parent.height
                width: 120
                
                background: Rectangle {
                    color: parent.down ? Qt.darker(currentTheme.secondary, 1.2) : 
                           parent.hovered ? Qt.lighter(currentTheme.secondary, 1.1) : currentTheme.secondary
                    radius: currentTheme.borderRadius
                }
                
                contentItem: Text {
                    text: parent.text
                    font.pixelSize: currentTheme.fontSizeMedium
                    color: "white"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
                
                onClicked: {
                    backend.connect_device()
                }
            }
            
            // Status Indicator
            Rectangle {
                width: 12
                height: 12
                radius: 6
                color: toolbar.status === "Ready" ? currentTheme.success : currentTheme.error
                anchors.verticalCenter: parent.verticalCenter
            }
            
            Label {
                text: "Status: " + toolbar.status
                font.pixelSize: currentTheme.fontSizeMedium
                color: currentTheme.text
                anchors.verticalCenter: parent.verticalCenter
            }
            
            // Spacer
            Item { Layout.fillWidth: true; height: 1 }
            
            // Theme Toggle
            Button {
                id: themeBtn
                text: themeName === "light" ? "🌙 Dark" : "☀️ Light"
                height: parent.height
                width: 100
                
                background: Rectangle {
                    color: parent.down ? Qt.darker(currentTheme.primary, 1.2) : 
                           parent.hovered ? Qt.lighter(currentTheme.primary, 1.1) : currentTheme.primary
                    radius: currentTheme.borderRadius
                }
                
                contentItem: Text {
                    text: parent.text
                    font.pixelSize: currentTheme.fontSizeMedium
                    color: "white"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
                
                onClicked: {
                    backend.toggle_theme()
                }
            }
        }
        
        // Bottom border
        Rectangle {
            width: parent.width
            height: 1
            color: currentTheme.border
            anchors.bottom: parent.bottom
        }
    }

    // Main content area
    RowLayout {
        anchors.top: toolbar.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.margins: currentTheme.spacingLarge
        spacing: currentTheme.spacingLarge
        
        // Actions Panel (Left)
        Rectangle {
            id: actionPanel
            Layout.preferredWidth: 250
            Layout.fillHeight: true
            color: currentTheme.background
            border.color: currentTheme.border
            border.width: currentTheme.borderWidth
            radius: currentTheme.borderRadius
            
            ColumnLayout {
                anchors.fill: parent
                anchors.margins: currentTheme.spacingLarge
                spacing: currentTheme.spacingMedium
                
                Label {
                    text: "Actions"
                    font.pixelSize: currentTheme.fontSizeLarge
                    font.bold: true
                    color: currentTheme.text
                    Layout.alignment: Qt.AlignHCenter
                }
                
                // Start Acquisition Button
                Button {
                    id: startBtn
                    text: "Start Acquisition"
                    Layout.fillWidth: true
                    Layout.preferredHeight: 50
                    
                    background: Rectangle {
                        color: parent.down ? Qt.darker(currentTheme.success, 1.2) : 
                               parent.hovered ? Qt.lighter(currentTheme.success, 1.1) : currentTheme.success
                        radius: currentTheme.borderRadius
                    }
                    
                    contentItem: Text {
                        text: parent.text
                        font.pixelSize: currentTheme.fontSizeMedium
                        color: "white"
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                    
                    onClicked: {
                        backend.start_acquisition()
                    }
                }
                
                // Process Data Button
                Button {
                    id: processBtn
                    text: "Process Data"
                    Layout.fillWidth: true
                    Layout.preferredHeight: 50
                    
                    background: Rectangle {
                        color: parent.down ? Qt.darker(currentTheme.secondary, 1.2) : 
                               parent.hovered ? Qt.lighter(currentTheme.secondary, 1.1) : currentTheme.secondary
                        radius: currentTheme.borderRadius
                    }
                    
                    contentItem: Text {
                        text: parent.text
                        font.pixelSize: currentTheme.fontSizeMedium
                        color: "white"
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                    
                    onClicked: {
                        backend.process_data()
                    }
                }
                
                // Export Report Button
                Button {
                    id: exportBtn
                    text: "Export Report"
                    Layout.fillWidth: true
                    Layout.preferredHeight: 50
                    
                    background: Rectangle {
                        color: parent.down ? Qt.darker(currentTheme.accent, 1.2) : 
                               parent.hovered ? Qt.lighter(currentTheme.accent, 1.1) : currentTheme.accent
                        radius: currentTheme.borderRadius
                    }
                    
                    contentItem: Text {
                        text: parent.text
                        font.pixelSize: currentTheme.fontSizeMedium
                        color: "white"
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                    
                    onClicked: {
                        backend.export_report()
                    }
                }
                
                Item { Layout.fillHeight: true } // Spacer
            }
        }
        
        // Live Info Panel (Right)
        Rectangle {
            id: infoPanel
            Layout.fillWidth: true
            Layout.fillHeight: true
            color: currentTheme.surface
            border.color: currentTheme.border
            border.width: currentTheme.borderWidth
            radius: currentTheme.borderRadius
            
            ColumnLayout {
                anchors.fill: parent
                anchors.margins: currentTheme.spacingLarge
                spacing: currentTheme.spacingMedium
                
                Label {
                    text: "Live Information"
                    font.pixelSize: currentTheme.fontSizeLarge
                    font.bold: true
                    color: currentTheme.text
                    Layout.alignment: Qt.AlignHCenter
                }
                
                Rectangle {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    color: currentTheme.background
                    border.color: currentTheme.border
                    border.width: currentTheme.borderWidth
                    radius: currentTheme.borderRadius

                    Canvas {
                        id: graphCanvas
                        anchors.fill: parent

                        property var dataPoints: [10, 20, 15, 30, 25, 18, 35]

                        onPaint: {
                            var ctx = getContext("2d")
                            ctx.clearRect(0, 0, width, height)

                            // Draw axes
                            ctx.strokeStyle = currentTheme.textSecondary
                            ctx.lineWidth = 1
                            ctx.beginPath()
                            ctx.moveTo(40, 10)
                            ctx.lineTo(40, height - 30)
                            ctx.lineTo(width - 10, height - 30)
                            ctx.stroke()

                            // Draw line graph
                            ctx.strokeStyle = currentTheme.accent
                            ctx.lineWidth = 2
                            ctx.beginPath()

                            var xStep = (width - 50) / (dataPoints.length - 1)
                            for (var i = 0; i < dataPoints.length; i++) {
                                var x = 40 + i * xStep
                                var y = height - 30 - dataPoints[i]
                                if (i === 0)
                                    ctx.moveTo(x, y)
                                else
                                    ctx.lineTo(x, y)
                            }
                            ctx.stroke()

                            // Draw points
                            ctx.fillStyle = currentTheme.primary
                            for (var i = 0; i < dataPoints.length; i++) {
                                var x = 40 + i * xStep
                                var y = height - 30 - dataPoints[i]
                                ctx.beginPath()
                                ctx.arc(x, y, 4, 0, 2 * Math.PI)
                                ctx.fill()
                            }
                        }

                        Component.onCompleted: requestPaint()
                    }
                }

                
                // Placeholder for future content
                GridLayout {
                    Layout.fillWidth: true
                    columns: 2
                    rowSpacing: currentTheme.spacingSmall
                    columnSpacing: currentTheme.spacingMedium
                    
                    Label { text: "Sample Rate:"; color: currentTheme.textSecondary }
                    Label { text: "1000 Hz"; color: currentTheme.text }
                    
                    Label { text: "Channels:"; color: currentTheme.textSecondary }
                    Label { text: "8"; color: currentTheme.text }
                    
                    Label { text: "Duration:"; color: currentTheme.textSecondary }
                    Label { text: "Continuous"; color: currentTheme.text }
                }
            }
        }
    }

    // Backend connections
    Connections {
        target: backend
        
        function onStatusChanged(status) {
            toolbar.status = status
        }
        
        function onThemeChanged(theme) {
            if (theme === "dark") {
                currentTheme = darkTheme
                themeName = "dark"
            } else {
                currentTheme = lightTheme
                themeName = "light"
            }
        }
        
        function onShowToast(message) {
            toast.show(message)
        }
    }
}