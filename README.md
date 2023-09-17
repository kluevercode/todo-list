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

## Screens
### Login
<img src="https://github.com/kluevercode/todo-list/assets/145115278/78d32a5f-a7e3-4af0-9338-783ce6250308" width="400">

### Tasklist
<img src="https://github.com/kluevercode/todo-list/assets/145115278/883cdd2b-b110-4526-8923-ea426e373f2f" width="400">

### Add Task
<img src="https://github.com/kluevercode/todo-list/assets/145115278/44562b6c-78a6-4f11-b043-3a829a5ae1e9" width="400">

### Edit Task
<img src="https://github.com/kluevercode/todo-list/assets/145115278/ae290e59-62f1-49b6-8b4e-82880f722260" width="400">

## Remarks
- Since the Backend is really small, it arguably didn't make sense to add Automapper or FluentValidation
- The Authorization is done in a Middleware
- In Flutter the production code lives in the lib folder
