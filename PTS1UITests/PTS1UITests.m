//
//  PTS1UITests.m
//  PTS1UITests
//
//  Created by Asheesh Agarwal on 11/12/15.
//  Copyright © 2015 Asheesh Agarwal. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface PTS1UITests : XCTestCase

@end

@implementation PTS1UITests

- (void)setUp {
    [super setUp];
    
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    // In UI tests it is usually best to stop immediately when a failure occurs.
    self.continueAfterFailure = NO;
    // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
    [[[XCUIApplication alloc] init] launch];
    
    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

/*- (void)testExample {
    // Use recording to get started writing UI tests.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}*/

- (void)testSuccessfulUserRegistrationAndLogin {
    
    XCUIApplication *app = [[XCUIApplication alloc] init];
    [app.tabBars.buttons[@"Settings"] tap];
    
    XCUIElementQuery *tablesQuery = app.tables;
    [tablesQuery.staticTexts[@"Register"] tap];
    
    XCUIElement *enterYourFirstNameTextField = app.textFields[@"Enter Your First Name"];
    [enterYourFirstNameTextField tap];
    [enterYourFirstNameTextField typeText:@"Asheesh"];
    
    XCUIElement *enterYourLastNameTextField = app.textFields[@"Enter Your Last Name"];
    [enterYourLastNameTextField tap];
    [enterYourLastNameTextField typeText:@"Agarwal"];
    
    XCUIElement *enterYourMobileNumberTextField = app.textFields[@"Enter Your Mobile Number"];
    [enterYourMobileNumberTextField tap];
    [enterYourMobileNumberTextField typeText:@"9177082414"];
    
    XCUIElement *enterYourValidEmailIdTextField = app.textFields[@"Enter Your Valid Email Id"];
    [enterYourValidEmailIdTextField tap];
    [enterYourValidEmailIdTextField typeText:@"test1@gmail.com"];
    
    XCUIElement *chooseAStrongPasswordSecureTextField = app.secureTextFields[@"Choose a Strong Password"];
    [chooseAStrongPasswordSecureTextField tap];
    [chooseAStrongPasswordSecureTextField typeText:@"password"];
    
    XCUIElement *reEnterTheAbovePasswordSecureTextField = app.secureTextFields[@"Re-enter the Above Password"];
    [reEnterTheAbovePasswordSecureTextField tap];
    [reEnterTheAbovePasswordSecureTextField typeText:@"password"];
    [app.scrollViews.buttons[@"Join"] tap];
    
    XCUIElement *logoutStaticText = tablesQuery.staticTexts[@"Logout"];
    [logoutStaticText tap];
    [tablesQuery.staticTexts[@"Login"] tap];
    
    XCUIElement *enterYourEmailIdTextField = app.textFields[@"Enter your Email Id"];
    [enterYourEmailIdTextField tap];
    [enterYourEmailIdTextField typeText:@"test1@gmail.com"];
    
    XCUIElement *enterYourPasswordSecureTextField = app.secureTextFields[@"Enter Your Password"];
    [enterYourPasswordSecureTextField tap];
    [enterYourPasswordSecureTextField typeText:@"password"];
    [app.buttons[@"Login"] tap];
    
    [NSThread sleepForTimeInterval:2];
    [tablesQuery.staticTexts[@"Logout"] tap];
}

- (void)testFailedDuplicateUserRegistration {
    
    XCUIApplication *app = [[XCUIApplication alloc] init];
    [app.tabBars.buttons[@"Settings"] tap];
    
    XCUIElement *registerStaticText = app.tables.staticTexts[@"Register"];
    [registerStaticText tap];
    
    XCUIElement *enterYourFirstNameTextField = app.textFields[@"Enter Your First Name"];
    [enterYourFirstNameTextField tap];
    [enterYourFirstNameTextField typeText:@"Asheesh"];
    
    XCUIElement *enterYourLastNameTextField = app.textFields[@"Enter Your Last Name"];
    [enterYourLastNameTextField tap];
    [enterYourLastNameTextField typeText:@"Agarwal"];
    
    XCUIElement *enterYourMobileNumberTextField = app.textFields[@"Enter Your Mobile Number"];
    [enterYourMobileNumberTextField tap];
    [enterYourMobileNumberTextField typeText:@"9177082414"];
    
    XCUIElement *enterYourValidEmailIdTextField = app.textFields[@"Enter Your Valid Email Id"];
    [enterYourValidEmailIdTextField tap];
    [enterYourValidEmailIdTextField typeText:@"test2@gmail.com"];
    
    XCUIElement *chooseAStrongPasswordSecureTextField = app.secureTextFields[@"Choose a Strong Password"];
    [chooseAStrongPasswordSecureTextField tap];
    [chooseAStrongPasswordSecureTextField typeText:@"password"];
    
    XCUIElement *reEnterTheAbovePasswordSecureTextField = app.secureTextFields[@"Re-enter the Above Password"];
    [reEnterTheAbovePasswordSecureTextField tap];
    [reEnterTheAbovePasswordSecureTextField typeText:@"password"];
    
    XCUIElement *joinButton = app.scrollViews.buttons[@"Join"];
    [joinButton tap];
    
    XCUIApplication *app2 = app;
    [app2.tables.staticTexts[@"Logout"] tap];
    [registerStaticText tap];
    [enterYourFirstNameTextField tap];
    [enterYourFirstNameTextField typeText:@"Asheesh"];
    [enterYourLastNameTextField tap];
    [enterYourLastNameTextField typeText:@"Agarwal"];
    [enterYourMobileNumberTextField tap];
    [enterYourMobileNumberTextField typeText:@"9177082414"];
    [enterYourValidEmailIdTextField tap];
    [enterYourValidEmailIdTextField typeText:@"test2@gmail.com"];
    [chooseAStrongPasswordSecureTextField tap];
    [chooseAStrongPasswordSecureTextField typeText:@"password"];
    [reEnterTheAbovePasswordSecureTextField tap];
    [reEnterTheAbovePasswordSecureTextField typeText:@"password"];
    [joinButton tap];
    [reEnterTheAbovePasswordSecureTextField tap];
    //[app.alerts[@"Error Message"].collectionViews.buttons[@"Dismiss"] tap];
    [app2.buttons[@"Cancel"] tap];
}

- (void)testFailedUserLoginWithWrongEmailId {
    
    XCUIApplication *app = [[XCUIApplication alloc] init];
    [app.tabBars.buttons[@"Settings"] tap];
    
    XCUIElementQuery *tablesQuery = app.tables;
    [tablesQuery.staticTexts[@"Register"] tap];
    
    XCUIElement *enterYourFirstNameTextField = app.textFields[@"Enter Your First Name"];
    [enterYourFirstNameTextField tap];
    [enterYourFirstNameTextField typeText:@"Asheesh"];
    
    XCUIElement *enterYourLastNameTextField = app.textFields[@"Enter Your Last Name"];
    [enterYourLastNameTextField tap];
    [enterYourLastNameTextField typeText:@"Agarwal"];
    
    XCUIElement *enterYourMobileNumberTextField = app.textFields[@"Enter Your Mobile Number"];
    [enterYourMobileNumberTextField tap];
    [enterYourMobileNumberTextField typeText:@"9177082414"];
    
    XCUIElement *enterYourValidEmailIdTextField = app.textFields[@"Enter Your Valid Email Id"];
    [enterYourValidEmailIdTextField tap];
    [enterYourValidEmailIdTextField typeText:@"test3@gmail.com"];
    
    XCUIElement *chooseAStrongPasswordSecureTextField = app.secureTextFields[@"Choose a Strong Password"];
    [chooseAStrongPasswordSecureTextField tap];
    [chooseAStrongPasswordSecureTextField typeText:@"password"];
    
    XCUIElement *reEnterTheAbovePasswordSecureTextField = app.secureTextFields[@"Re-enter the Above Password"];
    [reEnterTheAbovePasswordSecureTextField tap];
    [reEnterTheAbovePasswordSecureTextField typeText:@"password"];
    [app.scrollViews.buttons[@"Join"] tap];
    [tablesQuery.staticTexts[@"Logout"] tap];
    [tablesQuery.staticTexts[@"Login"] tap];
    
    XCUIElement *enterYourEmailIdTextField = app.textFields[@"Enter your Email Id"];
    [enterYourEmailIdTextField tap];
    [enterYourEmailIdTextField typeText:@"test3@gm.com"];
    
    XCUIElement *enterYourPasswordSecureTextField = app.secureTextFields[@"Enter Your Password"];
    [enterYourPasswordSecureTextField tap];
    [enterYourPasswordSecureTextField typeText:@"password"];
    [app.buttons[@"Login"] tap];
    [enterYourPasswordSecureTextField tap];
    //[app.alerts[@"Error Message"].collectionViews.buttons[@"Dismiss"] tap];
    [app.buttons[@"Cancel"] tap];
}

- (void)testFailedUserLoginWithWrongPassword {
    
    XCUIApplication *app = [[XCUIApplication alloc] init];
    [app.tabBars.buttons[@"Settings"] tap];
    
    XCUIElementQuery *tablesQuery = app.tables;
    [tablesQuery.staticTexts[@"Register"] tap];
    
    XCUIElement *enterYourFirstNameTextField = app.textFields[@"Enter Your First Name"];
    [enterYourFirstNameTextField tap];
    [enterYourFirstNameTextField typeText:@"Asheesh"];
    
    XCUIElement *enterYourLastNameTextField = app.textFields[@"Enter Your Last Name"];
    [enterYourLastNameTextField tap];
    [enterYourLastNameTextField typeText:@"Agarwal"];
    
    XCUIElement *enterYourMobileNumberTextField = app.textFields[@"Enter Your Mobile Number"];
    [enterYourMobileNumberTextField tap];
    [enterYourMobileNumberTextField tap];
    [enterYourMobileNumberTextField typeText:@"9177082414"];
    
    XCUIElement *enterYourValidEmailIdTextField = app.textFields[@"Enter Your Valid Email Id"];
    [enterYourValidEmailIdTextField tap];
    [enterYourValidEmailIdTextField tap];
    [enterYourValidEmailIdTextField typeText:@"test4@gmail.com"];
    
    XCUIElement *chooseAStrongPasswordSecureTextField = app.secureTextFields[@"Choose a Strong Password"];
    [chooseAStrongPasswordSecureTextField tap];
    [chooseAStrongPasswordSecureTextField typeText:@"password"];
    
    XCUIElement *reEnterTheAbovePasswordSecureTextField = app.secureTextFields[@"Re-enter the Above Password"];
    [reEnterTheAbovePasswordSecureTextField tap];
    [reEnterTheAbovePasswordSecureTextField typeText:@"password"];
    [app.scrollViews.buttons[@"Join"] tap];
    [tablesQuery.staticTexts[@"Logout"] tap];
    [tablesQuery.staticTexts[@"Login"] tap];
    
    XCUIElement *enterYourEmailIdTextField = app.textFields[@"Enter your Email Id"];
    [enterYourEmailIdTextField tap];
    [enterYourEmailIdTextField typeText:@"test4@gmail.com"];
    
    XCUIElement *enterYourPasswordSecureTextField = app.secureTextFields[@"Enter Your Password"];
    [enterYourPasswordSecureTextField tap];
    [enterYourPasswordSecureTextField typeText:@"pass"];
    [app.buttons[@"Login"] tap];
    [enterYourPasswordSecureTextField tap];
    //[app.alerts[@"Error Message"].collectionViews.buttons[@"Dismiss"] tap];
    [app.buttons[@"Cancel"] tap];
}

- (void)testAddMyTool {
    
    XCUIApplication *app = [[XCUIApplication alloc] init];
    XCUIElementQuery *tabBarsQuery = app.tabBars;
    XCUIElement *settingsButton = tabBarsQuery.buttons[@"Settings"];
    [settingsButton tap];
    
    XCUIElementQuery *tablesQuery = app.tables;
    [tablesQuery.staticTexts[@"Register"] tap];
    
    XCUIElement *enterYourFirstNameTextField = app.textFields[@"Enter Your First Name"];
    [enterYourFirstNameTextField tap];
    [enterYourFirstNameTextField typeText:@"Asheesh"];
    
    XCUIElement *enterYourLastNameTextField = app.textFields[@"Enter Your Last Name"];
    [enterYourLastNameTextField tap];
    [enterYourLastNameTextField typeText:@"Agarwal"];
    
    XCUIElement *enterYourMobileNumberTextField = app.textFields[@"Enter Your Mobile Number"];
    [enterYourMobileNumberTextField tap];
    [enterYourMobileNumberTextField typeText:@"9177082414"];
    
    XCUIElement *enterYourValidEmailIdTextField = app.textFields[@"Enter Your Valid Email Id"];
    [enterYourValidEmailIdTextField tap];
    [enterYourValidEmailIdTextField typeText:@"test5@gmail.com"];
    
    XCUIElement *chooseAStrongPasswordSecureTextField = app.secureTextFields[@"Choose a Strong Password"];
    [chooseAStrongPasswordSecureTextField tap];
    [chooseAStrongPasswordSecureTextField typeText:@"password"];
    
    XCUIElement *reEnterTheAbovePasswordSecureTextField = app.secureTextFields[@"Re-enter the Above Password"];
    [reEnterTheAbovePasswordSecureTextField tap];
    [reEnterTheAbovePasswordSecureTextField typeText:@"password"];
    [app.scrollViews.buttons[@"Join"] tap];
    [tabBarsQuery.buttons[@"My Tools"] tap];
    
    XCUIElement *myToolsNavigationBar = app.navigationBars[@"My Tools"];
    [myToolsNavigationBar.buttons[@"Add"] tap];
    [[[[[[app childrenMatchingType:XCUIElementTypeWindow] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:2] childrenMatchingType:XCUIElementTypeOther].element tap];
    [app.sheets.collectionViews.buttons[@"Choose Photo"] tap];
    [tablesQuery.buttons[@"Camera Roll"] tap];
    [app.collectionViews.cells[@"Photo, Landscape, March 12, 2011, 7:17 PM"] tap];
    [app.textFields[@"Enter Tool Name"] typeText:@"First Tool"];
    [app.navigationBars[@"Add Tool"].buttons[@"Done"] tap];
    [myToolsNavigationBar.buttons[@"Refresh"] tap];
    [tablesQuery.staticTexts[@"First Tool"] tap];
    [app.navigationBars[@"MyToolDetailsView"].buttons[@"My Tools"] tap];
    [settingsButton tap];
    [tablesQuery.staticTexts[@"Logout"] tap];
}

- (void)testRemoveMyTool {
    
    XCUIApplication *app2 = [[XCUIApplication alloc] init];
    XCUIElement *settingsButton = app2.tabBars.buttons[@"Settings"];
    [settingsButton tap];
    
    XCUIElementQuery *tablesQuery = app2.tables;
    [tablesQuery.staticTexts[@"Register"] tap];
    
    XCUIElement *enterYourFirstNameTextField = app2.textFields[@"Enter Your First Name"];
    [enterYourFirstNameTextField tap];
    [enterYourFirstNameTextField typeText:@"Asheesh"];
    
    XCUIElement *enterYourLastNameTextField = app2.textFields[@"Enter Your Last Name"];
    [enterYourLastNameTextField tap];
    [enterYourLastNameTextField typeText:@"Agarwal"];
    
    XCUIElement *enterYourMobileNumberTextField = app2.textFields[@"Enter Your Mobile Number"];
    [enterYourMobileNumberTextField tap];
    [enterYourMobileNumberTextField typeText:@"9177082414"];
    
    XCUIElement *enterYourValidEmailIdTextField = app2.textFields[@"Enter Your Valid Email Id"];
    [enterYourValidEmailIdTextField tap];
    [enterYourValidEmailIdTextField typeText:@"test6@gmail.com"];
    
    XCUIElement *chooseAStrongPasswordSecureTextField = app2.secureTextFields[@"Choose a Strong Password"];
    [chooseAStrongPasswordSecureTextField tap];
    [chooseAStrongPasswordSecureTextField typeText:@"password"];
    
    XCUIElement *reEnterTheAbovePasswordSecureTextField = app2.secureTextFields[@"Re-enter the Above Password"];
    [reEnterTheAbovePasswordSecureTextField tap];
    [reEnterTheAbovePasswordSecureTextField typeText:@"password"];
    
    XCUIApplication *app = app2;
    [app.scrollViews.buttons[@"Join"] tap];
    
    XCUIElement *myToolsButton = app.tabBars.buttons[@"My Tools"];
    [myToolsButton tap];
    
    XCUIElement *myToolsNavigationBar = app.navigationBars[@"My Tools"];
    [myToolsNavigationBar.buttons[@"Add"] tap];
    [[[[[[app childrenMatchingType:XCUIElementTypeWindow] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:2] childrenMatchingType:XCUIElementTypeOther].element tap];
    [app.sheets.collectionViews.buttons[@"Choose Photo"] tap];
    [tablesQuery.buttons[@"Camera Roll"] tap];
    [app.collectionViews.cells[@"Photo, Landscape, March 12, 2011, 4:17 PM"] tap];
    [app2.textFields[@"Enter Tool Name"] typeText:@"Tool Added For Removal"];
    [app.navigationBars[@"Add Tool"].buttons[@"Done"] tap];
    [myToolsNavigationBar.buttons[@"Refresh"] tap];
    [tablesQuery.staticTexts[@"Tool Added For Removal"] tap];
    [app.navigationBars[@"MyToolDetailsView"].buttons[@"My Tools"] tap];
    [settingsButton tap];
    
    XCUIElement *logoutStaticText = tablesQuery.staticTexts[@"Logout"];
    [logoutStaticText tap];
    [tablesQuery.staticTexts[@"Login"] tap];
    
    XCUIElement *enterYourEmailIdTextField = app.textFields[@"Enter your Email Id"];
    [enterYourEmailIdTextField tap];
    [enterYourEmailIdTextField typeText:@"test6@gmail.com"];
    
    XCUIElement *enterYourPasswordSecureTextField = app.secureTextFields[@"Enter Your Password"];
    [enterYourPasswordSecureTextField tap];
    [enterYourPasswordSecureTextField typeText:@"password"];
    [app.buttons[@"Login"] tap];
    [myToolsButton tap];
    [tablesQuery.staticTexts[@"Tool Added For Removal"] tap];
    [app2.buttons[@"Delete Tool"] tap];
    
    [NSThread sleepForTimeInterval:2];
    
    [app.buttons[@"Cancel"] tap];
    [logoutStaticText tap];
}

- (void)testChangeMyToolStatus {
    
    XCUIApplication *app2 = [[XCUIApplication alloc] init];
    XCUIElement *settingsButton = app2.tabBars.buttons[@"Settings"];
    [settingsButton tap];
    
    XCUIElementQuery *tablesQuery = app2.tables;
    [tablesQuery.staticTexts[@"Register"] tap];
    
    XCUIElement *enterYourFirstNameTextField = app2.textFields[@"Enter Your First Name"];
    [enterYourFirstNameTextField tap];
    [enterYourFirstNameTextField typeText:@"Asheesh"];
    
    XCUIElement *enterYourLastNameTextField = app2.textFields[@"Enter Your Last Name"];
    [enterYourLastNameTextField tap];
    [enterYourLastNameTextField typeText:@"Agarwal"];
    
    XCUIElement *enterYourMobileNumberTextField = app2.textFields[@"Enter Your Mobile Number"];
    [enterYourMobileNumberTextField tap];
    [enterYourMobileNumberTextField typeText:@"9177082414"];
    
    XCUIElement *enterYourValidEmailIdTextField = app2.textFields[@"Enter Your Valid Email Id"];
    [enterYourValidEmailIdTextField tap];
    [enterYourValidEmailIdTextField typeText:@"test7@gmail.com"];
    
    XCUIElement *chooseAStrongPasswordSecureTextField = app2.secureTextFields[@"Choose a Strong Password"];
    [chooseAStrongPasswordSecureTextField tap];
    [chooseAStrongPasswordSecureTextField typeText:@"password"];
    
    XCUIElement *reEnterTheAbovePasswordSecureTextField = app2.secureTextFields[@"Re-enter the Above Password"];
    [reEnterTheAbovePasswordSecureTextField tap];
    [reEnterTheAbovePasswordSecureTextField typeText:@"password"];
    
    XCUIApplication *app = app2;
    [app.scrollViews.buttons[@"Join"] tap];
    [[app.tables containingType:XCUIElementTypeOther identifier:@"SETTINGS"].element tap];
    [app.tabBars.buttons[@"My Tools"] tap];
    
    XCUIElement *myToolsNavigationBar = app.navigationBars[@"My Tools"];
    [myToolsNavigationBar.buttons[@"Add"] tap];
    [[[[[[app childrenMatchingType:XCUIElementTypeWindow] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:2] childrenMatchingType:XCUIElementTypeOther].element tap];
    [app.sheets.collectionViews.buttons[@"Choose Photo"] tap];
    [tablesQuery.buttons[@"Camera Roll"] tap];
    [app.collectionViews.cells[@"Photo, Landscape, August 08, 2012, 2:55 PM"] tap];
    [app2.textFields[@"Enter Tool Name"] typeText:@"Tool Added For Status Change"];
    [app.navigationBars[@"Add Tool"].buttons[@"Done"] tap];
    [myToolsNavigationBar.buttons[@"Refresh"] tap];
    [tablesQuery.staticTexts[@"Tool Added For Status Change"] tap];
    [app2.buttons[@"Mark as Unavailable"] tap];
    [NSThread sleepForTimeInterval:2];
    
    [app.navigationBars[@"MyToolDetailsView"].buttons[@"My Tools"] tap];
    [tablesQuery.staticTexts[@"Unavailable"] tap];
    [app2.buttons[@"Mark as Available"] tap];
    [NSThread sleepForTimeInterval:2];
    
    [settingsButton tap];
    [tablesQuery.staticTexts[@"Logout"] tap];
}

- (void)testViewPublicTools {
    
    XCUIApplication *app = [[XCUIApplication alloc] init];
    XCUIElementQuery *tabBarsQuery = app.tabBars;
    XCUIElement *settingsButton = tabBarsQuery.buttons[@"Settings"];
    [settingsButton tap];
    
    XCUIElementQuery *tablesQuery2 = app.tables;
    XCUIElement *registerStaticText = tablesQuery2.staticTexts[@"Register"];
    [registerStaticText tap];
    
    XCUIElement *enterYourFirstNameTextField = app.textFields[@"Enter Your First Name"];
    [enterYourFirstNameTextField tap];
    [enterYourFirstNameTextField tap];
    [enterYourFirstNameTextField typeText:@"Asheesh"];
    
    XCUIElement *enterYourLastNameTextField = app.textFields[@"Enter Your Last Name"];
    [enterYourLastNameTextField tap];
    [enterYourLastNameTextField typeText:@"Agarwal"];
    
    XCUIElement *enterYourMobileNumberTextField = app.textFields[@"Enter Your Mobile Number"];
    [enterYourMobileNumberTextField tap];
    [enterYourMobileNumberTextField typeText:@"9177082414"];
    
    XCUIElement *enterYourValidEmailIdTextField = app.textFields[@"Enter Your Valid Email Id"];
    [enterYourValidEmailIdTextField tap];
    [enterYourValidEmailIdTextField typeText:@"test8@gmail.com"];
    
    XCUIElement *chooseAStrongPasswordSecureTextField = app.secureTextFields[@"Choose a Strong Password"];
    [chooseAStrongPasswordSecureTextField tap];
    [chooseAStrongPasswordSecureTextField typeText:@"password"];
    
    XCUIElement *reEnterTheAbovePasswordSecureTextField = app.secureTextFields[@"Re-enter the Above Password"];
    [reEnterTheAbovePasswordSecureTextField tap];
    [reEnterTheAbovePasswordSecureTextField typeText:@"password"];
    
    XCUIElement *joinButton = app.scrollViews.buttons[@"Join"];
    [joinButton tap];
    [tabBarsQuery.buttons[@"My Tools"] tap];
    
    XCUIElement *myToolsNavigationBar = app.navigationBars[@"My Tools"];
    [myToolsNavigationBar.buttons[@"Add"] tap];
    [[[[[[app childrenMatchingType:XCUIElementTypeWindow] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:2] childrenMatchingType:XCUIElementTypeOther].element tap];
    [app.sheets.collectionViews.buttons[@"Choose Photo"] tap];
    
    XCUIElementQuery *tablesQuery = tablesQuery2;
    [tablesQuery.buttons[@"Camera Roll"] tap];
    [app.collectionViews.cells[@"Photo, Landscape, August 08, 2012, 11:52 AM"] tap];
    [app.textFields[@"Enter Tool Name"] typeText:@"Test8 Tool Added"];
    [app.navigationBars[@"Add Tool"].buttons[@"Done"] tap];
    [myToolsNavigationBar.buttons[@"Refresh"] tap];
    [settingsButton tap];
    
    XCUIElement *logoutStaticText = tablesQuery.staticTexts[@"Logout"];
    [logoutStaticText tap];
    [registerStaticText tap];
    [enterYourFirstNameTextField tap];
    [enterYourFirstNameTextField typeText:@"Asheesh"];
    [enterYourLastNameTextField tap];
    [enterYourLastNameTextField typeText:@"Agarwal"];
    [enterYourMobileNumberTextField tap];
    [enterYourMobileNumberTextField typeText:@"9177082414"];
    [enterYourValidEmailIdTextField tap];
    [enterYourValidEmailIdTextField typeText:@"test9@gmail.com"];
    [chooseAStrongPasswordSecureTextField tap];
    [chooseAStrongPasswordSecureTextField typeText:@"password"];
    [reEnterTheAbovePasswordSecureTextField tap];
    [reEnterTheAbovePasswordSecureTextField typeText:@"password"];
    [joinButton tap];
    [tabBarsQuery.buttons[@"Public Tools"] tap];
    [tablesQuery.staticTexts[@"Test8 Tool Added"] tap];
    [app.navigationBars[@"Tool Details"].buttons[@"Public Tools"] tap];
    [settingsButton tap];
    [logoutStaticText tap];
    
}


@end
