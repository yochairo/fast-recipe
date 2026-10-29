# Estructura del Proyecto: Clean Architecture + Riverpod

Este proyecto está desarrollado en Flutter utilizando una estructura **Feature-First** (Orientada a Funcionalidades) bajo los principios de **Clean Architecture**, combinada con **Riverpod** para el manejo de estado y la inyección de dependencias.

Esta combinación garantiza un código escalable, altamente testeable y reactivo.

## 🏗 Estructura de Carpetas

La aplicación se organiza dentro de la carpeta `lib/`, dividida en el núcleo global y los módulos de funcionalidades:

```
lib/
│
├── core/                   # Código compartido globalmente
│   ├── constants/          # Colores, strings, tamaños
│   ├── errors/             # Clases para manejo de excepciones (Failures, Exceptions)
│   ├── network/            # Configuración HTTP y clientes
│   ├── theme/              # Temas claros/oscuros, tipografías
│   └── utils/              # Funciones helpers globales
│
├── features/               # Módulos de la aplicación (ej. auth, home, profile)
│   │
│   └── [nombre_feature]/   
│       ├── data/           # 1. Capa de Datos
│       │   ├── datasources/# Peticiones a APIs, Firebase, o bases de datos locales
│       │   ├── models/     # Modelos (con fromJson / toJson)
│       │   └── repositories/# Implementación de la lógica de obtención de datos
│       │
│       ├── domain/         # 2. Capa de Dominio (Reglas de negocio puro)
│       │   ├── entities/   # Clases de Dart que representan los objetos del negocio
│       │   ├── repositories/# Contratos abstractos (Interfaces)
│       │   └── usecases/   # Acciones específicas que el usuario puede realizar
│       │
│       └── presentation/   # 3. Capa de Presentación (UI y Estado)
│           ├── pages/      # Pantallas visuales de la funcionalidad
│           ├── widgets/    # Componentes visuales reutilizables de esta feature
│           └── providers/  # ⚡ GESTIÓN DE ESTADO (Riverpod)
│                           # Aquí van los StateProviders, NotifierProviders, etc.
│
└── main.dart               # Punto de entrada y envoltura de ProviderScope

```

## 🧠 Explicación de las Capas

### 1. Domain (Dominio)

Es el núcleo del negocio. No conoce nada de Flutter, ni de Riverpod, ni de internet. Solo contiene clases de Dart (`Entities`), las interfaces de lo que necesita (`Repositories`) y las acciones que se pueden hacer (`UseCases`).

### 2. Data (Datos)

Es la capa encargada de interactuar con el mundo exterior. Llama a las APIs, guarda datos en el teléfono y convierte el código JSON en `Models`. Finalmente, transforma esos Modelos en `Entities` para entregárselos al Dominio.

### 3. Presentation (Presentación) + Riverpod

Es la capa donde el usuario interactúa. Aquí es donde brilla **Riverpod**:

* **UI (`pages/`, `widgets/`):** Muestran la información usando `ConsumerWidget` para escuchar los cambios.

* **Estado (`providers/`):** Aquí viven los `Providers` de Riverpod. Se encargan de llamar a los casos de uso (Domain), manejar la carga de datos (`AsyncValue.loading`, `data`, `error`) y actualizar la UI automáticamente. Además, Riverpod se usa aquí para inyectar los repositorios y casos de uso.

## 🚀 Empezando

Para ejecutar este proyecto en tu máquina local:

1. Asegúrate de tener [Flutter](https://docs.flutter.dev/get-started/install) instalado.

2. Clona este repositorio.

3. Ejecuta `flutter pub get` para instalar las dependencias (incluyendo `flutter_riverpod`).

4. Conecta un dispositivo o emulador y ejecuta `flutter run`.

> **Nota para desarrolladores:** Recuerda que la aplicación debe estar envuelta en un `ProviderScope()` en el archivo `main.dart` para que Riverpod funcione correctamente.