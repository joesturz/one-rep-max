//
//  TestImporter.swift
//  One Rep MaxTests
//
//  Created by Joe Sturzenegger on 3/17/23.
//

import XCTest
@testable import One_Rep_Max

final class TestImporter: XCTestCase {
  
  func testImportDataKeys() {
    let data = ImportData.from()
    let result = data.count
    let expected = 3
    XCTAssertEqual(result, expected)
  }
  
  func testImportedWorkouts() {
    let data = ImportData.from()
    guard let firstWorkout = data.first else {
      XCTFail()
      return
    }
    XCTAssertEqual(30, firstWorkout.workoutInstances.count)
  }
}
