
# Grossery - Software Architecture

## 1. Overview

Grossery is a hyperlocal grocery delivery platform built on a serverless architecture using Flutter for the front-end and Firebase for the back-end. The architecture is designed to be scalable, secure, and maintainable.

## 2. System Components

The system is composed of the following components:

- **Customer App:** A Flutter-based mobile app for customers to browse products, place orders, and track deliveries.
- **Shop Owner App:** A Flutter-based mobile app for shop owners to manage their products, orders, and shop information.
- **Admin Panel:** A web-based dashboard for administrators to manage the platform, including users, shops, orders, and commissions.
- **Firebase Backend:** A suite of Firebase services that provide the back-end functionality for the platform, including authentication, database, storage, messaging, and serverless functions.

## 3. Architecture Diagram

```
[Customer App (Flutter)] <--> [Firebase (Authentication, Firestore, Storage, Cloud Messaging)] <--> [Cloud Functions] <--> [Google Maps API, Stripe API]
[Shop Owner App (Flutter)] <--> [Firebase (Authentication, Firestore, Storage, Cloud Messaging)] <--> [Cloud Functions]
[Admin Panel (Web)] <--> [Firebase (Authentication, Firestore, Storage, Cloud Messaging)] <--> [Cloud Functions]
```

## 4. Layers

The architecture is divided into the following layers:

- **Presentation Layer:** The user interface of the customer app, shop owner app, and admin panel. This layer is responsible for displaying data to the user and capturing user input.
- **Business Logic Layer:** The core business logic of the platform, implemented in Firebase Cloud Functions. This layer is responsible for processing orders, managing users and shops, and handling payments.
- **Data Access Layer:** The data access layer, implemented using Cloud Firestore. This layer is responsible for storing and retrieving data from the database.
- **Services Layer:** The services layer, which integrates with third-party services such as Google Maps and Stripe.

## 5. Firebase Services

- **Firebase Authentication:** Used for user authentication, supporting phone OTP, email, Google, and Apple login.
- **Cloud Firestore:** A NoSQL database used to store all the platform's data, including users, shops, products, and orders.
- **Firebase Storage:** Used to store user-generated content, such as product images and shop photos.
- **Firebase Cloud Messaging:** Used to send push notifications to customers and shop owners.
- **Firebase Cloud Functions:** Used to implement the back-end business logic, such as the Smart Shop Assignment Engine.
- **Firebase Analytics:** Used to collect analytics data on user behavior and app usage.
- **Firebase Crashlytics:** Used to track and analyze app crashes.

## 6. Smart Shop Assignment Engine

The Smart Shop Assignment Engine is a key feature of the platform. It is implemented as a Firebase Cloud Function that is triggered when a customer places an order. The engine performs the following steps:

1. Gets the customer's GPS location.
2. Finds all approved grocery shops within the customer's delivery area.
3. Checks the stock availability of the ordered products in each shop.
4. Ranks the shops based on a weighted algorithm that considers distance, product availability, shop rating, and response performance.
5. Assigns the order to the highest-scoring shop.
6. Sends a push notification to the shop owner.
7. If the shop owner does not accept the order within a specified time, the engine reassigns the order to the next best shop.
