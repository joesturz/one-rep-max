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
  
  func getAverageWeight() -> Int {
    let totalDays = workoutInstances.keys.count
    var totalWeight = 0
    for( _, instances) in workoutInstances {
      let weights = instances.map { i in
        i.oneRepMax()
      }
      totalWeight += weights.max() ?? 0
    }
    let avg = totalWeight / totalDays
    return avg
  }
  
  func getMaxReps() -> [MaxRepOnDate] {
    var result = [MaxRepOnDate]()
    let workoutInst = workoutInstances.sorted(by: { $0.0 < $1.0 })
    for(date, instances) in workoutInst {
      let weights = instances.map { i in
        i.oneRepMax()
      }
      result.append(MaxRepOnDate(date: date, maxRep: weights.max() ?? 0))
      print("date: \(date), max: \(weights.max() ?? 0)")
    }
    return result
  }
  
}

struct WorkoutInstance: Identifiable {
  var id = UUID()
  var date: Date
  var max: Int
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

struct MaxRepOnDate: Identifiable {
  var id = UUID()
  var date: Date
  var maxRep: Int
}




let testData = makeTestData()

func makeTestData() -> [Workout] {
  let i1 =  WorkoutInstance(date: Date(), max: 1, reps: 2, weight: 20)
  let i2 =  WorkoutInstance(date: Date(), max: 1, reps: 2, weight: 30)
  let i3 =  WorkoutInstance(date: Date(), max: 1, reps: 2, weight: 100)
  let i4 =  WorkoutInstance(date: Date(), max: 1, reps: 2, weight: 150)

  var w1 = Workout(name: "Workout 1")
  var w2 = Workout(name: "Workout 2")
  w1.workoutInstances[i1.date] = [i1, i2]
  w2.workoutInstances[i3.date] = [i3, i4]

  
  return [w1, w2]
}

let testData2 = ImportData.fromFile().sorted(by: { $0.0 < $1.0 }).map { _, workout in
  workout
}

