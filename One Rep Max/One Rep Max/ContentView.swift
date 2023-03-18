//
//  ContentView.swift
//  One Rep Max
//
//  Created by Joe Sturzenegger on 3/17/23.
//

import SwiftUI

struct ContentView: View {
  var workouts:[Workout] = ImportData.from(fileName: "NEW_FILE_NAME")
  @Environment(\.colorScheme) var colorScheme
  
  var body: some View {
    NavigationStack {
      Spacer(minLength: 50)
      List {
        ForEach(workouts) { workout in
          WorkoutCell(workout: workout)
        }
      }.listStyle(.plain)
    }.accentColor(colorScheme == .dark ? Color.white : Color.black)
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView(workouts: testData)
  }
}

struct WorkoutCell: View {
  var workout: Workout
  var body: some View {
    NavigationLink(destination: WorkoutDetail(workout: workout)) {
      VStack(alignment: .leading) {
        HStack {
          Text(workout.name).font(.title2).multilineTextAlignment(.leading)
          Spacer()
          Text("\(workout.getAverageOneRepMax())").font(.title).multilineTextAlignment(.trailing)
        }
        HStack(alignment: .center) {
          Text("One Rep Max")
            .font(.subheadline)
            .foregroundColor(.secondary)
          Text("•")
            .font(.subheadline)
            .foregroundColor(.secondary)
          Text("lbs")
            .font(.subheadline)
            .foregroundColor(.secondary)
        }
      }
    }.navigationTitle("")
  }
}
