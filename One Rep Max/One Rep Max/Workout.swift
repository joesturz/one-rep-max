//
//  Workout.swift
//  One Rep Max
//
//  Created by Joe Sturzenegger on 3/17/23.
//

import Foundation

struct Workout: Identifiable {
  var id = UUID()
  var name: String
  var workoutInstances: [Date : [WorkoutInstance]] = [:]
  
  func getAverageOneRepMax() -> Int {
    var maxWeights: [Int] = []
    for k in workoutInstances.keys {
      if let instances = workoutInstances[k] {
        let weights = instances.map { i in
          i.oneRepMax()
        }
        if let max = weights.max() {
          maxWeights.append(max)
        }
      }
    }
    let total = maxWeights.reduce(0, +)
    let avg = Double(total) / Double(maxWeights.count)
    return Int(avg)
  }
  
  func getOneRepMaxPerDay() -> [OneRepMaxForDate] {
    var result = [OneRepMaxForDate]()
    let workoutInst = workoutInstances.sorted(by: { $0.0 < $1.0 })
    for(date, instances) in workoutInst {
      let weights = instances.map { i in
        i.oneRepMax()
      }
      result.append(OneRepMaxForDate(date: date, maxRep: weights.max() ?? 0))
    }
    result = result.sorted(by: { $0.date < $1.date })
    return result
  }
  
  func getMinMaxOfMax() -> (min: Int, max:Int) {
    let arr = getOneRepMaxPerDay()
    let result = arr.map { orm in
      orm.maxRep
    }
    return (result.min() ?? 0, result.max() ?? 0)
  }
  
  
}

struct WorkoutInstance: Identifiable {
  var id = UUID()
  var date: Date
  var set: Int
  var reps: Int
  var weight: Int
  
  //calculates the 1 rep max using the Brzycki Formula
  func oneRepMax() -> Int {
    var r = 0.0
    if reps < 37 {
      r = 36.0/(37.0 - Double(reps))
    }
    let result = Double(weight) * r
    return Int(result)
  }
}

struct OneRepMaxForDate: Identifiable {
  var id = UUID()
  var date: Date
  var maxRep: Int
}

let testData = ImportData.from()

