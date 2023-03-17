//
//  ImportData.swift
//  One Rep Max
//
//  Created by Joe Sturzenegger on 3/17/23.
//

import Foundation

class ImportData {
  
  static func fromFile() -> [String: Workout] {
    var rawData = [String: Workout]()
    guard let filepath = Bundle.main.path(forResource: "workoutData", ofType: "txt") else {
      return [:]
    }
    var data = ""
    do {
        data = try String(contentsOfFile: filepath)
    } catch {
        print(error)
      return [:]
    }
    let rows = data.components(separatedBy: "\n")
    for row in rows {
      let columns = row.components(separatedBy: ",")
      guard let date = getDate(from: columns[0]) else {
        continue
      }
      let name = columns[1]
      let instance = WorkoutInstance(date: date, max: Int(columns[2]) ?? 1, reps: Int(columns[3]) ?? 1, weight: Int(columns[4]) ?? 0 )
      if var workout = rawData[name] {
        if var instances = workout.workoutInstances[date] {
          instances.append(instance)
        } else {
          workout.workoutInstances[date] = [instance]
        }
        rawData[name] = workout
      } else {
        var workout = Workout(name: name)
        workout.workoutInstances[date] = [instance]
        rawData[name] = workout
      }
      
    }
    return rawData
  }
  
  static func getDate(from text: String) -> Date? {
    let formatter = DateFormatter()
    formatter.dateFormat = "MMM dd yyyy"
    let someDateTime = formatter.date(from: text)
    return someDateTime
  }
  
}
