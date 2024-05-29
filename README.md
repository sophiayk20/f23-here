# Here
Here is an innovative location-based augmented reality (AR) social app shifts the focus from the present moment to the here and now. 
With our app, users can leave messages or AR content at specific locations for their friends or the general public to discover. 
These planted messages become digital markers in the physical world, creating a unique and immersive social experience. 
Users can explore their surroundings and stumble upon messages from both old and new friends within a certain distance range, which initially starts at 10 meters but expands as messages gain more likes, views, and replies. 
Beyond personal connections, our platform encourages participation in large-scale public discussions, allowing users to engage in meaningful discourse about the world around them. 
Join us in redefining social interaction in the digital age with a fresh perspective on location-based AR communication.
[Demo](https://www.youtube.com/watch?v=4D7088dEMl4)

Edit: Co-created with 6 other collaborators, all CS undergrads at Yale.

## Table of Contents
1. [MVP Requirement Fullfillment](#mvp-requirement-fullfillment)
2. [Deployment](#deployment)
3. [Running Instructions](#running-instructions)
   - [Running Frontend](#running-frontend)
   - [Running Backend](#running-backend)
4. [Adding to the Codebase](#adding-to-the-codebase)
   - [Frontend](#frontend)
     - [Adding a New Feature](#adding-a-new-feature)
     - [Example: Adding a 'Reaction' Feature](#example-adding-a-reaction-feature)
     - [Adding Frontend Tests](#adding-frontend-tests)
   - [Backend](#backend)
     - [Adding Backend Routes](#adding-backend-routes)
     - [Example Route and Controller Implementation](#example-route-and-controller-implementation)
     - [Adding Backend Tests](#adding-backend-tests)
5. [Testing](#testing)
   - [Backend](#backend-1)
   - [Frontend](#frontend-1)
6. [Metrics Milestone](#metrics-milestone)
   - [Version and Deployment](#version-and-deployment)
   - [Tracking](#tracking)
   - [Evaluation](#evaluation)
   - [Coresponding Code](#coresponding-code)

# Running Instructions

## Running Frontend

1. **Clone the Repository:**
   - If you haven't already, clone the repository to your local machine using `git clone https://github.com/yale-swe/f23-here`.

2. **Open the Project in Xcode:**
   - Navigate to the `app` directory within the cloned repository.
   - Open this folder with Xcode.

3. **Select a Simulator or Device:**
   - In Xcode, choose a simulator or connect a physical iOS device to run the application on.

4. **Build and Run the Project:**
   - Click on the "Play" button or use the shortcut `Cmd + R` to build and run the application.


## Running Backend
1. **Clone the Repository:**
   - If you haven't already, clone the repository to your local machine using `git clone https://github.com/yale-swe/f23-here`.

2. **Navigate to the Server Directory:**
   - Open a terminal and navigate to the `server` directory within the cloned repository.

3. **Install Dependencies:**
   - Run the command `npm install` to install all the necessary dependencies for the backend server.

4. **Environment Variables:**
   - Set up the required environment variables. Refer to the example below for the necessary variables.

5. **Start the Server:**
   - Run the command `node server.js` to start the backend server.
   - The server should now be running and accessible on the specified port.

```env
# .env file example

PORT=6000
MONGO_URL=mongodb+srv://heredemo:swe439here@clusterdemo.mnbogqc.mongodb.net/
API_KEY=qe5YT6jOgiA422_UcdbmVxxG1Z6G48aHV7fSV4TbAPs
```


# MVP Requirement Fullfillment
- [✔] Message Viewing Capability: Users can view all messages
- [✔] Message Visitng Capability at Specific Locations: Users can view all messages when they are within a predefined geographical area covered by the app.
- [✔] Range Specification for Reading Messages: Implemented a feature that allows users to read messages within a specified starting range. This range is essential for accessing both friends' and public messages.
- [✔] Location-Based Accessibility of Friends' and Public Messages: Users can access messages from friends when they are within the designated range of the message's origin and public messages are available to users within the specified range, ensuring location-relevant content.
- [✔] Friend Addition Functionality: The app includes a feature to add friends by searching for their account IDs, facilitating user connections within the platform.
- [✔] Range Limitations for Message Accessibility: Enforced range limitations for reading messages to enhance user experience and data relevance based on location.
- [✔] Adding and Deleting Friends: Users can add and delete friends.


# Deployment
Requirements: iOS 16.0 and above
We are using TestFlight Internal to deploy Here Beta Version. To use this app:
1. Email xinran.li@yale.edu to request access to Here!
2. You will receive an email from TestFlight saying that "Here - discover messages in AR 0.1.0 for iOS is now available to test." Click on "View in TestFlight" to find the redeem code.
3. Download TestFlight on you iPhone and accept the invitation in TestFlight, enter the redeem code, then TestFlight will automatically download the app for you.
4. Try our app!

Refer to [API Documentation](API-Documentation.md) for details on API deployment.

# Adding to the Codebase

### Important Note

When introducing changes, always create a new branch from the main branch. After implementing your changes, initiate a pull request and request a code review from a teammate. Following approval, merge your changes into the main branch. Ensure that your merge passes all checks in GitHub Actions to maintain build integrity. Make sure there is at least 80% statement coverage across all files for the backend when implementing new changes.

## Frontend

### Adding a new Feature

The project is structured into various directories:

- `Models`: Contains the data models such as `Message`.
- `Utils`: Includes utility functions and api calls in `api_call`.
- `Views`: UI components of the app, including `HomePageView`, `MessageList`, etc.

### Steps to Add a New Feature


1. **Update the Model**
   - If the feature requires new data structures, update the `Models` directory.
   - For example, to add reactions to messages, you might need a `Reaction` model.

2. **Create a New View**
   - In the `Views` directory, create a new SwiftUI View for your feature.
   - Use the existing naming convention, e.g., `ReactionView.swift`.

3. **Integrate ARKit**
   - If the feature is AR-related, modify `CustomARViewRepresentable` or create a new AR view.

4. **Update State Management**
   - Add necessary `@Published` properties in `MessageState` or `FetchedMessagesState` to react to data changes.

5. **Modify Existing Views**
   - Update `HomePageView` to incorporate the new feature.
   - Add buttons or controls as needed to interact with the new feature.

6. **Documentation:**
   - Comment your code to explain the functionality of your new feature and depdencies. 

6. **Testing**
   - Use `newHereTests` and `newHereUITests` for testing appropriate changes, depending on if the feature has UI integration or not.

### Example: Adding a 'Reaction' Feature

1. Create `Reaction.swift` in the `Models` directory.
2. Create `ReactionView.swift` in the `Views` directory.
3. Update `MessageState` with `@Published var reactions: [Reaction]?`.
4. In `HomePageView`, add a button for reactions.
5. Write unit tests for the feature in Xcode.

## Backend

### Adding Backend Routes
To add a new backend route, navigate to the `server` folder. In the `controllers` folder. Add a controller method corresponding to one of authentication (`auth.js`), message (`message.js`), reply (`reply.js`), and user (`user.js`). Then, navigate to the `routes` folder. Import the controller method and define/add the corresponding route.

1. **Plan the Endpoint:**
   - Decide the HTTP method (GET, POST, PUT, DELETE) appropriate for the action.
   - Choose a descriptive endpoint path that follows RESTful conventions and aligns with existing routes.

2. **Update or Create the Route File:**
   - Locate the `routes` directory within the `server` folder.
   - If a relevant route file (e.g., `message.js` for message-related features) exists, open it; otherwise, create a new `.js` file.

3. **Implement the Route:**
   - Import necessary modules and middleware.
   - Define the route using `router.METHOD(PATH, HANDLER)`.
   - Use `handleSuccess`, `handleBadRequest`, `handleServerError`, and `handleNotFound` for response handling found in `utils`.

4. **Create Controller Functions:**
   - Navigate to the `controllers` directory within the `server` folder.
   - Create a new controller file or open an existing one that corresponds to the new route.
   - Write a new controller function that includes:
     - Input validation and sanitation.
     - Interaction with the database through Mongoose models.
     - Proper response with success or error messages.

5. **Testing:**
   - Write unit tests for your new controller functions.
   - For detailed instructions see the testing instructions below.
   - Run tests to ensure your code behaves as expected.

6. **Documentation:**
   - Comment your code to explain the functionality of routes and controllers.
   - Update `API_DOC.md` the new endpoints and their usage.

### Example Route and Controller Implementation

```javascript
// In user.js route file
router.get("/:userId", getUserById);

// In user.js controller file
export const getUserById = async (req, res) => {
	try {
		const user = await UserModel.findById(req.params.userId);

		if (!user) {
			return handleNotFound(res, "User not found");
		}

		handleSuccess(res, user);
	} catch (err) {
		handleServerError(res, err);
	}
};
```

### Adding Backend Tests

1. **Locate the Test File:** Navigate to the `__tests__` directory under `server`. Here, you'll find organized subdirectories for different aspects of the API, such as `controllers`, `models`, and `routes`.

2. **Create a Test File:** If a test file does not already exist in the section you edit, create one within the appropriate subdirectory. The file should be named after the feature with the suffix `Test.js`.

4. **Write Test Cases:**
    - Import the necessary modules and mock dependencies.
    - Use `describe` blocks to group related tests.
    - Within each `describe` block, write individual `it` or `test` functions for each aspect of the feature you want to test.
    - Use `expect` to assert expected outcomes.

5. **Mocking:**
    - Mock any models or external calls that your feature interacts with to isolate the feature's functionality.
    - Use `jest.mock()` to replace actual implementations with mock functions that return testable results.

6. **Running Tests:**
    - To run your tests, use the command `npm test --coverage`.
    - Ensure that your new tests pass without interfering with existing tests.

7. **Review and Refactor:**
    - Review your tests to ensure they're comprehensive and cover all possible scenarios.

### Example

Here is an example of a basic test case:

```javascript
describe("Function", () => {
  it("should return 400", async () => {
    // Setup
    // ...

    // Execution
    const result = await function();

    // Assertion
    expect(result).toBe(expectedResult);
  });
});
```

# Testing

## Threshold: 80% Statment Coverage

## Backend
To run our testing script in the backend, execute the following:

```bash
cd server
npm test --coverage
```

Current Coverge: 

| % Stmts | % Branch | % Funcs | % Lines |
|---------|----------|---------|---------|
| 90.35   | 92.5     | 85.71   | 90.49   |


## Frontend
To run our testing script in the frontend, execute the following command in XCode:

1. **Run Tests**
   - **Command**: `Cmd/Ctrl + U`
   - **Description**: This command will execute the testing script.

2. **View Coverage Report**
   - **Command**: `Cmd/Ctrl + 9`
   - **Description**: Use this command to access and view the code coverage report.

Current Coverge: 
| % Stmts | 
|---------|
| 6.7%    |

**NOTE**: As discussed with Professor Antonopoulos, we are currently facing difficulty implementing unit tests using XCTests. 

We are unable to mock functions in our codebase because we are using dependencies such as ARKit. Since ARKit relies on interactions with devices such as an iPhone, it's hard to mock this environment effectively. Our app uses real-time environmental data and spatial processing, so creating scenarios to run our unit tests effectively is not feasiable for the scope of this project and our first-time knowledge in unit-testing in Swift.

In addition, XCode itself makes running the test bundle inconsistent. Depending on our device, a test might compile on one laptop but not on another. This is especially prevalent when we are trying to write and run UI unit tests that simulates certain UI interactions. 

We get errors like these:


```
Failed to load the test bundle. 
The bundle "newHereUITests" couldn't be loaded. 
The bundle couldn't be loaded. Try reinstalling the bundle.
```

Overall, due to the inherent complexity of unit testing in Xcode in Swift with XCTest, we are unable to write meaningful or functional unit tests; even after dedicating significant time. Despite not successfully writing unit tests in the frontend, we have learned the following:

- How to effectively perform manual testing
   - Since we are unable to write unit tests, we had to make sure to precisely manually test different interactions to ensure there were no issues.
   - We were able to come up with various user interaction scenarios and manually perform these actions to ensure that our application works as intended.
- Document and report on issues like these for future reference and communicate these issues to others.
- Challenges of mocking environments that rely on hardware interactions.

 Thus, we were told not to worry about getting 80% statement coverage for the frontend tests, especially since we've met the requirement for back-end tests. We were told to document this issue in detail, which we did above.


# Metrics Milestone

For the metrics milestone, we are implementing 3 different versions of the "screenshot" button in our app.

Unfortunately, as of right now, Swift has no API tools that help us automatically display the most optimal version of your app to your users. This is because with iOS applications, the user needs to update the app to get the most optimal version of the app. However, this does not prevent us from measuring user behavior and adapting the app for future versions with the implementation that people prefer the most.

## Version and Deployment

We have 3 TestFlight builds, each representing a different icon for the screenshot feature. We will distribute these builds evenly across our user pools using special links generated from the TestFlight website.

<div style="display: flex; justify-content: space-between;">
  <img src="docs/icon1.jpeg" alt="Icon 1" style="flex: 1; max-width: 30%; max-height: 60%;">
  <img src="docs/icon2.jpeg" alt="Icon 2" style="flex: 1; max-width: 30%; max-height: 60%;">
  <img src="docs/icon3.jpeg" alt="Icon 3" style="flex: 1; max-width: 30%; max-height: 60%;">
</div>

</br>

<img src="docs/builds.jpeg" alt="builds" width="500px">


## Tracking

To implement tracking of how many users tap on each icon, we have implemented a backend model called "Metrics" with the following schema fields:

- `metrics_name`: Unique name identifier for the metrics record.
- `clicks`: Count of clicks, used for tracking user interactions.
- `total_distribution`: Represents the distribution value, defaulting to 50.

When a user clicks on the icon, the respective API call will be made to increment the metric for that API.

## Evaluation

After our user testing, we will go into the backend and calculate the percentage of users that tap on the screenshot feature for each icon. To do that, we will use this formula:

```javascript
percent_interaction = clicks / total_distribution
```

The icon with the highest percent_interaction will be selected as the final icon to be deployed to everyone in the app.

## Coresponding Code

- server/controllers/metrics.js
- server/model/Metrics.js
- server/routes/metrics.js
- app/newHere/Views/Home/Home.swift
