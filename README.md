# Favourite Places App

Flutter-приложение для сохранения мест с фото и геолокацией (Google Maps).

---

## 🚀 Функции

- Добавление нового места:
  - Фото через камеру
  - Геолокация: текущая или выбор на карте
  - Автоматическое определение адреса через Geocoding API
- Список сохранённых мест
- Экран деталей:
  - Большая картинка
  - Статическое превью карты и интерактивный экран с Google Map
- Хранение в локальной SQLite базе (sqflite)

---

## 🛠 Технологии и инструменты

- **Google Maps API**  
  - Интерактивные карты через пакет `google_maps_flutter`  
  - Geocoding API для обратного геокодинга (адрес по координатам)  
- **Firebase**  
  - Cloud Firestore (хранение и синхронизация списка мест)  
  - Firebase Authentication (авторизация пользователей)  
  - Firebase Storage (загрузка и хранение фотографий)  
- **SQLite (sqflite)** — локальная база данных для офлайн-режима  
- **State Management**: `flutter_riverpod`  
- **Location**: пакет `location` для получения текущей геопозиции  
- **HTTP**: пакет `http` для работы с Geocoding API  
- **File I/O**: `path_provider` + `path` для сохранения фото  
- **UUID**: пакет `uuid` для генерации уникальных ID  
- **Google Fonts**: пакет `google_fonts` для кастомных шрифтов  

---

## 📦 Зависимости

- flutter_riverpod
- google_maps_flutter
- location
- http
- sqflite
- path_provider, path
- uuid
- google_fonts

---

## ⚙ Установка и запуск

1. Клонировать:
   ```bash
   git clone https://github.com/USERNAME/favourite_places_app.git
   cd favourite_places_app

2. Добавить Google Maps API-ключи:
   Android: android/app/src/main/AndroidManifest.xml
   iOS: ios/Runner/Info.plist

3. Установить пакеты:
   flutter pub get


4. Запустить:
   flutter run


5. (Опционально) Запустить тесты:
   flutter test
