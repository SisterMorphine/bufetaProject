# 🐾 Bufeta

Bufeta is a Flutter app built for **testing and learning** purposes — a playground for exploring different approaches to **automatic testing in Flutter**.  

Currently, the app displays random cat images fetched from the public [TheCatAPI](https://api.thecatapi.com/), with a simple button to load new images. Over time, Bufeta will evolve as new testing strategies, UI components, and Flutter features are explored.

We are using Bloc library for App state management https://bloclibrary.dev/

---

## 📱 Preview

> <img alt="Fattycat" src="https://i.postimg.cc/C11x2JBs/Screenshot-1767174954.png" width="200" align="center">

---

## 🚀 Getting Started

### Prerequisites
Make sure you have the following installed:
- [Flutter SDK](https://flutter.dev/docs/get-started/install)
- A code editor such as [Visual Studio Code](https://code.visualstudio.com/) or Android Studio

### Installation
Clone the repository and run the app locally:

```bash
git clone https://github.com/YOUR_USERNAME/bufeta.git
cd bufeta
flutter pub get
flutter run
```


### Using an API key

We recommend keeping API keys out of source control and passing them at build/run time using `--dart-define-from-file`.

1. Create a JSON file at `./.secrets/thecatapi.json` (this repo already ignores `.secrets/`):

```json
{
  "THECATAPI_KEY": "your_key_here"
}
```

2. Run or build with the file:

```bash
flutter run --dart-define-from-file=.secrets/thecatapi.json
flutter build apk --dart-define-from-file=.secrets/thecatapi.json
```

`CatsService` reads `THECATAPI_KEY` via `String.fromEnvironment` and will include it as the `x-api-key` header when present. For production, consider a server-side proxy or key restrictions.

### Testing / Mocking Strategy
- Repo and HTTP client are injected into blocs — replace them with fakes/mocks in tests.
- We are using package:mocktail to stub network responses.
- To run tests with a local mock server, set a dart-define or configure the API base URL in lib/data/.

### Architecture / Project Layout
- lib/
  - main.dart — app entry
  - ui/ — presentation layer: screens, pages, widgets
    - home/ — home page layout, widgets and blocs
  - repository/ — data layer: repositories, services, models
  - main.dart — app entry


**Architecture (Layers)**
- **Presentation (`lib/ui/`)**: Widgets, pages and layout components. UI widgets should be dumb and receive data/state from BLoCs. See the home page layout and widgets in [lib/ui/home/](lib/ui/home/).
- **Business Logic (BLoC)**: BLoCs live near the UI they serve. Example: `RandomCatBloc` coordinates events -> states and lives at [lib/ui/home/pages/bloc/random_cat_bloc.dart](lib/ui/home/pages/bloc/random_cat_bloc.dart).
- **Repository / Service (Data Layer)**: Handle API calls and data transformation. `CatsRepository` delegates to `CatsService` (see [lib/repository/cats_repository.dart](lib/repository/cats_repository.dart) and [lib/repository/service/cats_service.dart](lib/repository/service/cats_service.dart)).
- **Models**: Domain/data objects are in [lib/repository/models/](lib/repository/models/).

**Observability**
- A global `BlocObserver` is implemented at [lib/ui/utils/bloc_observer.dart](lib/ui/utils/bloc_observer.dart) to help trace transitions and cubit changes during development.


