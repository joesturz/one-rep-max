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
    let i1 = WorkoutInstance(date: date, set: 1, reps: 2, weight: 20)
    let i2 = WorkoutInstance(date: date, set: 1, reps: 2, weight: 30)
    workout.workoutInstances[date] = [i1, i2]
    guard let instances = workout.workoutInstances[date] else {
      XCTFail()
      return
    }
    let expected = 2
    let result = instances.count
    XCTAssertEqual(expected, result)
  }
  
  func testWorkoutInstancesOneRepMax1() {
    let date = Date()
    let i1 = WorkoutInstance(date: date, set: 1, reps: 1, weight: 250)
    let result = i1.oneRepMax()
    let expected = 250

    XCTAssertEqual(expected, result)
  }
  
  func testWorkoutInstancesOneRepMax2() {
    let date = Date()
    let i1 = WorkoutInstance(date: date, set: 1, reps: 2, weight: 250)
    let result = i1.oneRepMax()
    let expected = 257

    XCTAssertEqual(expected, result)
  }
  
  func testWorkoutAverageOneRepMax() {
    let date = Date()
    var workout = Workout(name: "Workout 1")
    let i1 = WorkoutInstance(date: date, set: 1, reps: 2, weight: 300)
    let i2 = WorkoutInstance(date: date, set: 1, reps: 2, weight: 250)
    workout.workoutInstances[date] = [i1, i2]
    guard let _ = workout.workoutInstances[date] else {
      XCTFail()
      return
    }
    let expected = 308
    let result = workout.getAverageOneRepMax()
    XCTAssertEqual(expected, result)
  }
  
  func testWorkoutAverageOneRepMax2() {
    let date = Date()
    let date2 = ImportData.getDate(from: "Oct 22 2020")!
    var workout = Workout(name: "Workout 1")
    let i1 = WorkoutInstance(date: date, set: 1, reps: 2, weight: 300)
    let i2 = WorkoutInstance(date: date, set: 1, reps: 2, weight: 250)
    
    let i3 = WorkoutInstance(date: date2, set: 1, reps: 2, weight: 700)
    let i4 = WorkoutInstance(date: date2, set: 1, reps: 2, weight: 250)
    workout.workoutInstances[date] = [i1, i2]
    workout.workoutInstances[date2] = [i3, i4]
    guard let _ = workout.workoutInstances[date] else {
      XCTFail()
      return
    }
    guard let _ = workout.workoutInstances[date2] else {
      XCTFail()
      return
    }
    let expected = 513
    let result = workout.getAverageOneRepMax()
    XCTAssertEqual(expected, result)
  }
  
  func testWorkoutGetOneRepMaxPerDay() {
    let date = Date()
    let date2 = ImportData.getDate(from: "Oct 22 2020")!
    var workout = Workout(name: "Workout 1")
    
    let i1 = WorkoutInstance(date: date, set: 1, reps: 2, weight: 300)
    let i2 = WorkoutInstance(date: date, set: 1, reps: 2, weight: 250)
    
    let i3 = WorkoutInstance(date: date, set: 1, reps: 10, weight: 45)
    let i4 = WorkoutInstance(date: date, set: 1, reps: 8, weight: 95)
    let i5 = WorkoutInstance(date: date2, set: 1, reps: 8, weight: 155)
    let i6 = WorkoutInstance(date: date2, set: 1, reps: 8, weight: 155)
    let i7 = WorkoutInstance(date: date2, set: 1, reps: 7, weight: 155)

    
    workout.workoutInstances[date] = [i1, i2]
    workout.workoutInstances[date2] = [i3, i4, i5, i6, i7]
    guard let _ = workout.workoutInstances[date] else {
      XCTFail()
      return
    }
    guard let _ = workout.workoutInstances[date2] else {
      XCTFail()
      return
    }
    let result = workout.getOneRepMaxPerDay()
    let expectedMaxReps1 = 192
    let expectedMaxReps2 = 308
    let expectedCount = 2
    let resultCount = result.count
    XCTAssertEqual(expectedCount, resultCount)
    XCTAssertEqual(expectedMaxReps1, result[0].maxRep)
    XCTAssertEqual(expectedMaxReps2, result[1].maxRep)
  }
  
  func testGetMinMaxOfMax() {
    let date = Date()
    let date2 = ImportData.getDate(from: "Oct 22 2020")!
    var workout = Workout(name: "Workout 1")
    
    let i1 = WorkoutInstance(date: date, set: 1, reps: 2, weight: 300)
    let i2 = WorkoutInstance(date: date, set: 1, reps: 2, weight: 250)
    
    let i3 = WorkoutInstance(date: date, set: 1, reps: 10, weight: 45)
    let i4 = WorkoutInstance(date: date, set: 1, reps: 8, weight: 95)
    let i5 = WorkoutInstance(date: date2, set: 1, reps: 8, weight: 155)
    let i6 = WorkoutInstance(date: date2, set: 1, reps: 8, weight: 155)
    let i7 = WorkoutInstance(date: date2, set: 1, reps: 7, weight: 155)

    
    workout.workoutInstances[date] = [i1, i2]
    workout.workoutInstances[date2] = [i3, i4, i5, i6, i7]
    guard let _ = workout.workoutInstances[date] else {
      XCTFail()
      return
    }
    guard let _ = workout.workoutInstances[date2] else {
      XCTFail()
      return
    }
    let result = workout.getMinMaxOfMax()
    let expectedMin = 192
    let expectedMax = 308
    XCTAssertEqual(expectedMin, result.min)
    XCTAssertEqual(expectedMax, result.max)
  }
  
  func testGetDate() {
    let formatter = DateFormatter()
    formatter.dateFormat = "MMM dd yyyy"
    let expected = formatter.date(from: "Oct 22 2020")
    
    let result = ImportData.getDate(from: "Oct 22 2020")
    XCTAssertEqual(expected, result)
  }
}
