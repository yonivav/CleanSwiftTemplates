# CleanSwiftTemplates
Clean Swift (a.k.a VIP) is Uncle Bob’s Clean Architecture applied to iOS and Mac projects. This pRoject contains convenience template to add new code

## Installation
1. download this project
2. open Finder Mac app
3. open folder (⌘+⇧+G): ~/Library/Developer/Xcode/DerivedData
4. paste there the templates
5. finish

# Example

## About Clean Swift
A very good explanation: 
good explanation: https://zonneveld.dev/the-clean-swift-architecture-explained/
and also:
https://clean-swift.com/clean-swift-ios-architecture/
https://sudonull.com/post/14437-Clean-swift-architecture-as-an-alternative-to-VIPER
https://medium.com/dev-genius/clean-swift-vip-with-example-6f6e643a1a01
 
In short:
### Structure
Our purpose in a Clean Swift design pattern is to separate the responsibilities of different entities for clarity and testibility. Together, these entities form what we call scenes. Each family is able to operate independently using only the components within that family.
The components of each family may include the following:
	•	View Controller (with .xib or .storyboard file)
	•	Interactor
	•	Presenter
	•	Model
	•	(optional) Router
	•	(optional) Worker

### The VIP cycle
The Clean Swift architecture is using a VIP cycle to help you separate logic in your application. The VIP cycle consists of a ViewController, Interactor and a Presenter. All classes are responsible for some logic. The ViewController is responsible for the display logic, the Interactor is responsible for the business logic and the Presenter is responsible for the presentation logic.

The ViewController is the first class where the action is triggered. The class is responsible for managing the views in the ViewController. In the ViewController, all the outlets and IBAction functions should be listed.
As soon as an action in the ViewController started, the ViewController will pass that action to the Interactor. The Interactor is the class where all the use cases should be implemented. By doing this, the Interactor is the class which contains all the business logic. This is a big benefit when writing unit tests, because when testing all interactors, all the business logic in your app is tested.
The Interactor is responsible for handling the request and will return an object to the Presenter. The Presenter is the class which is responsible for presenting the object which is generated by the Interactor. The Presenter will parse that object to a ViewModel object and return an object to the ViewController to display.
Using the Clean Swift architecture, you know exactly which logic should be located in which class. This makes your code more maintainable, because when you need to solve a bug or want to add more functionalities, you know exactly where in your code the change should be made.

### Model
During the VIP cycle, each class will add a data object when requesting an action from the other class in the cycle. When the ViewController asks the interactor to request an action from the Interactor, the ViewController will add a ‘Request’ object. This object contains all the data the interactor needs to do the business logic.
The Interactor will handle the request. Once the data has been processed, it will return a ‘Response’ object to the Presenter. The Presenter will parse the data which is needed to a ‘ViewModel’ object, which will be sent to the ViewController. When the ViewModel is received by the ViewController, the ViewController only needs to update the UI elements with the data in the ViewModel.


### Router
There may be situations in your app that the ViewController will present another ViewController. In Clean Swift, navigating between ViewControllers is done by a Router.
If there are navigation options available for the ViewController, a Router class is added to the ViewController. The Router class contains all the navigation options where that specific ViewController can navigate trough. By doing this, almost each VIP cycle will have a Router, which makes it clear what navigation options a ViewController has.
A Presentor is responsible for the presentation logic. When a screen transition will take place, the ViewController needs to ask this to the Interactor and then the Interactor needs to ask this to the Presentor. From there, the Presentor will decide that the ViewController may route to the next ViewController using the Router.


### Worker
When having all business logic located in the Interactor, there may happen a situation where the Interactor will be a very large class. To prevent this, an Interactor can make use of multiple workers. A Worker is a helper of the Interactor, which can help receiving data.
A Worker is responsible for creating objects and doing network calls. Besides that, a Worker can be used to implement Third Party SDKs in your application. For example, if you use Alamofire for doing network requests, but do all the network requests in workers, the Alamofire SDK only needs to be imported in the worker.
Workers must be generic, which means multiple interactors can use them if needed to handle data.
