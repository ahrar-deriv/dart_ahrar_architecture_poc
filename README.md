# The Engine 

Welcome to the Engine – more than an architectural framework, it's a comprehensive solution simplifying data management and dependency resolution within your application with its three-layered structure ensuring efficient data flow.
## 1. UI Layer

The UI Layer acts as the presentation layer where developers define a versatile model class capable of encompassing fields from various API requests. This model class, referred to as the UI model entity, serves as a mixed object. Developers craft these entities to represent the data they need to display or work with in the application's user interface. These entities are the bridge between the UI and Engine layers.

## 2. Engine Layer

The Engine Layer is the central intelligence of the architecture, responsible for orchestrating data retrieval, processing, and distribution. It plays a pivotal role in enhancing code reusability, maintainability, and the overall efficiency of the application. The core features of the Engine Layer include:

### 2.1 Observer Pattern

The cornerstone of the Engine Layer's functionality is the Observer pattern. This pattern enables efficient and asynchronous communication between the UI Layer and the Engine Layer. Here's a detailed breakdown of how the Observer pattern is employed:

#### Registration

At the start of the application or when a UI component is initialized, it registers itself as an observer with the Engine Layer. This registration allows the Engine Layer to notify registered observers when relevant data is available.

#### Data Request

When a UI component requires data to populate its UI model entities, it initiates a request to the Engine Layer. This request typically includes the UI model entity that needs to be filled with data.

#### Dependency Resolution

The Engine Layer is aware of the data dependencies within the application, thanks to the XML file defined by the developer. If one API call depends on the data retrieved from another API call (e.g., authentication preceding data retrieval), the Engine Layer intelligently resolves these dependencies.

#### Data Retrieval

Once the Engine Layer understands the data requirements, it leverages this knowledge to fetch data from the Data Layer (API). Importantly, the Engine Layer avoids redundant API calls by considering whether it already possesses some of the required data. If the data is already available, it is used without invoking additional API requests. This optimization enhances application performance and minimizes network traffic.

#### Data Distribution

Once the data is retrieved or updated, the Engine Layer sends this data as a stream to all registered observers. Each UI component that requested data receives the relevant information, ensuring that UI elements stay up to date with the latest data.

By implementing the Observer pattern, the Engine Layer streamlines data retrieval and distribution, fostering responsiveness and avoiding wasteful API calls.

## 3. Data Layer (API)

The Data Layer represents the external data sources, typically in the form of APIs. It is the source of truth for the application's data. Developers define and manage API endpoints, authentication mechanisms, and data retrieval logic within this layer.

## Benefits

The Engine Layer significantly simplifies application development and offers a host of advantages:

- **Reusability**: The Engine Layer is designed for reuse across various projects. Developers only need to configure the XML dependency and specify the data model folder directory to integrate it into new projects.

- **Automatic API Handling**: The Engine Layer automates API call management, making it easier for developers to focus on building features rather than dealing with intricate data retrieval and dependency resolution.

- **Efficiency**: By intelligently managing API calls and avoiding duplicates, the Engine Layer boosts application performance and ensures a seamless user experience.

- **Flexibility**: Introducing new features or modifying existing ones becomes straightforward, as developers only need to pass a UI model entity to the Engine Layer. The Engine Layer, in turn, takes care of data retrieval, dependency resolution, and data distribution.

By adopting this architectural approach, you create a plug-and-play system that enhances code reusability, maintainability, and scalability in your projects. It simplifies complex data management tasks, empowering developers to create robust applications efficiently.

![solution](https://github.com/ahrar-deriv/dart_ahrar_architecture_poc/assets/98078754/ede98b19-9048-4c07-944f-ea6d3e55bef9)

