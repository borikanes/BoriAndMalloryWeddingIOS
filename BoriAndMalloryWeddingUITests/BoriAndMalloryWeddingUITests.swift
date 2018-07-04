//
//  BoriAndMalloryWeddingUITests.swift
//  BoriAndMalloryWeddingUITests
//
//  Created by Bori Oludemi on 4/15/18.
//  Copyright © 2018 borikanes. All rights reserved.
//

import XCTest

class BoriAndMalloryWeddingUITests: XCTestCase {
    let app = XCUIApplication()

    override func setUp() {
        super.setUp()

        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testOrchestrate() {
        testTabBarsExists()
        testHomeUIElements()
        testSeatingInfoVC()
        testScheduleVC()
    }

    func testTabBarsExists() {
        XCTAssert(app.tabBars.buttons["Seating"].exists)
        XCTAssert(app.tabBars.buttons["Home"].exists)
        XCTAssert(app.tabBars.buttons["Food"].exists)
        XCTAssert(app.tabBars.buttons["Schedule"].exists)
    }

    func testHomeUIElements() {
        app.tabBars.buttons["Home"].tap()
        let elementsQuery = app.scrollViews.otherElements
        XCTAssert(elementsQuery.staticTexts["Time to wedding day"].exists)
        XCTAssert(elementsQuery.staticTexts["College Park"].exists)
        XCTAssert(elementsQuery.staticTexts["&"].exists)
        XCTAssert(elementsQuery.staticTexts["Laurel, MD"].exists)
        XCTAssert(elementsQuery.staticTexts["September"].exists)
        XCTAssert(elementsQuery.staticTexts["22"].exists)
        XCTAssert(elementsQuery.staticTexts["#maluwabori"].exists)
        XCTAssert(app.staticTexts["Bori & Mallory"].exists)
        
    }

    func testScheduleVC() {
        app.tabBars.buttons["Schedule"].tap()
        let elementsQuery = app.scrollViews.otherElements

        XCTAssert(app/*@START_MENU_TOKEN@*/.staticTexts["11:00am"]/*[[".scrollViews.staticTexts[\"11:00am\"]",".staticTexts[\"11:00am\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.exists)
        XCTAssert(elementsQuery.staticTexts["Church ceremony"].exists)
        XCTAssert(elementsQuery.staticTexts["UMD Chapel"].exists)

        XCTAssert(app/*@START_MENU_TOKEN@*/.staticTexts["12:30pm"]/*[[".scrollViews.staticTexts[\"12:30pm\"]",".staticTexts[\"12:30pm\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.exists)
        XCTAssert(elementsQuery.staticTexts["Hors d’oeuvres / snacks"].exists)

        XCTAssert(app/*@START_MENU_TOKEN@*/.staticTexts["02:00pm"]/*[[".scrollViews.staticTexts[\"02:00pm\"]",".staticTexts[\"02:00pm\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.exists)
        XCTAssert(elementsQuery.staticTexts["Nigerian traditional ceremony"].exists)

        XCTAssert(app/*@START_MENU_TOKEN@*/.staticTexts["04:00pm"]/*[[".scrollViews.staticTexts[\"04:00pm\"]",".staticTexts[\"04:00pm\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.exists)
        XCTAssert(elementsQuery.staticTexts["Lunch & Reception"].exists)
    }

    func testSeatingInfoVC() {
        app.tabBars.buttons["Seating"].tap()
        XCTAssert(app.otherElements["seating search bar"].exists)
        XCTAssert(app.searchFields["Search for your name"].exists)
        XCTAssert(app.staticTexts["Seating Info"].exists)
        XCUIApplication().tabBars.buttons["Seating"].tap()
                
    }
}
