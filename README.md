
# Simulación de Gas Ideal

## Descripción

Este proyecto contiene una aplicación en swift para el proyecto de la clase Física 3. Incluye simulaciones interactivas, calculadoras, explicaciones teóricas y cuestionarios.

## Estructura del Proyecto

El proyecto está organizado de la siguiente manera:

- **Utilities**
  - `HapticManager.swift`: Maneja la retroalimentación háptica para una mejor experiencia de usuario.
- **ViewModels**
  - `GasSimulationViewModel.swift`: Gestiona los datos para las simulaciones de gas.
- **Views**
  - `ContentView.swift`: El punto de entrada principal de la aplicación.
  - `GasCalculatorView.swift`: Proporciona una calculadora para las propiedades de los gases.
  - `TriviaView.swift`: Contiene la interfaz del cuestionario de trivia.
  - `TheoryView.swift`: Muestra información teórica sobre los gases ideales.
- **Models**
  - `Model.swift`: Contiene los modelos de datos utilizados en la aplicación.
- **ideal_gasApp.swift**: El archivo principal de la aplicación que inicia la app en SwiftUI.

## Patrones y Paradigmas Utilizados

- **MVVM (Model-View-ViewModel)**: Este patrón arquitectónico separa el desarrollo de la interfaz gráfica de usuario (UI) del desarrollo de la lógica de negocio.
- **Programación Reactiva**
- **Programación Orientada a Objetos**

## Leyes de Gases Ideales

En la sección de teoría, se incluyen generalidades de:

- **Ley de Boyle**
- **Ley de Charles**
- **Ley de Gay-Lussac**
- **Ley de los Gases Ideales**

## Ejecutar el Proyecto

### En un Mac con Xcode

1. **Instalar Xcode**:
   - Descargue Xcode desde la App Store.
   - Abra Xcode y ejecute el un simulador de iOS o en preview desde el archivo ContentView.

2. **Clonar el Repositorio**:
   
   git clone https://github.com/sebas1541/iOS-Ideal-Gas-App.git
   cd ideal_gas
  
3. **Abrir el Proyecto**:
   - Abra `ideal_gas.xcodeproj` o `ideal_gas.xcworkspace` en Xcode.

4. **Hacer Build y Ejecutar**:
   - Seleccione su dispositivo o simulador de destino en la parte superior de Xcode.
   - Haga clic en el botón "Run" (también puede usar el atajo Cmd + R).

### Ejecutar en iOS

1. **Conectar un Dispositivo iOS**:
   - Conecte su iPhone o iPad a su Mac.

2. **Seleccionar Dispositivo en Xcode**:
   - En Xcode, seleccione su dispositivo iOS conectado desde el menú desplegable de dispositivos.

3. **Configurar iPhone**:
   - En Xcode, seleccione su dispositivo iOS conectado desde el menú desplegable de dispositivos. Active el modo desarrollador en su iPhone en la sección Configuración y Privacidad. Luego de importar la app, dirímase a VPN & Device Management, habilite instalación de aplicaciones de terceros.

4. **Construir y Ejecutar**:
   - Haga clic en el botón "Run" para instalar y ejecutar la aplicación en su dispositivo iOS.

### Si no dispone de un Mac o iPhone

Puede virtualizar macOS dentro de sistemas operativos como Windows o Linux.

1. **Crear una Máquina Virtual**:
   - Instale una herramienta de virtualización como VMware o VirtualBox en su computador.
   - Descargue una imagen de macOS y cree una nueva máquina virtual.
   - Asegurese de que la virtualización de macOS puede acceder a la App Store y crear un Apple ID.

2. **Instalar macOS**:
   - Siga las instrucciones para instalar macOS en la máquina virtual.

3. **Configurar Xcode**:
   - Instale Xcode desde la App Store dentro de la máquina virtual.

4. **Crear una Cuenta de Desarrollador de Apple**:
   - Regístrese para obtener una cuenta de desarrollador de Apple, con su mismo Apple ID.
   - Inicie sesión en Xcode con su Apple ID.

5. **Clonar y Ejecutar el Proyecto**:
   - Siga los pasos anteriores para clonar el repositorio y ejecutar el proyecto en Xcode.

## Consideraciones

Para cualquier problema o contribución, puede enviar un pull request :)

## Enlace del Repositorio

[Ideal Gas Simulation GitHub Repository](https://github.com/sebas1541/iOS-Ideal-Gas-App)

Aplicación desarrollada en Swift diseñada para simular y visualizar el comportamiento de un gas ideal. Este proyecto incluye varios modelos y vistas para ayudar a los usuarios a comprender los principios de la ley de los gases ideales a través de simulaciones interactivas.
