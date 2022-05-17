![logo](https://github.com/yonivav/CleanSwiftTemplates/blob/Orphan/image.png)
# CleanSwiftTemplates
Clean Swift (a.k.a VIP) is Uncle Bob’s Clean Architecture applied to iOS and Mac projects. In the 'Clean Swift' folder, you can find a convenience template to add a new Xcode. In 'CleanSwiftExample' you can see a basic example.

# Installation
1. Download the 'Clean Swift' folder from this project
2. In Finder Mac app: open folder (⌘+⇧+G): ~/Library/Developer/Xcode/Templates/
3. Open File Templates and paste the templates. It should look like this:
![imstructions0](https://github.com/yonivav/CleanSwiftTemplates/blob/Orphan/Instructions/instructions0.png)
4. Finish


## Example usage
Lets say we want to add a login screen to our application. It will receive input from the user, which will be validated, and finally, it will display a success or failure response.
For doing that please do:
1. Click on 'add new file' in Xcode, and click Next

![imstructionas1](https://github.com/yonivav/CleanSwiftTemplates/blob/Orphan/Instructions/instructions1.png)

2. In your template list go down and choose 'Scene' under the 'Clean Swift' section

![imstructionas2](https://github.com/yonivav/CleanSwiftTemplates/blob/Orphan/Instructions/instructions2.png)

3. type 'Login' for your new scene name. It should inherit from UIViewController.

![imstructionas3](https://github.com/yonivav/CleanSwiftTemplates/blob/Orphan/Instructions/instructions3.png)

You should see that all 6 files were added to your project

![imstructionas4](https://github.com/yonivav/CleanSwiftTemplates/blob/Orphan/Instructions/instructions4.png)

Finally, let's write some code!

The flow should look like this:
1. LoginViewController needs to request an interactor to log in, with a username and password.
Therefore, LoginViewInteractor should conform to a business logic protocol:
```
protocol LoginBusinessLogic {
    func login(request: Login.Something.Request)
}
```
2. LoginInteractor can validate this data in DB or network (NetworkWorker) and will answer it to LoginPresentor. 
Therefore, LoginViewPresenter should conform to a presentation logic protocol:
```
protocol LoginPresentationLogic {
    func presentLogin(response: Login.Login.Response)
}
```
Its not too long or complicated, so LoginWorker unneeded and can be delete.

3. LoginPresneter will parse and process the response, and send to the view controller a simple straight forward data:
Therefore, LoginViewController should conform to a display logic protocol:
```protocol LoginDisplayLogic: class
{
    func displayUser(viewModel: Login.Something.ViewModeSuccess)
    func displayError(viewModel: Login.Something.ViewModeFailure)
}
```

The model part is like that:
enum Something {
```
// MARK: Use cases
enum Login
{
    // MARK: Use cases

    enum Login {
        struct Request {
            let username, password: String
        }

        struct Response{
            let user: User
        }

        struct ViewModelSuccess{
            let username: String
            let age: Int
        }
        
        struct ViewModelFailure{
            let errorMessage: String
        }  
    }
}
```

4. If a user log in successfully, LoginViewController will inform LoginRouter to move to another screen.
Therefore, LoginRouter should conform to a routing logic protocol:
```
protocol LoginRoutingLogic {
    func routeToNextScreen(segue: UIStoryboardSegue?)
}
```

## Demo
Open the CleanSwiftTemplatesExample project in Xcode to see the Login scenario as described in the above example.


# About Clean Swift
A very good explanation:

https://zonneveld.dev/the-clean-swift-architecture-explained/

and also:

https://clean-swift.com/clean-swift-ios-architecture/

https://sudonull.com/post/14437-Clean-swift-architecture-as-an-alternative-to-VIPER

https://medium.com/dev-genius/clean-swift-vip-with-example-6f6e643a1a01


In short:
### Structure
The purpose of a Clean Swift design pattern is to separate the responsibilities of different entities for clarity and testability. Together, these entities form what we call scenes. Each family can operate independently using only the components within that family.
The components of each family may include the following:
* View Controller (with .xib or .storyboard file)
* Interactor
* Presenter
* Model
* (optional) Router
* (optional) Worker

### The VIP cycle
The Clean Swift architecture use a VIP cycle to help you separate logic in your application. The VIP cycle consists of a ViewController, Interactor, and a Presenter. All classes are responsible for some logic. The ViewController is responsible for the display logic, the Interactor is responsible for the business logic and the Presenter is responsible for the presentation logic.

The ViewController is the first class where the action is triggered. The class is responsible for managing the views in the ViewController. In the ViewController, all outlets and IBAction functions should be listed.
As soon as an action in the ViewController starts, the ViewController will pass that action to the Interactor. The Interactor is the class where all use cases should be implemented. By doing this, the Interactor is the class that contains all the business logic. This is a huge benefit when writing unit tests because when testing all interactors, all the business logic in your app is tested.
The Interactor is responsible for handling the request and will return an object to the Presenter. The Presenter is the class that is responsible for presenting the object which is generated by the Interactor. The Presenter will parse that object to a ViewModel object and return an object to the ViewController to display.
Using the Clean Swift architecture, you know exactly which logic should be located in which class. This makes your code more maintainable because when you need to solve a bug or want to add more functionalities, you know exactly where in your code the change should be made.

### Model
During the VIP cycle, each class will add a data object when requesting an action from the other class in the cycle. When the ViewController asks the interactor to request an action from the Interactor, the ViewController will add a ‘Request’ object. This object contains all the data the interactor needs to do the business logic.
The Interactor will handle the request. Once the data has been processed, it will return a ‘Response’ object to the Presenter. The Presenter will parse the data which is needed for a ‘ViewModel’ object, which will be sent to the ViewController. When the ViewModel is received by the ViewController, the ViewController only needs to update the UI elements with the data in the ViewModel.


### Router
There may be situations in your app where the ViewController will present another ViewController. In Clean Swift, navigating between ViewControllers is done by a Router.
If there are navigation options available for the ViewController, a Router class is added to the ViewController. The Router class contains all the navigation options where that specific ViewController can navigate through. By doing that, almost each VIP cycle will have a Router, which makes it clear what navigation options a ViewController has.
A Presentor is responsible for the presentation logic. When a screen transition take place, the ViewController needs to ask this to the Interactor and then the Interactor needs to ask this to the Presentor. From there, the Presentor will decide that the ViewController may route to the next ViewController using the Router.


### Worker
When having all business logic located in the Interactor, there may happen a situation where the Interactor will be a very large class. To prevent this, an Interactor can make use of multiple workers. A Worker is a helper of the Interactor, which can help receive data.
A Worker is responsible for creating objects and doing network calls. Besides that, a Worker can be use to implement Third Party SDKs in your application. For example, if you use Alamofire for network requests, but do all the network requests in workers, the Alamofire SDK only needs to be imported into the worker.
Workers must be generic, which means multiple interactors can use them if needed to handle data.


# Contact
Yoni Vizel

https://github.com/yonivav


# License
Inspired from [this template](https://github.com/oluckyman/CleanSwift). CleanSwiftTemplates is available under the MIT license. See the LICENSE file for more info.
