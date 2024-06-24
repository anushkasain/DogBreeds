//
//  README.md
//  DogBreadDemo
//
//  Created by Anushka Sain on 24/06/24.
//

# Dog Breed Image Catalog

## Table of Contents

1. Introduction
2. Features
3. Requirements
4. Installation
5. Usage
6. Architecture
7. Third-Party Libraries
8. API Reference
  

## 1. Introduction

Welcome to the Dog Breed Image Catalog project! This iOS application allows users to explore various dog breeds with images fetched from the Dog API. Users can view breeds, see images of each breed, and manage their favorite dog images.

## 2. Features

The application includes the following features:

### Dog Breeds List

 i. View a list of available dog breeds.
 
 ii.Tap on a breed to navigate to its dedicated screen.


### Dog Breed Screen

 i. View multiple images of a selected dog breed.
 
 ii.Like or unlike images by tapping a button.

### Favorite Images Screen

 i. View liked images along with their corresponding dog breeds.
 
 ii.Filter favorite images by selecting a specific breed.
 
## 3. Requirements

##. iOS
##. Xcode
##. Swift


## 4. Installation

Follow these steps to set up and run the project:

```bash
### 1. Clone the Repository
https://github.com/anushkasain/DogBreeds.git
```

### 2. Open in Xcode

```bash
Open the .xcworkspace file in Xcode.
```

### 3. Install Dependencies
Ensure all CocoaPods dependencies are installed:

```bash
pod install
```

### 4. Build and Run
Select your target device or simulator and press Cmd + R to build and run the app.

## 4. Usage

Once the application is running, you can:

### 1. Explore Dog Breeds: Navigate through the list of dog breeds.
### 2. View Breed Details: Tap on a breed to see its images.
### 3. Manage Favorites: Like or unlike images and view your favorite images in the favorites screen.

## 5. Architecture

The app follows the MVVM (Model-View-ViewModel) architecture for a clean separation of concerns and easier maintainability.

### 1. Model: Data structures representing dog breeds and images.
### 2. View: UI components displaying lists, images, and buttons.
### 3. ViewModel: Handles data fetching and business logic, providing the View with data.


##6. Third-Party Libraries
This project leverages the following third-party libraries to enhance functionality and improve performance:

###1. Alamofire
Alamofire is a popular Swift-based HTTP networking library. It simplifies network requests and provides an easy-to-use API for handling asynchronous data fetch operations.

###2. SDWebImage
SDWebImage is a library that provides an asynchronous image downloader with cache support. It allows efficient image loading and caching, which enhances the performance and user experience.

##7. API Reference

The application uses the Dog API to fetch data:

###. Endpoint for Breeds List

```http
GET /breeds/list/all
```

###. Endpoint for Breed Images

```http
GET /breed/{breed-name}/images
```
Fetches images for a specific breed.


