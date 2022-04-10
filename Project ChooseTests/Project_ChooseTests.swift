//
//  Project_ChooseTests.swift
//  Project ChooseTests
//
//  Created by Felix Habib on 24/3/2022.
//

import XCTest
@testable import Project_Choose

class Project_ChooseTests: XCTestCase {
    
    var pchoose: PChoose!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        pchoose = PChoose()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        pchoose = nil
    }
    
    func testRestart() {
        pchoose.startNewRound()
        XCTAssertNotEqual(pchoose.round, 1)
        XCTAssertNotEqual(pchoose.history.count, 1)
        pchoose.restart()
        XCTAssertEqual(pchoose.round, 1)
        XCTAssertEqual(pchoose.history.count, 1)
        XCTAssertEqual(pchoose.finished, false)
        
    }

}
