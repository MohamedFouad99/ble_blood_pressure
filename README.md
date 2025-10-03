# 💉 BLE Blood Pressure App

A Flutter application that simulates connecting to and reading from a **Bluetooth Low Energy (BLE) blood pressure monitor**.  



---

## 📹 Demo

Watch the walkthrough on Loom:  
🔗 [Click here to watch the demo](https://www.loom.com/share/554e9ba93ee44ec195c766f2a5b5a504)

---

## 📦 Features

- 🔍 Scan for available devices (mocked scan results for testing)
- 🔗 Pair and connect to a selected device (simulated connection)
- 💊 Read blood pressure values (systolic / diastolic / pulse) using mock data
- 💾 Save the last reading locally and show it on the home screen
- 🎨 Modern UI with smooth animations for displaying readings
- 🧩 Clean architecture using **Cubit**, **get_it**, and repository pattern

---

## 🧰 Tech Stack

- **Flutter**
- **flutter_bloc (Cubit)** for state management
- **get_it** for dependency injection
- **flutter_screenutil** for responsive UI design
- **Mock BLE Service** to generate fake readings for testing without hardware

---

## 🛠 Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/MohamedFouad99/ble_blood_pressure.git
   cd ble_blood_pressure
