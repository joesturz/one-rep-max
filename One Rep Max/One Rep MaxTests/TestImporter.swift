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
    let data = ImportData.fromFile()
    let keys = data.keys
    let result = keys.count
    let expected = 3
    XCTAssertEqual(result, expected)
  }
  
  func testImportedWorkouts() {
    let data = ImportData.fromFile()
    let firstWorkout = data[data.keys.first!]!
    XCTAssertEqual(28, firstWorkout.workoutInstances.count)
  }

}
