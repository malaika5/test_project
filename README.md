# Flutter Interview Test Task – GitHub Submission Instructions

## 1. Dependencies Used & Why

This project uses the following packages and plugins:

- **flutter_screenutil**: Used for responsive UI design to ensure the app looks good on different screen sizes.
- **flutter_riverpod**: Used for state management to handle application state efficiently.
- **intl**: Used for date and time formatting, essential for the calendar and schedule features.
- **percent_indicator**: Used for displaying circular and linear progress indicators, such as workout progress.
- **flutter_svg**: Used for rendering SVG icons and assets for high-quality graphics.
- **google_fonts**: Used to incorporate the "Mulish" font family for consistent and styled typography.
- **geolocator**: Used to retrieve the device's current location to fetch local weather data.
- **dio**: Used for making HTTP requests to the OpenWeatherMap API to get temperature data.

## 2. Project Structure

The project follows a clean and organized structure:

```
lib/
 ├── models/       # Contains data models (e.g., Workout)
 ├── pages/        # Contains the main screens of the app (Plan, Mood, Nutrition, Profile)
 ├── widgets/      # Contains reusable UI components (e.g., BottomNavbar, PlanWeekWidget) and utility functions
 ├── main.dart     # Entry point of the application
 └── main_page.dart # Main layout container
```

- **lib/models/**: Defines the data structures used in the app.
- **lib/pages/**: Houses the individual screens accessible via the bottom navigation.
- **lib/widgets/**: Stores modular widgets to promote code reuse and clean UI logic. Also contains helper functions like `weather_function.dart`.

## 3. App Screenshots

[Link to Screenshots](https://github.com/username/project-name/tree/main/screenshots)

_(Note: Replace the link above with the actual path to your screenshots folder)_

## 4. App Video

[Watch App Demo](https://drive.google.com/file/d/xxxx/view)

_(Note: Replace the link above with the actual link to your demo video)_

## 5. App APK

[Download APK](./releases/app-release.apk)
