# todo-list
## Tech stack
### Frontend 
Flutter, Dart, Dio, Riverpod
### Backend
ASP.NET Core, C#, Entity Framework Core, Sqlite
### Auth 
Firebase and Google OIDC Provider

## Architecture
### Backend
The backend implements a simplified version of the clean architecture pattern. The separation between business services and infrastructure services ensures high testability and maintainability.

### Frontend
The Frontend implements the MVVM pattern and utilizes Riverpod for state management.

## Installation
1. Install .NET 7
2. Install xcode
3. Install Flutter
4. Open the Backend Solution in VS Codem, install the C# Extension and create a launch Config and run the API
5. Open an iOS emulator
6. Navigate to the App projects directory and run flutter run

## Remarks
- Since the Backend is really small, it arguably didn't make sense to add Automapper or FluentValidation
- The Authorization is done in a Middleware
- In Flutter the production code lives in the lib folder
