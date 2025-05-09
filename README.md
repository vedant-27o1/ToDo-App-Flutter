# 📝 Flutter To-Do List App

A simple To-Do List app built with **Flutter**, emphasizing **clean architecture** and **modular logic structure** without relying on state management libraries or data persistence. The app does **not focus on UI/UX polish**, nor does it store data locally or remotely.

---

## 🎯 Project Goals

* Showcase **separation of concerns** using a layered architecture
* Implement core to-do functionality (add, delete, toggle)
* Use **vanilla Flutter** (no third-party state management)
* Keep business logic independent of UI code
* Provide a maintainable and extendable base for future enhancements

---

## 🏗️ Architecture Overview

The app uses a simple but clean **feature-first, layered architecture**:

```
lib/
├── core/              # Shared constants
├── features/
│   └── home/
│       ├── domain/    # Entity models
│       ├── presentation/ # UI widgets and screen layout
├── main.dart
```

### Layer Descriptions

* **Domain**: Contains the `Todo` entity and abstract definitions (e.g., `TodoRepository`).
* **Application**: Business logic like adding/removing/toggling todos, separated into service classes or use cases.
* **Presentation**: Flutter widgets and screen layout using `StatefulWidget` and `setState`.
* **Infrastructure**: Not implemented — meant for future data handling (e.g., API, DB, local storage).

---

## ⚙️ Features

* Add new tasks
* Delete tasks
* Mark tasks as completed
* Basic UI layout using `ListView`, `TextField`, and buttons
* Logic structured for future integration with persistence or state management

---

## ❌ What’s Not Included

* Fancy UI or animations
* Persistent storage (no SQLite, Hive, or Firebase)
* State management libraries (e.g., `Provider`, `Bloc`, `Riverpod`)
* Responsive design or themes

---


## 🔮 Future Plans

* Add `Hive` or `SharedPreferences` for local persistence
* Integrate `Provider` or `Riverpod` for scalable state handling
* Polish UI and add animations
* Add filters, due dates, and categorization

---

## 📄 License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

---