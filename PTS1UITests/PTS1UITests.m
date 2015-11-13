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
    [app.tables.staticTexts[@"Register"] tap];
    
    XCUIElement *enterYourFirstNameTextField = app.textFields[@"Enter Your First Name"];
    [enterYourFirstNameTextField tap];
    [enterYourFirstNameTextField typeText:@"Asheesh"];
    
    XCUIElement *enterYourLastNameTextField = app.textFields[@"Enter Your Last Name"];
    [enterYourLastNameTextField tap];
    [enterYourLastNameTextField typeText:@"Agarwal"];
    
    XCUIElement *enterYourValidEmailIdTextField = app.textFields[@"Enter Your Valid Email Id"];
    [enterYourValidEmailIdTextField tap];
    [enterYourValidEmailIdTextField typeText:@"test@test.com"];
    
    XCUIElement *chooseAStrongPasswordSecureTextField = app.secureTextFields[@"Choose a Strong Password"];
    [chooseAStrongPasswordSecureTextField tap];
    [chooseAStrongPasswordSecureTextField typeText:@"password"];
    
    XCUIElement *reEnterTheAbovePasswordSecureTextField = app.secureTextFields[@"Re-enter the Above Password"];
    [reEnterTheAbovePasswordSecureTextField tap];
    [reEnterTheAbovePasswordSecureTextField typeText:@"password"];
    [[[app childrenMatchingType:XCUIElementTypeWindow] elementBoundByIndex:0].buttons[@"Join"] tap];
    
    [app.tables.staticTexts[@"Logout"] tap];
    
    XCUIElementQuery *tablesQuery = app.tables;
    [tablesQuery.staticTexts[@"Login"] tap];
    
    XCUIElement *enterYourEmailIdTextField = app.textFields[@"Enter your Email Id"];
    [enterYourEmailIdTextField tap];
    [enterYourEmailIdTextField typeText:@"test@test.com"];
    
    XCUIElement *enterYourPasswordSecureTextField = app.secureTextFields[@"Enter Your Password"];
    [enterYourPasswordSecureTextField tap];
    [enterYourPasswordSecureTextField typeText:@"password"];
    [app.buttons[@"Login"] tap];
    
    [tablesQuery.staticTexts[@"Logout"] tap];
}

- (void)testFailedDuplicateUserRegistration {
    
    XCUIApplication *app = [[XCUIApplication alloc] init];
    [app.tabBars.buttons[@"Settings"] tap];
    [app.tables.staticTexts[@"Register"] tap];
    
    XCUIElement *enterYourFirstNameTextField = app.textFields[@"Enter Your First Name"];
    [enterYourFirstNameTextField tap];
    [enterYourFirstNameTextField typeText:@"Asheesh"];
    
    XCUIElement *enterYourLastNameTextField = app.textFields[@"Enter Your Last Name"];
    [enterYourLastNameTextField tap];
    [enterYourLastNameTextField typeText:@"Agarwal"];
    
    XCUIElement *enterYourValidEmailIdTextField = app.textFields[@"Enter Your Valid Email Id"];
    [enterYourValidEmailIdTextField tap];
    [enterYourValidEmailIdTextField typeText:@"test1@test1.com"];
    
    XCUIElement *chooseAStrongPasswordSecureTextField = app.secureTextFields[@"Choose a Strong Password"];
    [chooseAStrongPasswordSecureTextField tap];
    [chooseAStrongPasswordSecureTextField typeText:@"password"];
    
    XCUIElement *reEnterTheAbovePasswordSecureTextField = app.secureTextFields[@"Re-enter the Above Password"];
    [reEnterTheAbovePasswordSecureTextField tap];
    [reEnterTheAbovePasswordSecureTextField typeText:@"password"];
    [[[app childrenMatchingType:XCUIElementTypeWindow] elementBoundByIndex:0].buttons[@"Join"] tap];
    
    [app.tables.staticTexts[@"Logout"] tap];
    [app.tables.staticTexts[@"Register"] tap];
    
    enterYourFirstNameTextField = app.textFields[@"Enter Your First Name"];
    [enterYourFirstNameTextField tap];
    [enterYourFirstNameTextField typeText:@"Rahul"];
    
    enterYourLastNameTextField = app.textFields[@"Enter Your Last Name"];
    [enterYourLastNameTextField tap];
    [enterYourLastNameTextField tap];
    [enterYourLastNameTextField typeText:@"Kumar"];
    
    enterYourValidEmailIdTextField = app.textFields[@"Enter Your Valid Email Id"];
    [enterYourValidEmailIdTextField tap];
    [enterYourValidEmailIdTextField typeText:@"test1@test1.com"];
    
    chooseAStrongPasswordSecureTextField = app.secureTextFields[@"Choose a Strong Password"];
    [chooseAStrongPasswordSecureTextField tap];
    [chooseAStrongPasswordSecureTextField typeText:@"password"];
    
    reEnterTheAbovePasswordSecureTextField = app.secureTextFields[@"Re-enter the Above Password"];
    [reEnterTheAbovePasswordSecureTextField tap];
    [reEnterTheAbovePasswordSecureTextField typeText:@"password"];
    [[[app childrenMatchingType:XCUIElementTypeWindow] elementBoundByIndex:0].buttons[@"Join"] tap];
    [reEnterTheAbovePasswordSecureTextField tap];
    
    [app.buttons[@"Cancel"] tap];
}

- (void)testFailedUserLoginWithWrongEmailId {
    
    XCUIApplication *app = [[XCUIApplication alloc] init];
    [app.tabBars.buttons[@"Settings"] tap];
    [app.tables.staticTexts[@"Register"] tap];
    
    XCUIElement *enterYourFirstNameTextField = app.textFields[@"Enter Your First Name"];
    [enterYourFirstNameTextField tap];
    [enterYourFirstNameTextField typeText:@"Asheesh"];
    
    XCUIElement *enterYourLastNameTextField = app.textFields[@"Enter Your Last Name"];
    [enterYourLastNameTextField tap];
    [enterYourLastNameTextField typeText:@"Agarwal"];
    
    XCUIElement *enterYourValidEmailIdTextField = app.textFields[@"Enter Your Valid Email Id"];
    [enterYourValidEmailIdTextField tap];
    [enterYourValidEmailIdTextField typeText:@"test2@test2.com"];
    
    XCUIElement *chooseAStrongPasswordSecureTextField = app.secureTextFields[@"Choose a Strong Password"];
    [chooseAStrongPasswordSecureTextField tap];
    [chooseAStrongPasswordSecureTextField typeText:@"password"];
    
    XCUIElement *reEnterTheAbovePasswordSecureTextField = app.secureTextFields[@"Re-enter the Above Password"];
    [reEnterTheAbovePasswordSecureTextField tap];
    [reEnterTheAbovePasswordSecureTextField typeText:@"password"];
    [[[app childrenMatchingType:XCUIElementTypeWindow] elementBoundByIndex:0].buttons[@"Join"] tap];
    
    [app.tables.staticTexts[@"Logout"] tap];
    [app.tables.staticTexts[@"Login"] tap];
    
    XCUIElement *enterYourEmailIdTextField = app.textFields[@"Enter your Email Id"];
    [enterYourEmailIdTextField tap];
    [enterYourEmailIdTextField typeText:@"test@test2.com"];
    
    XCUIElement *enterYourPasswordSecureTextField = app.secureTextFields[@"Enter Your Password"];
    [enterYourPasswordSecureTextField tap];
    [enterYourPasswordSecureTextField typeText:@"password"];
    [app.buttons[@"Login"] tap];
    [enterYourPasswordSecureTextField tap];

    [app.buttons[@"Cancel"] tap];
}

- (void)testFailedUserLoginWithWrongPassword {
    
    XCUIApplication *app = [[XCUIApplication alloc] init];
    [app.tabBars.buttons[@"Settings"] tap];
    [app.tables.staticTexts[@"Register"] tap];
    
    XCUIElement *enterYourFirstNameTextField = app.textFields[@"Enter Your First Name"];
    [enterYourFirstNameTextField tap];
    [enterYourFirstNameTextField typeText:@"Asheesh"];
    
    XCUIElement *enterYourLastNameTextField = app.textFields[@"Enter Your Last Name"];
    [enterYourLastNameTextField tap];
    [enterYourLastNameTextField typeText:@"Agarwal"];
    
    XCUIElement *enterYourValidEmailIdTextField = app.textFields[@"Enter Your Valid Email Id"];
    [enterYourValidEmailIdTextField tap];
    [enterYourValidEmailIdTextField typeText:@"test3@test3.com"];
    
    XCUIElement *chooseAStrongPasswordSecureTextField = app.secureTextFields[@"Choose a Strong Password"];
    [chooseAStrongPasswordSecureTextField tap];
    [chooseAStrongPasswordSecureTextField typeText:@"password"];
    
    XCUIElement *reEnterTheAbovePasswordSecureTextField = app.secureTextFields[@"Re-enter the Above Password"];
    [reEnterTheAbovePasswordSecureTextField tap];
    [reEnterTheAbovePasswordSecureTextField typeText:@"password"];
    [[[app childrenMatchingType:XCUIElementTypeWindow] elementBoundByIndex:0].buttons[@"Join"] tap];
    
    [app.tables.staticTexts[@"Logout"] tap];
    [app.tables.staticTexts[@"Login"] tap];
    
    XCUIElement *enterYourEmailIdTextField = app.textFields[@"Enter your Email Id"];
    [enterYourEmailIdTextField tap];
    [enterYourEmailIdTextField typeText:@"test3@test3.com"];
    
    XCUIElement *enterYourPasswordSecureTextField = app.secureTextFields[@"Enter Your Password"];
    [enterYourPasswordSecureTextField tap];
    [enterYourPasswordSecureTextField typeText:@"pass"];
    [app.buttons[@"Login"] tap];
    [enterYourPasswordSecureTextField tap];
    
    [app.buttons[@"Cancel"] tap];
}

- (void)testAddMyTool {
    
    XCUIApplication *app = [[XCUIApplication alloc] init];
    [app.tabBars.buttons[@"Settings"] tap];
    [app.tables.staticTexts[@"Register"] tap];
    
    XCUIElement *enterYourFirstNameTextField = app.textFields[@"Enter Your First Name"];
    [enterYourFirstNameTextField tap];
    [enterYourFirstNameTextField typeText:@"Asheesh"];
    
    XCUIElement *enterYourLastNameTextField = app.textFields[@"Enter Your Last Name"];
    [enterYourLastNameTextField tap];
    [enterYourLastNameTextField typeText:@"Agarwal"];
    
    XCUIElement *enterYourValidEmailIdTextField = app.textFields[@"Enter Your Valid Email Id"];
    [enterYourValidEmailIdTextField tap];
    [enterYourValidEmailIdTextField typeText:@"test4@test4.com"];
    
    XCUIElement *chooseAStrongPasswordSecureTextField = app.secureTextFields[@"Choose a Strong Password"];
    [chooseAStrongPasswordSecureTextField tap];
    [chooseAStrongPasswordSecureTextField typeText:@"password"];
    
    XCUIElement *reEnterTheAbovePasswordSecureTextField = app.secureTextFields[@"Re-enter the Above Password"];
    [reEnterTheAbovePasswordSecureTextField tap];
    [reEnterTheAbovePasswordSecureTextField typeText:@"password"];
    [[[app childrenMatchingType:XCUIElementTypeWindow] elementBoundByIndex:0].buttons[@"Join"] tap];
    
    [app.tables.staticTexts[@"Logout"] tap];
    
    XCUIElementQuery *tabBarsQuery = app.tabBars;
    XCUIElement *myToolsButton = tabBarsQuery.buttons[@"My Tools"];
    [myToolsButton tap];
    
    XCUIElement *myToolsNavigationBar = app.navigationBars[@"My Tools"];
    XCUIElement *addButton = myToolsNavigationBar.buttons[@"Add"];
    [addButton tap];
    [app.alerts[@"Error Message"].collectionViews.buttons[@"Dismiss"] tap];
    [tabBarsQuery.buttons[@"Settings"] tap];
    
    XCUIElementQuery *tablesQuery = app.tables;
    [tablesQuery.staticTexts[@"Login"] tap];
    
    XCUIElement *enterYourEmailIdTextField = app.textFields[@"Enter your Email Id"];
    [enterYourEmailIdTextField tap];
    [enterYourEmailIdTextField typeText:@"test4@test4.com"];
    
    XCUIElement *enterYourPasswordSecureTextField = app.secureTextFields[@"Enter Your Password"];
    [enterYourPasswordSecureTextField tap];
    [enterYourPasswordSecureTextField typeText:@"password"];
    [app.buttons[@"Login"] tap];
    [myToolsButton tap];
    [addButton tap];
    
    [[[[[app childrenMatchingType:XCUIElementTypeWindow] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeOther].element tap];
    
    [app.sheets.collectionViews.buttons[@"Choose Photo"] tap];
    //[app.alerts[@"PTS1 Would Like to Access Your Photos"].collectionViews.buttons[@"OK"] tap];
    [tablesQuery.buttons[@"Camera Roll"] tap];
    [app.collectionViews.cells[@"Photo, Landscape, August 08, 2012, 2:55 PM"] tap];
    
    XCUIElement *enterToolNameTextField = app.textFields[@"Enter Tool Name"];
    [enterToolNameTextField tap];
    [enterToolNameTextField typeText:@"First Tool"];
    [app.navigationBars[@"Add Tool"].buttons[@"Done"] tap];
    [myToolsNavigationBar.buttons[@"Refresh"] tap];
    
    [tabBarsQuery.buttons[@"Settings"] tap];
    [tablesQuery.staticTexts[@"Logout"] tap];
}

- (void)testRemoveMyTool {
    
    XCUIApplication *app = [[XCUIApplication alloc] init];
    [app.tabBars.buttons[@"Settings"] tap];
    [app.tables.staticTexts[@"Register"] tap];
    
    XCUIElement *enterYourFirstNameTextField = app.textFields[@"Enter Your First Name"];
    [enterYourFirstNameTextField tap];
    [enterYourFirstNameTextField typeText:@"Asheesh"];
    
    XCUIElement *enterYourLastNameTextField = app.textFields[@"Enter Your Last Name"];
    [enterYourLastNameTextField tap];
    [enterYourLastNameTextField typeText:@"Agarwal"];
    
    XCUIElement *enterYourValidEmailIdTextField = app.textFields[@"Enter Your Valid Email Id"];
    [enterYourValidEmailIdTextField tap];
    [enterYourValidEmailIdTextField typeText:@"test5@test5.com"];
    
    XCUIElement *chooseAStrongPasswordSecureTextField = app.secureTextFields[@"Choose a Strong Password"];
    [chooseAStrongPasswordSecureTextField tap];
    [chooseAStrongPasswordSecureTextField typeText:@"password"];
    
    XCUIElement *reEnterTheAbovePasswordSecureTextField = app.secureTextFields[@"Re-enter the Above Password"];
    [reEnterTheAbovePasswordSecureTextField tap];
    [reEnterTheAbovePasswordSecureTextField typeText:@"password"];
    [[[app childrenMatchingType:XCUIElementTypeWindow] elementBoundByIndex:0].buttons[@"Join"] tap];
    
    [app.tables.staticTexts[@"Logout"] tap];
    
    XCUIElementQuery *tabBarsQuery = app.tabBars;
    [tabBarsQuery.buttons[@"Settings"] tap];
    
    XCUIElementQuery *tablesQuery = app.tables;
    [tablesQuery.cells.staticTexts[@"Login"] tap];
    
    XCUIElement *enterYourEmailIdTextField = app.textFields[@"Enter your Email Id"];
    [enterYourEmailIdTextField tap];
    [enterYourEmailIdTextField typeText:@"test5@test5.com"];
    
    XCUIElement *enterYourPasswordSecureTextField = app.secureTextFields[@"Enter Your Password"];
    [enterYourPasswordSecureTextField tap];
    [enterYourPasswordSecureTextField typeText:@"password"];
    [app.buttons[@"Login"] tap];
    [tabBarsQuery.buttons[@"My Tools"] tap];
    
    XCUIElement *myToolsNavigationBar = app.navigationBars[@"My Tools"];
    [myToolsNavigationBar.buttons[@"Add"] tap];
    [[[[[app childrenMatchingType:XCUIElementTypeWindow] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeOther].element tap];
    
    [app.sheets.collectionViews.buttons[@"Choose Photo"] tap];
    [tablesQuery.buttons[@"Camera Roll"] tap];
    [app.collectionViews.cells[@"Photo, Landscape, August 08, 2012, 2:55 PM"] tap];
    
    XCUIElement *enterToolNameTextField = app.textFields[@"Enter Tool Name"];
    [enterToolNameTextField tap];
    [enterToolNameTextField typeText:@"second tool"];
    [app.navigationBars[@"Add Tool"].buttons[@"Done"] tap];
    [myToolsNavigationBar.buttons[@"Refresh"] tap];
    [tablesQuery.staticTexts[@"Available"] tap];
    [app.buttons[@"Delete Tool"] tap];
    
    [NSThread sleepForTimeInterval:2];
    
    [app.buttons[@"Cancel"] tap];
    [tablesQuery.staticTexts[@"Logout"] tap];
}

- (void)testChangeMyToolStatus {
    
    XCUIApplication *app = [[XCUIApplication alloc] init];
    [app.tabBars.buttons[@"Settings"] tap];
    [app.tables.staticTexts[@"Register"] tap];
    
    XCUIElement *enterYourFirstNameTextField = app.textFields[@"Enter Your First Name"];
    [enterYourFirstNameTextField tap];
    [enterYourFirstNameTextField typeText:@"Asheesh"];
    
    XCUIElement *enterYourLastNameTextField = app.textFields[@"Enter Your Last Name"];
    [enterYourLastNameTextField tap];
    [enterYourLastNameTextField typeText:@"Agarwal"];
    
    XCUIElement *enterYourValidEmailIdTextField = app.textFields[@"Enter Your Valid Email Id"];
    [enterYourValidEmailIdTextField tap];
    [enterYourValidEmailIdTextField typeText:@"test6@test6.com"];
    
    XCUIElement *chooseAStrongPasswordSecureTextField = app.secureTextFields[@"Choose a Strong Password"];
    [chooseAStrongPasswordSecureTextField tap];
    [chooseAStrongPasswordSecureTextField typeText:@"password"];
    
    XCUIElement *reEnterTheAbovePasswordSecureTextField = app.secureTextFields[@"Re-enter the Above Password"];
    [reEnterTheAbovePasswordSecureTextField tap];
    [reEnterTheAbovePasswordSecureTextField typeText:@"password"];
    [[[app childrenMatchingType:XCUIElementTypeWindow] elementBoundByIndex:0].buttons[@"Join"] tap];
    
    [app.tables.staticTexts[@"Logout"] tap];
    
    XCUIElementQuery *tabBarsQuery = app.tabBars;
    XCUIElement *settingsButton = tabBarsQuery.buttons[@"Settings"];
    [settingsButton tap];
    
    XCUIElementQuery *tablesQuery = app.tables;
    [tablesQuery.staticTexts[@"Login"] tap];
    
    XCUIElement *enterYourEmailIdTextField = app.textFields[@"Enter your Email Id"];
    [enterYourEmailIdTextField tap];
    [enterYourEmailIdTextField typeText:@"test6@test6.com"];
    
    XCUIElement *enterYourPasswordSecureTextField = app.secureTextFields[@"Enter Your Password"];
    [enterYourPasswordSecureTextField tap];
    [enterYourPasswordSecureTextField typeText:@"password"];
    [app.buttons[@"Login"] tap];
    [tabBarsQuery.buttons[@"My Tools"] tap];
    
    XCUIElement *myToolsNavigationBar = app.navigationBars[@"My Tools"];
    [myToolsNavigationBar.buttons[@"Add"] tap];
    [[[[[app childrenMatchingType:XCUIElementTypeWindow] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeOther].element tap];
    [app.sheets.collectionViews.buttons[@"Choose Photo"] tap];
    [tablesQuery.buttons[@"Camera Roll"] tap];
    [app.collectionViews.cells[@"Photo, Landscape, August 08, 2012, 2:55 PM"] tap];
    
    XCUIElement *enterToolNameTextField = app.textFields[@"Enter Tool Name"];
    [enterToolNameTextField tap];
    [enterToolNameTextField typeText:@"third tool"];
    [app.navigationBars[@"Add Tool"].buttons[@"Done"] tap];
    [myToolsNavigationBar.buttons[@"Refresh"] tap];
    [tablesQuery.staticTexts[@"third tool"] tap];
    [app.buttons[@"Mark as Unavailable"] tap];
    [NSThread sleepForTimeInterval:2];
    
    [app.buttons[@"Mark as Available"] tap];
    [NSThread sleepForTimeInterval:2];
    
    [app.navigationBars[@"MyToolDetailsView"].buttons[@"My Tools"] tap];
    [settingsButton tap];
    [tablesQuery.staticTexts[@"Logout"] tap];
}

- (void)testViewPublicTools {
    
    XCUIApplication *app = [[XCUIApplication alloc] init];
    XCUIElementQuery *tabBarsQuery = app.tabBars;
    XCUIElement *settingsButton = tabBarsQuery.buttons[@"Settings"];
    [settingsButton tap];
    
    XCUIElementQuery *tablesQuery = app.tables;
    XCUIElement *registerStaticText = tablesQuery.staticTexts[@"Register"];
    [registerStaticText tap];
    
    XCUIElement *enterYourFirstNameTextField = app.textFields[@"Enter Your First Name"];
    [enterYourFirstNameTextField tap];
    [enterYourFirstNameTextField typeText:@"Public"];
    
    XCUIElement *enterYourLastNameTextField = app.textFields[@"Enter Your Last Name"];
    [enterYourLastNameTextField tap];
    [enterYourLastNameTextField typeText:@"1"];
    
    XCUIElement *enterYourValidEmailIdTextField = app.textFields[@"Enter Your Valid Email Id"];
    [enterYourValidEmailIdTextField tap];
    [enterYourValidEmailIdTextField typeText:@"public1@gmail.com"];
    
    XCUIElement *chooseAStrongPasswordSecureTextField = app.secureTextFields[@"Choose a Strong Password"];
    [chooseAStrongPasswordSecureTextField tap];
    [chooseAStrongPasswordSecureTextField typeText:@"password"];
    
    XCUIElement *reEnterTheAbovePasswordSecureTextField = app.secureTextFields[@"Re-enter the Above Password"];
    [reEnterTheAbovePasswordSecureTextField tap];
    [reEnterTheAbovePasswordSecureTextField typeText:@"password"];
    
    XCUIElement *window = [[app childrenMatchingType:XCUIElementTypeWindow] elementBoundByIndex:0];
    XCUIElement *joinButton = window.buttons[@"Join"];
    [joinButton tap];
    [tabBarsQuery.buttons[@"My Tools"] tap];
    
    XCUIElement *myToolsNavigationBar = app.navigationBars[@"My Tools"];
    [myToolsNavigationBar.buttons[@"Add"] tap];
    [[[[window childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:2] childrenMatchingType:XCUIElementTypeOther].element tap];
    [app.sheets.collectionViews.buttons[@"Choose Photo"] tap];
    [[[tablesQuery.cells containingType:XCUIElementTypeStaticText identifier:@"10"] childrenMatchingType:XCUIElementTypeTextField].element tap];
    [app.collectionViews.cells[@"Photo, Landscape, October 09, 2009, 2:09 PM"] tap];
    
    XCUIElement *enterToolNameTextField = app.textFields[@"Enter Tool Name"];
    [enterToolNameTextField tap];
    [enterToolNameTextField typeText:@"public1 tool1"];
    [app.navigationBars[@"Add Tool"].buttons[@"Done"] tap];
    [NSThread sleepForTimeInterval:2];
    
    [myToolsNavigationBar.buttons[@"Refresh"] tap];
    [tablesQuery.staticTexts[@"public1 tool1"] tap];
    
    XCUIElement *myToolsButton = app.navigationBars[@"MyToolDetailsView"].buttons[@"My Tools"];
    [myToolsButton tap];
    [settingsButton tap];
    
    XCUIElement *logoutStaticText = tablesQuery.staticTexts[@"Logout"];
    [logoutStaticText tap];
    [registerStaticText tap];
    [enterYourFirstNameTextField tap];
    [enterYourFirstNameTextField typeText:@"Public"];
    [enterYourLastNameTextField tap];
    [enterYourLastNameTextField typeText:@"2"];
    [enterYourValidEmailIdTextField tap];
    [enterYourValidEmailIdTextField typeText:@"public2@gmail.com"];
    [chooseAStrongPasswordSecureTextField tap];
    [chooseAStrongPasswordSecureTextField typeText:@"password"];
    [reEnterTheAbovePasswordSecureTextField tap];
    [reEnterTheAbovePasswordSecureTextField typeText:@"password"];
    [joinButton tap];
    [tabBarsQuery.buttons[@"Public Tools"] tap];
    [tablesQuery.staticTexts[@"public1 tool1"] tap];

    [app.navigationBars[@"Tool Details"].buttons[@"Public Tools"] tap];
    [settingsButton tap];
    [logoutStaticText tap];
    
}


@end
