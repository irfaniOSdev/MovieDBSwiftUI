# MovieDBSwiftUI
 Some of the MovieDB APIs Implementation with SwiftUI, Combine and MVVM architecture

## Table of Contents

- [Introduction](#introduction)
- [Demo Video](#demo-video)
- [Tools and Technologies](#tools-and-technologies)
- [Project Structure](#project-structure)
- [Usage](#usage)

## Introduction
MovieDB demo implementation with SwiftUI, Combine and MVVM Architecture.I also created Network Manager pod and used it in the project for API calls as instructed in Assignment.
Here is the pod [MDNetworkManager](https://cocoapods.org/pods/MDNetworkManager)

## Demo Video

You can find demo video of app working below.

[Demo Video](https://drive.google.com/file/d/1HnRfMb4jekz-cYTnvc9APcTcOxKRsnty/view?usp=sharing)

### Features
- Popuplar Seasons list with pagination
- Season detail along with its episodes
- Episode details
- Video Player with dummy remote URL.

## Tools and Technologies

List of tools and technologies used in this project.

- **Xcode**: Version 15.2
- **Programming Language**: Swift
- **SwiftUI**
- **Combine**
- **MVVM with Router**
- **Unit Testing with XCTest**

## Project Structure

Project structure is as follows:

  - MovieDBSwiftUI
  - ContentView
  - SeasonList
      - Model
      - ViewModel
      - View
      - Service
  - SeasonDetail
      - Model
      - ViewModel
      - View
      - Service
  - EpisodeDetail
      - View
      - ViewModel
 - Router
 - Helper
 - Network

- MovieDBSwiftUITests
  - SeasonListViewModelTests
  - MockListSerivce

- Pods
  - Introduced my own framework MDNetworkManager and published it on Cocoapod [MDNetworkManager](https://cocoapods.org/pods/MDNetworkManager)


## Usage

1. Clone the repository: `git clone https://github.com/irfaniOSdev/MovieDBSwiftUI.git`
2. Open the project in Xcode Workspace
3. Run the project

## Improvements

1. Error handling should be improved in the project e.g API failures etc.
2. More unit tests should have been covered
