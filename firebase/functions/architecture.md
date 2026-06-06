
# Cloud Functions Architecture

This document outlines the architecture of the Firebase Cloud Functions for the Grossery platform.

## Functions

### 1. `onboardNewUser`

- **Trigger:** `auth.user().onCreate()`
- **Description:** When a new user is created, this function creates a corresponding user document in the `users` collection in Firestore.

### 2. `assignOrder`

- **Trigger:** `firestore.document('orders/{orderId}').onCreate()`
- **Description:** This is the core of the Smart Shop Assignment Engine. When a new order is created, this function finds the best shop to fulfill the order based on the customer's location, product availability, shop rating, and response performance.
- **Steps:**
  1. Get customer GPS location from the order.
  2. Query the `shops` collection to find all approved and active shops.
  3. Filter out shops that do not deliver to the customer's area.
  4. For each remaining shop, check the availability of the products in the order.
  5. Calculate a score for each shop based on distance, availability, rating, and performance.
  6. Assign the order to the shop with the highest score.
  7. Send a push notification to the shop owner.
  8. Set a timer for 3 minutes. If the shop owner does not accept the order within that time, re-assign the order to the next best shop.

### 3. `onOrderUpdate`

- **Trigger:** `firestore.document('orders/{orderId}').onUpdate()`
- **Description:** This function sends push notifications to the customer when the status of their order changes.
- **Notifications:**
  - Order Confirmed
  - Shop Assigned
  - Accepted
  - Preparing
  - Out For Delivery
  - Delivered

### 4. `onShopRegistration`

- **Trigger:** `firestore.document('shops/{shopId}').onCreate()`
- **Description:** This function sends a notification to the admin when a new shop registers.

### 5. `calculateCommissions`

- **Trigger:** `firestore.document('orders/{orderId}').onUpdate()`
- **Description:** When an order is marked as "Delivered", this function calculates the commission for the shop and saves it in the `commissions` collection.

## State Management Recommendation

For the Flutter application, we recommend using the **Provider** package for state management. It is a simple and powerful solution that is well-suited for this project. We will use a combination of `ChangeNotifierProvider` and `FutureProvider` to manage the app's state.

## API/Service Layer Structure

The API/service layer will be responsible for communicating with the Firebase backend. We will create a `FirebaseService` class that will encapsulate all the Firebase API calls. This will make the code more modular and easier to maintain.

## Admin Panel Architecture

The admin panel will be a web-based application built with Flutter for Web. It will have its own set of screens and widgets for managing the platform.

## Shop Dashboard Architecture

The shop dashboard will be part of the shop owner app. It will provide the shop owner with a real-time overview of their business, including orders, revenue, and product inventory.

## Customer App Architecture

The customer app will be the main interface for customers. It will be designed to be user-friendly and intuitive, with a focus on a seamless ordering experience.

## Deployment Plan

- **Flutter Apps:** The customer and shop owner apps will be deployed to the Apple App Store and Google Play Store using Codemagic or a similar CI/CD service.
- **Admin Panel:** The admin panel will be deployed to Firebase Hosting.
- **Firebase:** The Firebase backend will be deployed using the Firebase CLI.

## Scalability Strategy

The serverless architecture of Firebase is inherently scalable. As the number of users and orders grows, Firebase will automatically scale to meet the demand. We will also use Firestore's indexing and querying capabilities to ensure that the database performs well at scale.

## Cost Estimation for Firebase

The cost of Firebase will depend on the usage of the platform. The free "Spark" plan is sufficient for development and testing. As the platform grows, we will need to upgrade to a paid plan. We will monitor the usage of the platform and optimize our code to keep costs down.

## MVP Roadmap

1.  **Phase 1: Core Functionality (1-2 months)**
    *   Customer and Shop Owner authentication
    *   Product and Order management
    *   Smart Shop Assignment Engine
    *   Cash on Delivery
2.  **Phase 2: Payments and Tracking (1 month)**
    *   Stripe integration for card payments
    *   Real-time order tracking
3.  **Phase 3: Admin Panel and Analytics (1-2 months)**
    *   Admin panel for managing the platform
    *   Firebase Analytics integration

## Production Launch Checklist

1.  Set up a production Firebase project.
2.  Configure Firebase Authentication with all the required providers.
3.  Set up Firestore and create the necessary collections and indexes.
4.  Deploy the Firestore security rules.
5.  Deploy the Cloud Functions.
6.  Set up Firebase Storage and create the necessary storage buckets.
7.  Configure Firebase Cloud Messaging.
8.  Set up Firebase Analytics and Crashlytics.
9.  Thoroughly test the entire platform.
10. Deploy the customer and shop owner apps to the app stores.
11. Deploy the admin panel to Firebase Hosting.
12. Monitor the platform for any issues.