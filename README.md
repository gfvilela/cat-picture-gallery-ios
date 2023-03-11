# Cat Picture Gallery iOS App

## Description
The objective of this application is to fetch cat images from https://imgur.com, and show the pictures in the gallery.

## Requirements
- Xcode 14 or later
- Swift 5.0 or later
- Cocoapods

## Installation
- Clone the project repository on your local machine.
- Open the terminal and navigate to the project folder.
- Run the command pod install to install the project dependencies.
- Open the .xcworkspace file in Xcode.
- Build and run the application.

## Architecture
The project uses the MVVM Clean architecture, which separates the application responsibilities into distinct layers. The layers are as follows:

- **Presentation**: this layer is responsible for all the user interface presentation logic. Here are the classes that deal with the screen flow, user event handling, and updating the interface based on information received from other layers.

- **Domain**: this layer contains the business rules of the application. Here are the classes that deal with the application's business logic, such as validations, calculations, and data operations.

- **Data**: this layer is responsible for obtaining and storing data. Here are the classes that deal with data access, whether through network services, local databases, or other sources. The repository pattern is used in this layer, which provides an interface for fetching and storing data, decoupling the Data layer from the rest of the application. The repository pattern also facilitates unit testing, as it allows for easier mocking of data sources.

### Data Flow
![Data Flow](./dataflow.png)
1. View(UI) calls method from ViewModel (Presenter).
2. ViewModel executes Use Case.
3. Use Case combines data from User and Repositories.
4. Each Repository returns data from a Remote Data (Network), Persistent DB Storage Source or In-memory Data (Remote or Cached).
5. Information flows back to the View(UI) where we display the list of items.

## Dependencies
The project uses the following dependencies, managed by Cocoapods:

- [Alamofire](https://github.com/Alamofire/Alamofire): Alamofire is an HTTP networking library written in Swift.
- [Kingfisher](https://github.com/onevcat/Kingfisher): Kingfisher is a powerful, pure-Swift library for downloading and caching images from the web. It provides you a chance to use a pure-Swift way to work with remote images in your next app.

## Author
[Gustavo Vilela](https://github.com/gfvilela)

## License
This project is licensed under the MIT License.


