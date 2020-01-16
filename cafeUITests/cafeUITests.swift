//
//  cafeUITests.swift
//  cafeUITests
//
//  Created by 楊仁翰 on 2020/1/16.
//  Copyright © 2020 Renhen Yang. All rights reserved.
//

import XCTest

class cafeUITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        
        app.launch()
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        
       
        app.buttons.containing(.staticText, identifier:"登入").element.tap()
        app.buttons["開始點餐"].tap()
        
        let tablesQuery = app.tables
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["香草拿鐵"]/*[[".cells.staticTexts[\"香草拿鐵\"]",".staticTexts[\"香草拿鐵\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.scrollViews.otherElements.buttons["現在預訂"].tap()
        XCUIDevice.shared.orientation = .portrait
        XCUIDevice.shared.orientation = .faceUp
        
        let button = app.buttons["確認"]
        button.tap()
        XCUIDevice.shared.orientation = .portrait
        tablesQuery/*@START_MENU_TOKEN@*/.buttons["Increment"]/*[[".cells.buttons[\"Increment\"]",".buttons[\"Increment\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        XCUIDevice.shared.orientation = .faceUp
        button.tap()
        XCUIDevice.shared.orientation = .portrait
        app.buttons["訂單確認"].tap()
        XCUIDevice.shared.orientation = .faceUp
        XCUIDevice.shared.orientation = .portrait
        app.alerts["您確定要送出訂單了嗎？"].scrollViews.otherElements.buttons["ok"].tap()
        XCUIDevice.shared.orientation = .faceUp
        XCUIDevice.shared.orientation = .portrait
        XCUIDevice.shared.orientation = .faceUp
        
        
    }

    func testLaunchPerformance() {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
}
