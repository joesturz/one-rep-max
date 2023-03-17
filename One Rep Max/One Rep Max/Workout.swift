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
    var totalInstances = 0
    var totalWeight = 0
    for( _, instances) in workoutInstances {
      totalInstances += instances.count
      let weights = instances.map { i in
        i.weight
      }
      totalWeight += weights.reduce(0, +)
    }
    if totalInstances == 0 {
      return 0
    }
    let avg = totalWeight / totalInstances
    return avg
  }
  
}

struct WorkoutInstance {
  var date: Date
  var max: Int
  var reps: Int
  var weight: Int
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

let testData2 = ImportData.fromFile().map { _, workout in
  workout
}

