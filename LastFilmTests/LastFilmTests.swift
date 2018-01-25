//
//  LastFilmTests.swift
//  LastFilmTests
//
//  Created by Semen Nikulin on 1/25/18.
//  Copyright © 2018 niksemv. All rights reserved.
//

import XCTest
@testable import LastFilm
import AEXML

class LastFilmTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testLoadFilms() {
        let expectation = self.expectation(description: "Download films")
        WebService.loadLastFilms { result in
            switch result {
            case .success(let films):
                 XCTAssertTrue(films.count > 0)
            case .failure(let error):
                XCTAssertFalse(true, "Loading with \(error)")
            }
            expectation.fulfill()
        }

         waitForExpectations(timeout: 7)
    }

    func testParseRss() {
        let rss = "<item> <title> Хороший доктор (The Good Doctor). Семь причин. (S01E13) </title> . <description> <![CDATA[ <img src=\"///static.lostfilm.tv/Images/348/Posters/image.jpg/\" alt=\"\" /><br /> ]]> </description> <pubDate>Wed, 24 Jan 2018 17:56:41 +0000</pubDate> <link> https://lostfilm.tv/series/The_Good_Doctor/season_1/episode_13/ </link> </item>"

        if let xmlDoc = try? AEXMLDocument(xml: rss) {
            let xmlFilm = xmlDoc["item"]
            let film = Film(xmlElement: xmlFilm)
            print(film.imageUrl)
            XCTAssertTrue(film.title == "Хороший доктор (The Good Doctor). Семь причин. (S01E13)"
                && film.link == "https://lostfilm.tv/series/The_Good_Doctor/season_1/episode_13/"
                && film.imageUrl == "http:///static.lostfilm.tv/Images/348/Posters/image.jpg/")
        } else {
            XCTAssertFalse(true, "Error parse")
        }
    }
}
