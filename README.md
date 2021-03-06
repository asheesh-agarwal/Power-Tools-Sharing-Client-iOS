# Power-Tools-Sharing-Client-iOS

![Power Tool Sharing App](PTS1/Assets.xcassets/AppIcon.appiconset/pts@3x.png)

Contains the iOS source code for Power Tools Sharing application.

### Background

Every building, every neighborhood, has people passionate about owning every power tool imaginable. 
These are expensive and almost never used. They should be shared.

### Challenge

Part of the reason why nobody is winning in this space is because of for-profit nature of these applications, 
which bound to lend these items for money. Instead, build a non-for-profit sharing economy where 
individuals are just sharing without asking anything in return, around power tools, an app, site, etc.

### Current Status

Currently the client application is only supported on iOS devices. The mobile application currently allows user
to do following things:
* View Public Tools (No need of registration or login)
* View My Tools (registration or login required)
* Upload New Tools (registration or login required)
* Mark tool as "Unavailable" or "Available" (registration or login required)
* Register New Account
* Login to Existing Account

Mobile application calls the RESTful APIs exposed by server for all remote communication.

### Whats Next
This project currently has no backlog.

### Technologies Used

* Objective-c - Development language for developing iOS application
* XCode 7.1 - IDE for iOS application development
* iOS Simulator - Application used for quickly testing iOS application before running on actual device
* iPhone 5S - Used as base device for developer level testing before releasing to others

### Project Management
* [Project Dashboard](https://waffle.io/asheesh-agarwal/Power-Tools-Sharing) - This dashboard is current out-of-sync with the current state of this repository due to some technical issues in Waffle. I will look into this and will update this section later.

### iOS Application Download Link
* [PTS1.app](https://github.com/asheesh-agarwal/Power-Tools-Sharing-Client-iOS)

To download and install the "Power Tool Sharing" application your iPhone, follow below steps:
* Download PTS1.app package on your Mac machine. (PTS1.app seems like folder structure but this is the default way of working with iOS applications. XCode generates the .app files which are in itself the application folder containing all the installables.)
* Open iTunes and select "Apps" on the left side bar or on the menu bar near the Play button.
* Now drag the PTS1.app and drop it on the "Apps" window. Now you should see the PTS1 application visible along side with your other iOS applications.
* Install the PTS1 application as you would install anyother iOS application on your iPhone

(Note: As PTS1 application is not signed by Apple Developer Account, it will not be installed on your iPhone)

