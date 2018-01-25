//
//  OpenFilm.swift
//  LastFilmUITests
//
//  Created by Semen Nikulin on 1/25/18.
//  Copyright © 2018 niksemv. All rights reserved.
//

import XCTest


class OpenFilm: XCTestCase {
        
    var app: XCUIApplication!

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments.append("--uitesting")
    }

    func waitFilms(_ element: XCUIElement) {
        let existsPredicate = NSPredicate(format: "exists == true")
        expectation(for: existsPredicate, evaluatedWith: element, handler: nil)
        waitForExpectations(timeout: 7, handler: nil)
    }

    func addExpectation(with time: TimeInterval, complete: @escaping () -> Void) {
        let exp = self.expectation(description: "wait")
        DispatchQueue.main.asyncAfter(deadline: .now() + time) {
            complete()
            exp.fulfill()
        }
        waitForExpectations(timeout: time + 2)
    }

    func testOpenFilm() {
        app.launch()
        self.waitFilms(app.tables.firstMatch.cells.firstMatch)
        XCTAssertTrue(app.tables.firstMatch.cells.firstMatch.exists)

        addExpectation(with: 1) {
            self.app.tables.firstMatch.cells.firstMatch.tap()
        }

        addExpectation(with: 1) {
            XCTAssertTrue(self.app.otherElements["DetailFilmViewController"].exists)
        }

        addExpectation(with: 1) {
            self.app.buttons["Last films"].tap()
        }

        addExpectation(with: 1) {
            XCTAssertTrue(self.app.otherElements["LastFilmViewController"].exists)
        }
    }
    
}
