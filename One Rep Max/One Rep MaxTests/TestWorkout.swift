//
//  TestWorkout.swift
//  One Rep MaxTests
//
//  Created by Joe Sturzenegger on 3/17/23.
//

import XCTest
@testable import One_Rep_Max

final class TestWorkout: XCTestCase {

  
  func testWorkoutInstances() {
    let date = Date()
    var workout = Workout(name: "Workout 1")
    let i1 = WorkoutInstance(date: date, max: 1, reps: 2, weight: 20)
    let i2 = WorkoutInstance(date: date, max: 1, reps: 2, weight: 30)
    workout.workoutInstances[date] = [i1, i2]
    guard let instances = workout.workoutInstances[date] else {
      XCTFail()
      return
    }
    let expected = 2
    let result = instances.count
    XCTAssertEqual(expected, result)
  }
  
  func testWorkoutAvgWeight() {
    let date = Date()
    var workout = Workout(name: "Workout 1")
    let i1 = WorkoutInstance(date: date, max: 1, reps: 2, weight: 20)
    let i2 = WorkoutInstance(date: date, max: 1, reps: 2, weight: 30)
    workout.workoutInstances[date] = [i1, i2]
    guard let _ = workout.workoutInstances[date] else {
      XCTFail()
      return
    }
    let expected = 25
    let result = workout.getAverageWeight()
    XCTAssertEqual(expected, result)
  }
  
  func testGetDate() {
    let formatter = DateFormatter()
    formatter.dateFormat = "MMM dd yyyy"
    let expected = formatter.date(from: "Oct 22 2020")
    
    let result = ImportData.getDate(from: "Oct 22 2020")
    XCTAssertEqual(expected, result)
  }
}
